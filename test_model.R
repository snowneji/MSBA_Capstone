# source('basic_cleaning.R')
# ##################### testing data cleaning
# test = fread('test_df.csv',header = T,data.table = F)
# test_data = data.frame(desc=test$resume_desc)
# test_data$desc = basic_clean(test_data$desc)
# test_data$desc = sapply(test_data$desc, function(x){iconv(x, "latin1", "ASCII", sub="")})
# # corpus and cleaning
# myCorpus = Corpus(DataframeSource(test_data))
# myCorpus = tm_map(myCorpus, content_transformer(tolower))
# myCorpus = tm_map(myCorpus, content_transformer(removeNumbers))
# myCorpus = tm_map(myCorpus, content_transformer(removeWords), stopwords('english'))
# stop2 = as.vector(stopwords('SMART'))
# myCorpus = tm_map(myCorpus, content_transformer(removeWords),stop2) 
# myCorpus = tm_map(myCorpus, stemDocument)
# myCorpus = tm_map(myCorpus, content_transformer(stripWhitespace))
# myCorpus = tm_map(myCorpus, content_transformer(PlainTextDocument))
# options(mc.cores=1)
# ngramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min=1, max=3))
# dtm = DocumentTermMatrix(myCorpus,control=list(tokenize =ngramTokenizer)) 
# 
# text_agg = function(dtm){
#         dtm2 = as.data.frame(as.matrix(dtm))
#         dtm2        
# }
# 
# test_data2 = text_agg(dtm)
# test_data3 = test_data2[,which(names(test_data2) %in% names(train))] %>% as.matrix
# 

print ('This script contains the function to predict the career direction based on the classification model')
test_md = function(test_res, model, n_result=1){
        final_test_res = predict(model,test_res)
        final_res_data<-matrix(final_test_res,nrow=4,ncol=nrow(test_res))
        final_res_data<-as.data.frame(final_res_data)
        row.names(final_res_data)<-c('ds','da','ba','de')
        final_res_data<-t(final_res_data)
        final_res_data <- round(final_res_data,2)
        final_res_data2<-apply(final_res_data,1, function(x) names(sort(x,decreasing = T))[1:n_result] )
        final_res_data2
}

# ##### cbind classification results to test data
# test_data_with_result = cbind(test_data,final_res_data)
# test_data_with_result = cbind(test_data_with_result,final_res_data2)
# test_data_with_result$final_res_data2 = as.numeric(as.character(test_data_with_result$final_res_data2))
# test_data_with_result[test_data_with_result$final_res_data2== 0,]$final_res_data2 = 'data scientist'
# test_data_with_result[test_data_with_result$final_res_data2== 1,]$final_res_data2 = 'data analyst'
# test_data_with_result[test_data_with_result$final_res_data2== 2,]$final_res_data2 = 'business analyst'
# test_data_with_result[test_data_with_result$final_res_data2== 3,]$final_res_data2 = 'data engineer'
# names(test_data_with_result)[which(names(test_data_with_result)=='0')] = 'P of ds'
# names(test_data_with_result)[which(names(test_data_with_result)=='1')] = 'P of da'
# names(test_data_with_result)[which(names(test_data_with_result)=='2')] = 'P of ba'
# names(test_data_with_result)[which(names(test_data_with_result)=='3')] = 'P of de'