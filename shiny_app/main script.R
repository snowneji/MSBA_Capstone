############################
######import test resume###
############################ 
#test = fread('test_df.csv',header = T,data.table = F)
#initial_res = test$resume_desc[120]

maintitle = function(resume){
        library(data.table)
        library(xgboost)
        initial_res = resume
        ############################
        ######cleaning resume#######
        ############################ 
        
       
        #basic cleaning for resume
        source('basic_cleaning.R')
        res = basic_clean(initial_res)
        #corpus cleaning for resume
        source('corpus_clean.R')
        res = corpusclean(res,sparse=0.96)
        res = as.data.frame(as.matrix(res))
        #load training set and fit the test resume to training
        train = fread('final_best_train.csv',header = T)
        res = res[,which(names(res) %in% names(train))]
        
        res = as.matrix(res)
        
        ################################
        ######classify new resume#######
        ###############################
        mymd = xgb.load('xgboost_model')
        source('test_model.R')
        result_title = test_md(res,mymd)
        
  
        if (row.names(result_title)[1] == "ds"){
                row.names(result_title)[1] = 'Data Scientist'
        }
        if (row.names(result_title)[1] == 'da'){
                row.names(result_title)[1] = 'Data Analyst'
        }
        if (row.names(result_title)[1]=='ba'){
                row.names(result_title)[1] = 'Business Analyst'
        }
        if (row.names(result_title)[1]=='de'){
                row.names(result_title)[1] = 'Data Engineer'
        }
        result_title
}  
        
        
        
maincourse = function(title,resume){
        library(data.table)
        
        #################################
        ######skills for the title#######
        ################################
        source('topskill_n_course_for_rec.R')
        
        title = row.names(title)[1]
        
        if (title == "Data Scientist"){
                title = 'ds'
        }
        if (title == "Data Analyst"){
                title = 'da'
        }
        if (title == "Business Analyst"){
                title = 'ba'
        }
        if (title == "Data Engineer"){
                title = 'de'
        }
        
        position_skills = skilldata[which(row.names(skilldata)==title),]
        position_skills = names(position_skills[which(position_skills==1)])
        # names of the position skills are used to recommend non-stem skills to people
        #############################################################################
        names(position_skills) = position_skills
        position_skills = sapply(position_skills,function(x){
                a = unlist(strsplit(x,split = ' '))
                b = paste(stemDocument(a),collapse = ' ')
                b
        })
        ########################################
        #########reparse resume to match skills#
        #######################################
        res_match = basic_clean(resume)
        res_match = corpusclean(res_match,sparse=0.96)
        res_match = as.data.frame(as.matrix(res_match))
        names(res_match) = gsub('_',' ',names(res_match))
        names_for_gap_skills = names(res_match)
        names_for_gap_skills = sapply(names_for_gap_skills,function(x){
                a = unlist(strsplit(x,split = ' '))
                b = paste(stemDocument(a),collapse = ' ')
                b
        })
        #################################
        ######gap skills################
        ################################
        find_gap_skills = sapply(position_skills,function(x){
                x %in% names_for_gap_skills
        })
        ###here would be the output for app user
        gap_skills = names(find_gap_skills[find_gap_skills=='FALSE'])
        have_skills = names(find_gap_skills[find_gap_skills=='TRUE'])
        
        # refer back to position skills
        gap_skills = position_skills[which(names(position_skills) %in% gap_skills )]
        
        gap_skills
}

finalcourse = function(gap_skills){
        
        ##################################
        ######find course id to rec#######
        #################################
        source('match_course.R')
        coursedata = fread('final_best_coursedata.csv',header = T,data.table = F)
        courseterm = coursedata$course_terms
        course_id = match_course(gap_skills = gap_skills,courseterm = courseterm)
        
        ##################################
        ######find course to rec#########
        #################################
        source('select_course.R')
        final_rec = select_course(course_id = course_id,course_data = coursedata)
        final_rec
              
}

