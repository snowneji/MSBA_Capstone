# -*- coding: utf-8 -*-
import scrapy
import urlparse
from joblist.items import JoblistItem


class ZiprecruiterDaSpider(scrapy.Spider):
    name = "ziprecruiter_ba"
    allowed_domains = ["ziprecruiter.com"]
    start_urls = (
        'https://www.ziprecruiter.com/candidate/search?search=business+analyst&page=1&location=',
    )

    def parse(self, response):
        for item in response.xpath('//div[@id=\"job_list\"]//article[@class=\"job_result t_job_result\"]'):
            location = ''.join(item.xpath('.//span[@itemprop=\"jobLocation\"]//text()').extract()).strip()
            company = ''.join(item.xpath('.//span[@itemprop=\"hiringOrganization\"]//text()').extract()).strip()
            url = ''.join(item.xpath('.//h2[@class=\"job_title\"]//@href').extract()).strip()
            if url:
                job_url = urlparse.urljoin(response.url, url)
            if 'ziprecruiter' in job_url:
                good_job_url = job_url
                meta = {'job_url': good_job_url,
                        'company': company,
                        'location': location
                        }
            yield scrapy.Request(
                good_job_url,
                callback=self.parse_jobcontent,
                dont_filter=True,
                meta=meta)
        # turn page:
        next_page = ''.join(response.xpath('//a[@class=\'next_prev next\']/@href').extract()).strip()
        if next_page:
            next_page = urlparse.urljoin(response.url, next_page)

        if next_page:
            yield scrapy.Request(
                next_page,
                callback=self.parse,
                dont_filter=True,
            )
        else:
            print 'scraped all courses'

    def parse_jobcontent(self, response):
        item = JoblistItem()
        job_url = response.meta['job_url']
        if job_url:
            item['job_url'] = job_url
        company = response.meta['company']
        if company:
            item['company'] = company
        location = response.meta['location']
        if location:
            item['location'] = location
        title = ''.join(response.xpath('//h1[@itemprop=\"title\"]/text()').extract()).strip()
        if title:
            item['title'] = title
        desc = ' '.join(response.xpath('//div[@itemprop=\"description\"]//text()').extract()).strip()
        if desc:
            item['desc'] = desc
        yield item


