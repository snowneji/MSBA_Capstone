# -*- coding: utf-8 -*-
import scrapy
import urlparse
from joblist.items import JoblistItem


class SimphiredDsSpider(scrapy.Spider):
    name = "simphired_ds"
    allowed_domains = ["simplyhired.com"]
    start_urls = (
        'http://www.simplyhired.com/search?q=data+scientist&pn=1',
    )

    def parse(self, response):
        for item in response.xpath('//div[@class=\"jobs js-jobs\"]/div[@itemtype=\"http://schema.org/JobPosting\"]'):
            company = ''.join(item.xpath('./div[@class=\"card-top\"]/h3/span[@class=\"serp-company\"]//text()').extract()).strip()
            location = ''.join(item.xpath('./div[@class=\"card-top\"]/h3/span[@class=\"serp-location\"]//text()').extract()).strip()
            title = ''.join(item.xpath('./div[@class=\"card-top\"]/h2[@class=\"serp-title\"]//text()').extract()).strip()
            url = ''.join(item.xpath('.//a[@rel=\"nofollow\"]/@href').extract()).strip()
            if url:
                job_url = urlparse.urljoin(response.url, url)
            if 'simplyhired' in job_url:
                good_job_url = job_url
                meta = {'job_url': good_job_url,
                        'company': company,
                        'location': location,
                        'title': title
                        }

            yield scrapy.Request(
                good_job_url,
                callback=self.parse_jobcontent,
                dont_filter=True,
                meta=meta)
        # turn page:
        print response.url

        page_num = int(response.url.split('pn=')[1])
        if page_num <= 186:
            next_num = str(page_num + 1)
            next_page = response.url.split('pn=')[0]
            next_page_url = 'pn='.join([next_page, next_num])
            yield scrapy.Request(
                next_page_url,
                callback=self.parse,
                dont_filter=True,
            )

    def parse_jobcontent(self, response):
        if 'www.simplyhired.com' in response.url:
            item = JoblistItem()

            item['job_url'] = response.url
            company = response.meta['company']
            if company:
                item['company'] = company
            location = response.meta['location']
            if location:
                item['location'] = location
            title = response.meta['title']
            if title:
                item['title'] = title

            desc = ' '.join(response.xpath('//div[@class=\"jp-description\"]//text()').extract()).strip()
            if desc:
                item['desc'] = desc
            yield item
        else:
            pass
