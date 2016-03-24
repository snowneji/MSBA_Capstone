MSBA Capstone Project: Recommendation System for Analytics Professionals’ Career Building


Objective:
To build a recommendation system to help aspiring data scientist to bridge their skill gaps.


# Approach:

## a. Scrape online course information, job postings and resumes which are related to analytics professionals from multiple websites.

Scripts:

Capstone_Spiders folder


## b. Clean and process job posting data, build classification model to classify job posting into 4 categories: data scientists, data analysts, business analysts and data engineers.

Scripts:

basic_cleaning.R

corpus_clean.R

coursedata_cleaning(no need later).R

train_data_cleaning(no need later).R

## c. Test resume data using the classification model and classify each into one of the 4 categories mentioned above.

Scripts:

train_model(no need later).R

test_model.R

## d. Based on the classified result, each resume is compared with the top skills of the target title to identify the skill gaps.

Scripts:

topskill_n_course_for_rec.R

## e. Recommend top rated online course to the person based on his/her skills gaps.

Scripts:

main script.R

match_course.R

select_course.R

## f. Build an interactive data product which allows aspiring analytics professionals to pass their resumes through the app and receive recommended courses that help them to fill their skill gaps.

Scripts:

In process



