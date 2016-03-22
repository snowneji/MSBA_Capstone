# import test resume
test = fread('test_df.csv',header = T,data.table = F)
res = test$resume_desc[5]

#basic cleaning for resume
source('basic_cleaning.R')
res = basic_clean(res)

#corpus cleaning for resume
source('corpus_clean.R')
res = corpusclean(res,sparse=0.96,ng_min = 1,ng_max = 3)
res = as.data.frame(as.matrix(res))

#load training set and fit the test resume to training
train = fread('final_best_train.csv',header = T)
res = res[,which(names(res) %in% names(train))] %>% as.matrix

# classify the new resume
mymd = xgb.load('xgboost_model')
source('test_model.R')
result_title = test_md(res,mymd,1)

#based on the result, find gap skills
source('topskill_n_course_for_rec.R')
person_skills = skilldata[which(row.names(skilldata)==result_title),]
person_skills = stemDocument(names(person_skills[which(person_skills==1)]))

#find related course for the person:
source('match_course.R')
coursedata = fread('final_best_coursedata.csv',header = T)
courseterm = coursedata$course_terms
course_id = match_course(person_skills = person_skills,courseterm = courseterm)

# select and sort course based on rating and review number:
source('select_course.R')
final_rec = select_course(course_id = course_id,course_data = coursedata)

