match_course = function(person_skills,courseterm){
        rec_course =sapply(person_skills, function(x){
                grep(x,courseterm)
        })
        
        rec_id = unique(unlist(rec_course))
        
        rec_id
        
}