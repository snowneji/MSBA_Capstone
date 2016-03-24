require(data.table)
require(tm)
require(slam)
require(RWeka)
require(Matrix)
require(xgboost)
require(caret)

# train data cleaning
data = fread('train_df.csv',header = T,data.table = F)
data = data[,c(5,6)]
desc = data$desc
# basic cleaning:
source('basic_cleaning.R')
desc = basic_clean(desc)
desc = sapply(desc, function(x){iconv(x, "latin1", "ASCII", sub="")})
desc = data.frame(desc)
#Corpus and cleaning
source('corpus_clean.R')
dtm2 = corpusclean(desc,sparse = 0.96,ng_min = 1,ng_max = 3)
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



write.csv(x=train_data,file='final_best_train.csv',row.names=F)
