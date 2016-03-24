### MSBA Capstone Project:

Recommendation System for Analytics Professionals’ Career Building


### Objective:

Build a recommendation system to help aspiring data scientist to bridge their skill gaps.


### Approach:

### a. Scrape online course information, job postings and resumes which are related to analytics professionals from multiple websites using Python Scrapy.


[Capstone_Spiders folder] (https://github.com/snowneji/MSBA_Capstone/tree/master/Capstone_Spiders)


### b. Clean and process job posting data, build classification model to classify job posting into 4 categories: data scientists, data analysts, business analysts and data engineers using R. The accuracy of the initial model is 78%, still can be improved by performing further feature engineering and ensemble.


[basic_cleaning.R] (https://github.com/snowneji/MSBA_Capstone/blob/master/basic_cleaning.R)

[corpus_clean.R] (https://github.com/snowneji/MSBA_Capstone/blob/master/corpus_clean.R)

[coursedata_cleaning(no need later).R] (https://github.com/snowneji/MSBA_Capstone/blob/master/coursedata_cleaning(no%20need%20later).R)

[train_data_cleaning(no need later).R] (https://github.com/snowneji/MSBA_Capstone/blob/master/train_data_cleaning(no%20need%20later).R)

[train_model(no need later).R ] (https://github.com/snowneji/MSBA_Capstone/blob/master/train_model(no%20need%20later).R)

### c. Test resume data using the classification model and classify each into one of the 4 categories mentioned above using R.


[test_model.R] (https://github.com/snowneji/MSBA_Capstone/blob/master/test_model.R)

### d. Based on the classified result, each resume is compared with the top skills of the target title to identify the skill gaps using R.


[topskill_n_course_for_rec.R] (https://github.com/snowneji/MSBA_Capstone/blob/master/topskill_n_course_for_rec.R)

### e. Recommend top rated online course to the person based on his/her skills gaps using R.


[main script.R] (https://github.com/snowneji/MSBA_Capstone/blob/master/main%20script.R)

[match_course.R] (https://github.com/snowneji/MSBA_Capstone/blob/master/match_course.R)

[select_course.R] (https://github.com/snowneji/MSBA_Capstone/blob/master/select_course.R)

### f. Build an interactive data product which allows aspiring analytics professionals to pass their resumes through the app and receive recommended courses that help them to fill their skill gaps using R.


In process



