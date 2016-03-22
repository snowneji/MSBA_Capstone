require(tm)
require(data.table)
coursedata = fread('final_course_df.csv',header = T)
coursenames = coursedata$course_name
source('basic_cleaning.R')
coursenames = basic_clean(coursenames)
coursenames = apply(coursenames,1,function(x){
        a = unlist(strsplit(x,split = ' '))
        a = a[a!='']
        b = paste(stemDocument(a),collapse = ' ')
        b
})
coursedata$course_terms = coursenames

write.csv(x=coursedata,file='final_best_coursedata.csv',row.names=F)