# -*- coding: utf-8 -*-

# Define here the models for your scraped items
#
# See documentation in:
# http://doc.scrapy.org/en/latest/topics/items.html

import scrapy


class ResumesItem(scrapy.Item):
    resume_url = scrapy.Field()
    person_name = scrapy.Field()
    person_current_title = scrapy.Field()
    person_intro = scrapy.Field()
    person_title = scrapy.Field()
    person_company = scrapy.Field()
    person_location = scrapy.Field()
    person_workdate = scrapy.Field()
    work_desc = scrapy.Field()
    person_major = scrapy.Field()
    person_college = scrapy.Field()
    college_location = scrapy.Field()
    college_time = scrapy.Field()
    person_skill = scrapy.Field()
    person_link = scrapy.Field()
    person_additional_info = scrapy.Field()
    # define the fields for your item here like:
    # name = scrapy.Field()
    pass
