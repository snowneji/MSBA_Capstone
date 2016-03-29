


#Corpus and cleaning function
print ('This script contains the function which creates corpus, performs n-gram and creates dtm based on the incoming data')
corpusclean = function(data,sparse=0.96){
        library(tm)
        library(slam)
        #  library(RWeka)
        library(Matrix)
        library(quanteda)
        myCorpus = Corpus(DataframeSource(data))
        myCorpus = corpus(myCorpus)
        mydfm <- dfm(myCorpus, 
                     ignoredFeatures = c(stopwords('english')),
                     toLower = T,
                     removeNumbers = TRUE,
                     removePunct = T,
                     ngrams=1:3)
        dtm = as.DocumentTermMatrix(mydfm)
        dtm2 = removeSparseTerms(dtm,sparse = sparse)
        dtm2
        
}

# #####################
# #####################APPROACH 1
# #####################
# data=fread('train_df.csv',header = T,data.table = F)
# data = data[,c(5,6)]
# desc = data$desc
# #basic cleaning:
# source('basic_cleaning.R')
# desc = basic_clean(desc)
# desc = sapply(desc, function(x){iconv(x, "latin1", "ASCII", sub="")})
# desc = data.frame(desc)
# 
# 
# dtm2 = corpusclean(desc)
# text_agg = function(dtm){
#         dtm2 = as.data.frame(as.matrix(dtm2))
#         dtm2        
# }
# rec_data = text_agg(dtm2)
# rec_data$trainning_label = data$target
# # sum of each feature group by title
# rec_data2 = aggregate(. ~ trainning_label, rec_data, sum)
# #top words for each title
# ds = rec_data2[rec_data2$trainning_label=='data scientist',]
# ds = ds[,-which(names(ds)=='trainning_label')]
# ds = sort(ds,decreasing = T)
# topds_words = names(ds)[1:100]
# 
# da = rec_data2[rec_data2$trainning_label=='data analyst',]
# da = da[,-which(names(da)=='trainning_label')]
# da = sort(da,decreasing = T)
# topda_words = names(da)[1:100]
# 
# ba = rec_data2[rec_data2$trainning_label=='business analyst',]
# ba = ba[,-which(names(ba)=='trainning_label')]
# ba = sort(ba,decreasing = T)
# topba_words = names(ba)[1:100]
# 
# de = rec_data2[rec_data2$trainning_label=='data engineer',]
# de = de[,-which(names(de)=='trainning_label')]
# de = sort(de,decreasing = T)
# topde_words = names(de)[1:100]
# 
# rec_data = data.frame(data_scientist=topds_words,
#                       data_analyst = topda_words,
#                       business_analyst = topba_words,
#                       data_engineer = topde_words)
