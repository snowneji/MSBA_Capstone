require(data.table)
source('basic_cleaning.R')

print ('This script contains top skills for each title')
# top skill
ds = c('data analysis',
       'statistics',
       'python',
       'machine learning',
       'sas',
       'research',
       'development',
       'statistical modeling',
       'predictive modeling',
       'hadoop',
       'data mining',
       'rprogramming',
       'spss')
da = c('data analysis',
       'excel',
       'reporting',
       'finance',
       'information technology',
       'information system',
       'analytics',
       'data mnining',
       'data validation',
       'data management',
       'primary research',
       'quantum',
       'secondary research',
       'sql',
       'process improvement',
       'data collection',
       'business analysis',
       'statistics'
        )
de = c('cloud computing',
       'sql',
       'data quality',
       'data security',
       'data management',
       'system analysis',
       'informatica',
       'finite element analysis',
       'etl',
       'linux',
       'analysis',
       'java',
       'software development',
       'python',
       'data warehousing',
       'mech',
       'oracle',
       'hadoop',
       'unix',
       'sas'
       )
ba = c(
        'data analysis',
        'requirement management',
        'business process',
        'information technology',
        'information system',
        'business solution',
        'finance',
        'system analysis',
        'requirement gathering',
        'business research',
        
        'business analysis',
        'process management',
        'process improvement',
        'sql',
        'sas') 


skillsets = unique(c(ds,da,ba,de))
skilldata =  matrix(rep(0,4*length(skillsets)),4,length(skillsets))
row.names(skilldata) = c('ds','da','ba','de'); colnames(skilldata) = skillsets

skilldata[which(row.names(skilldata)=='ds'),which(colnames(skilldata) %in% ds )] = 1
skilldata[which(row.names(skilldata)=='da'),which(colnames(skilldata) %in% da )] = 1
skilldata[which(row.names(skilldata)=='ba'),which(colnames(skilldata) %in% ba )] = 1
skilldata[which(row.names(skilldata)=='de'),which(colnames(skilldata) %in% de )] = 1

        