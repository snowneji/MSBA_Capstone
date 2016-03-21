require(data.table)
require(tm)
require(slam)
require(RWeka)
require(Matrix)
require(xgboost)
require(caret)

data = fread('train_df.csv',header = T,data.table = F)
data = data[,c(5,6)]
desc = data$desc
# basic cleaning:
source('basic_cleaning.R')
desc = basic_clean(desc)
desc = sapply(desc, function(x){iconv(x, "latin1", "ASCII", sub="")})
desc = data.frame(desc)
#Corpus and cleaning
myCorpus = Corpus(DataframeSource(desc))
myCorpus = tm_map(myCorpus, content_transformer(tolower))
myCorpus = tm_map(myCorpus, content_transformer(removeNumbers))
myCorpus = tm_map(myCorpus, content_transformer(removeWords), stopwords('english'))
stop2 = as.vector(stopwords('SMART'))
myCorpus = tm_map(myCorpus, content_transformer(removeWords),stop2) 
myCorpus = tm_map(myCorpus, stemDocument)
myCorpus = tm_map(myCorpus, content_transformer(stripWhitespace))
myCorpus = tm_map(myCorpus, content_transformer(PlainTextDocument))
options(mc.cores=1)
ngramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min=1, max=3))
dtm = DocumentTermMatrix(myCorpus,control=list(tokenize =ngramTokenizer)) 
dtm2 = removeSparseTerms(dtm,sparse = 0.96)
text_agg = function(dtm){
        dtm2 = as.data.frame(as.matrix(dtm2))
        dtm2        
}
train_data = text_agg(dtm2)
train_data$trainning_label = data$target
train_data[train_data$trainning_label=='data scientist',]$trainning_label = 0
train_data[train_data$trainning_label=='data analyst',]$trainning_label = 1
train_data[train_data$trainning_label=='business analyst',]$trainning_label = 2
train_data[train_data$trainning_label=='data engineer',]$trainning_label = 3
#rearrange
#targetnum = which(names(train_data)=='trainning_label')
#train_data = train_data[c(1:(targetnum-1),(targetnum+1):ncol(train_data),targetnum)]


#### train data
iftrain=createDataPartition(train_data$trainning_label,p = 0.87,list = F)
train = train_data[iftrain,]
vali = train_data[-iftrain,]
#
train2 = train[,-ncol(train)] %>% as.matrix
label = train$trainning_label
vali2 = vali[,-ncol(vali)] %>% as.matrix
result = vali$trainning_label
#model
param <- list("objective" = "multi:softprob",
              "eval_metric" = "mlogloss",
              "eta" = 0.2,
              "num_class" = 4)

bst.cv = xgb.cv(param=param,label=label, data = train2, nfold = 5, nrounds = 100,nthread=4,early.stop.round = 5)
                           
#best: trigram:
#0.95: accu:0.7225
#0.96, accu:0.7361
#0.97, accu:0.7319
#0.98, accu:0.7301

#with new words removed:
#0.96sparseremove,eta0.2 accu 0.7404

set.seed(1028)
md = xgboost(param=param,label=label, data = train2,nrounds = 37,nthread=4,verbose = T)

res = predict(md,vali2)
res_data<-matrix(res,nrow=4,ncol=1171)
res_data<-as.data.frame(res_data)
row.names(res_data)<-c(0,1,2,3)
res_data<-t(res_data)
new_res<-apply(res_data,1, function(x) names(sort(x,decreasing = T))[1] )
confusionMatrix(new_res,reference = result)

##################### testing data cleaning
test = fread('test_df.csv',header = T,data.table = F)
test_data = data.frame(desc=test$resume_desc)
test_data$desc = basic_clean(test_data$desc)
test_data$desc = sapply(test_data$desc, function(x){iconv(x, "latin1", "ASCII", sub="")})
# corpus and cleaning
myCorpus = Corpus(DataframeSource(test_data))
myCorpus = tm_map(myCorpus, content_transformer(tolower))
myCorpus = tm_map(myCorpus, content_transformer(removeNumbers))
myCorpus = tm_map(myCorpus, content_transformer(removeWords), stopwords('english'))
stop2 = as.vector(stopwords('SMART'))
myCorpus = tm_map(myCorpus, content_transformer(removeWords),stop2) 
myCorpus = tm_map(myCorpus, stemDocument)
myCorpus = tm_map(myCorpus, content_transformer(stripWhitespace))
myCorpus = tm_map(myCorpus, content_transformer(PlainTextDocument))
options(mc.cores=1)
ngramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min=1, max=3))
dtm = DocumentTermMatrix(myCorpus,control=list(tokenize =ngramTokenizer)) 

text_agg = function(dtm){
        dtm2 = as.data.frame(as.matrix(dtm))
        dtm2        
}

test_data2 = text_agg(dtm)
test_data3 = test_data2[,which(names(test_data2) %in% names(train))] %>% as.matrix

final_test_res = predict(md,test_data3)
final_res_data<-matrix(final_test_res,nrow=4,ncol=nrow(test_data3))
final_res_data<-as.data.frame(final_res_data)
row.names(final_res_data)<-c(0,1,2,3)
final_res_data<-t(final_res_data)
final_res_data <- round(final_res_data,2)
final_res_data2<-apply(final_res_data,1, function(x) names(sort(x,decreasing = T))[1] )
##### cbind classification results to test data
test_data_with_result = cbind(test_data,final_res_data)
test_data_with_result = cbind(test_data_with_result,final_res_data2)
test_data_with_result$final_res_data2 = as.numeric(as.character(test_data_with_result$final_res_data2))
test_data_with_result[test_data_with_result$final_res_data2== 0,]$final_res_data2 = 'data scientist'
test_data_with_result[test_data_with_result$final_res_data2== 1,]$final_res_data2 = 'data analyst'
test_data_with_result[test_data_with_result$final_res_data2== 2,]$final_res_data2 = 'business analyst'
test_data_with_result[test_data_with_result$final_res_data2== 3,]$final_res_data2 = 'data engineer'
names(test_data_with_result)[which(names(test_data_with_result)=='0')] = 'P of ds'
names(test_data_with_result)[which(names(test_data_with_result)=='1')] = 'P of da'
names(test_data_with_result)[which(names(test_data_with_result)=='2')] = 'P of ba'
names(test_data_with_result)[which(names(test_data_with_result)=='3')] = 'P of de'