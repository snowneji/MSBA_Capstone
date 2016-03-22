require(data.table)
source('basic_cleaning.R')

print ('This script contains top skills for each title')
# top skill
ds = c('data analysis',
       'statistics',
       'python',
       'machine learning',
       'sas',
       'hadoop',
       'data mining',
       'r programming',
       'spss')
da = c('data analysis',
       'excel',
       'sql',
       'process improvement',
       'data collection',
       'business analysis',
       'statistics'
        )
de = c('cloud computing',
       'sql',
       'data quality',
       'data manage',
       'linux',
       'analysis',
       'java',
       'soft develop',
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
        'business analysis',
        'management',
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

        