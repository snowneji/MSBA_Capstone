# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: http://doc.scrapy.org/en/latest/topics/item-pipeline.html

import csv


class CsvWriterPipeline(object):

    def __init__(self):
        self.csvwriter = csv.writer(open('items.csv', 'wb'))
        self.csvwriter.writerow(
            [

                'course_url',
                'course_name',
                'course_price',
                'course_desc',
                'course_university',
                'course_instructor',
                'course_review_num',
                'course_rating',
                'course_provider'
            ]
        )

    def process_item(self, item, coursetalk):
        self.csvwriter.writerow(
            [
                item['course_url'],
                item['course_name'],
                item['course_price'],
                item['course_desc'],
                item['course_university'],
                item['course_instructor'],
                item['course_review_num'],
                item['course_rating'],
                item['course_provider']

            ]
        )
        return item


class CourseinfoPipeline(object):
    def process_item(self, item, spider):
        return item
