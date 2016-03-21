require(data.table)
require(tm)
library(slam)
library(RWeka)
library(Matrix)

data=fread('train_df.csv',header = T,data.table = F)
data = data[,c(5,6)]
desc = data$desc
#basic cleaning:
source('basic_cleaning.R')
desc = basic_clean(desc)
desc = sapply(desc, function(x){iconv(x, "latin1", "ASCII", sub="")})
desc = data.frame(desc)

#####################
#####################APPROACH 1
#####################
#Corpus and cleaning
corpusclean = function(data,sparse=0.96){
        desc = data
        myCorpus = Corpus(DataframeSource(desc))
        myCorpus = tm_map(myCorpus, content_transformer(tolower))
        myCorpus = tm_map(myCorpus, content_transformer(removeNumbers))
        myCorpus = tm_map(myCorpus, content_transformer(removeWords), stopwords('english'))
        #stop2 = as.vector(stopwords('SMART'))
        myCorpus = tm_map(myCorpus, content_transformer(removeWords),stop2) 
        #myCorpus = tm_map(myCorpus, stemDocument)
        myCorpus = tm_map(myCorpus, content_transformer(stripWhitespace))
        myCorpus = tm_map(myCorpus, content_transformer(PlainTextDocument))
        options(mc.cores=1)
        ngramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min=2, max=2))
        dtm = DocumentTermMatrix(myCorpus,control=list(tokenize =ngramTokenizer)) 
        dtm2 = removeSparseTerms(dtm,sparse = sparse)
        dtm2
        
}
dtm2 = corpusclean(desc)
text_agg = function(dtm){
        dtm2 = as.data.frame(as.matrix(dtm2))
        dtm2        
}
rec_data = text_agg(dtm2)
rec_data$trainning_label = data$target
# sum of each feature group by title
rec_data2 = aggregate(. ~ trainning_label, rec_data, sum)
#top words for each title
ds = rec_data2[rec_data2$trainning_label=='data scientist',]
ds = ds[,-which(names(ds)=='trainning_label')]
ds = sort(ds,decreasing = T)
topds_words = names(ds)[1:50]

da = rec_data2[rec_data2$trainning_label=='data analyst',]
da = da[,-which(names(da)=='trainning_label')]
da = sort(da,decreasing = T)
topda_words = names(da)[1:50]

ba = rec_data2[rec_data2$trainning_label=='business analyst',]
ba = ba[,-which(names(ba)=='trainning_label')]
ba = sort(ba,decreasing = T)
topba_words = names(ba)[1:50]

de = rec_data2[rec_data2$trainning_label=='data engineer',]
de = de[,-which(names(de)=='trainning_label')]
de = sort(de,decreasing = T)
topde_words = names(de)[1:50]

#####################
#####################APPROACH 2
#####################