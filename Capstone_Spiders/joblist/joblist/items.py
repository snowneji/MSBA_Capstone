# -*- coding: utf-8 -*-

# Define here the models for your scraped items
#
# See documentation in:
# http://doc.scrapy.org/en/latest/topics/items.html

import scrapy


class JoblistItem(scrapy.Item):
    # define the fields for your item here like:
    # name = scrapy.Field()
    job_url = scrapy.Field()
    title = scrapy.Field()
    company = scrapy.Field()
    location = scrapy.Field()
    desc = scrapy.Field()
    pass
