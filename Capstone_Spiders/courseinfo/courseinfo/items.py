# -*- coding: utf-8 -*-

# Define here the models for your scraped items
#
# See documentation in:
# http://doc.scrapy.org/en/latest/topics/items.html

import scrapy


class CoursetalkItem(scrapy.Item):

    course_category = scrapy.Field()
    course_url = scrapy.Field()
    course_name = scrapy.Field()
    course_price = scrapy.Field()
    course_desc = scrapy.Field()
    course_university = scrapy.Field()
    course_instructor = scrapy.Field()
    course_review_num = scrapy.Field()
    course_rating = scrapy.Field()
    course_provider = scrapy.Field()
    # define the fields for your item here like:
    # name = scrapy.Field()
    pass
