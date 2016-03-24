match_course = function(gap_skills,courseterm){
        rec_course =sapply(gap_skills, function(x){
                grep(x,courseterm)
        })
        
        rec_id = unique(unlist(rec_course))
        
        rec_id
        
}