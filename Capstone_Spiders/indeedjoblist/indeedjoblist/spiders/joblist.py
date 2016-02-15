# -*- coding: utf-8 -*-
import scrapy
from indeedjoblist.items import IndeedjoblistItem
import urlparse


class JoblistSpider(scrapy.Spider):
    name = "joblist"
    allowed_domains = ["indeed.com"]
    start_urls = (
        'http://www.indeed.com/jobs?q=data+scientist',
    )

    def parse(self, response):
        item = IndeedjoblistItem()
        for person in response.xpath('//div[@data-tn-component=\"organicJob\"]'):
            title = person.xpath('./h2[@class=\"jobtitle\"]')
            if title:
                title = ''.join(title.xpath('.//text()').extract()).strip()
            company = person.xpath('./span[@class=\"company\"]')
            if company:
                company = ''.join(company.xpath('.//text()').extract()).strip()
            review = person.xpath('./a[@data-tn-element=\"reviewStars\"]')
            if review:
                review = ''.join(review.xpath('.//text()').extract()).strip()
            location = person.xpath('./span[@itemprop=\"jobLocation\"]')
            if location:
                location = ''.join(location.xpath('.//text()').extract()).strip()
            desc = person.xpath('.//span[@itemprop=\"description\"]')
            if desc:
                desc = ''.join(desc.xpath('.//text()').extract()).strip()

            item['title'] = title
            item['company'] = company
            item['review'] = review
            item['location'] = location
            item['desc'] = desc
            print item
            yield item

        next = response.xpath('//div[@class=\"pagination\"]//a')
        if next:
            next = next[-1]
            new_next = next.xpath('./span/span')
            if new_next:
                next_page = ''.join(new_next.xpath('../..//@href').extract()).strip()
                next_page = urlparse.urljoin(response.url, next_page)

                yield scrapy.Request(
                    next_page,
                    callback=self.parse,
                    dont_filter=True
                )
            else:
                print 'scraped all courses'
