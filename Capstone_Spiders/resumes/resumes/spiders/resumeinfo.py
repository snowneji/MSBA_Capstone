# -*- coding: utf-8 -*-
import scrapy
from resumes.items import ResumesItem


class ResumeinfoSpider(scrapy.Spider):
    name = "resumeinfo"
    allowed_domains = ['file://127.0.0.1/']
    start_urls = ['file://127.0.0.1/Users/ywang/Desktop/resumes/data.html']

    def parse(self, response):
        item = ResumesItem()
        for res in response.xpath('//div[@class=\"hresume\"]'):
            name = res.xpath('.//div[@id=\"basic_info_row\"]//h1[@id=\"resume-contact\"]//text()')
            if name:
                person_name = ''.join(name.extract()).strip()
                item['person_name'] = person_name
                print person_name
            title = res.xpath('.//div[@id=\"basic_info_row\"]//h2[@id=\"headline\"]//text()')
            if title:
                person_current_title = ''.join(title.extract()).strip()
                item['person_current_title'] = person_current_title
                print person_current_title
            person_intro = res.xpath('.//p[@id=\"res_summary\"]//text()')
            if person_intro:
                person_intro = ''.join(person_intro.extract()).strip()
                item['person_intro'] = person_intro
                print person_intro
            # work experience
            titles = []
            companies = []
            locations = []
            time = []

            works = res.xpath('.//div[@id=\"work-experience-items\"]/div')
            if len(works) > 0:
                for work in res.xpath('.//div[@id=\"work-experience-items\"]/div'):
                    # work title
                    title = work.xpath('.//p[@class=\"work_title title\"]')
                    if title:
                        titles.append(''.join(title.xpath('.//text()').extract()).strip())
                    # work company
                    company = work.xpath('.//div[@class=\"work_company\"]')
                    if company:
                        compandloc = ''.join(company.xpath('.//text()').extract()).split('-')
                        if len(compandloc) >= 1:
                            companies.append(compandloc[0])
                        if len(compandloc) >= 2:
                            locations.append(compandloc[1])
                    # work date
                    date = work.xpath('.//p[@class=\"work_dates\"]')
                    if date:
                        worktime = ''.join(date.xpath('.//text()').extract()).strip()
                        time.append(worktime)
                        print time
                item['person_company'] = companies
                item['person_location'] = locations
                item['person_workdate'] = time
                item['person_title'] = titles
            #  work description (put all in one chunk)
            desc = res.xpath('.//div[@id=\"work-experience-items\"]')
            if len(desc) > 0:
                work_descs = ''.join(res.xpath('.//div[@id=\"work-experience-items\"]//div//p[@class=\"work_description\"]//text()').extract()).strip()
                item['work_desc'] = work_descs
            #  Education
            majors = []
            colleges = []
            col_locations = []
            col_time = []
            education = res.xpath('.//div[@id=\"education-items\"]')
            if len(education) > 0:
                for edu in res.xpath('.//div[@id=\"education-items\"]/div'):
                    # edu_major
                    major = edu.xpath('.//p[@class=\"edu_title\"]//text()')
                    if major:
                        major = ''.join(major.extract()).strip()
                        majors.append(major)
                    # edu_college and location
                    colndloc = edu.xpath('.//div[@class=\"edu_school\"]//text()')
                    if colndloc:
                        colndloc = ''.join(colndloc.extract()).split('-')
                        if len(colndloc) >= 1:
                            col = colndloc[0]
                            colleges.append(col)
                        if len(colndloc) >= 2:
                            loc = colndloc[1]
                            col_locations.append(loc)
                    # edu_time
                    edu_time = edu.xpath('.//p[@class=\"edu_dates\"]//text()')
                    if edu_time:
                        edu_time = ''.join(edu_time.extract()).strip()
                        col_time.append(edu_time)
                item['college_time'] = col_time
                item['person_major'] = majors
                item['person_college'] = colleges
                item['college_location'] = col_locations

            # skills
            skills = res.xpath('.//div[@id=\"skills-items\"]')
            if len(skills) > 0:
                skill = ''.join(skills.xpath('.//text()').extract()).strip()
                item['person_skill'] = skill
            # Links
            linkset = []
            links = res.xpath('.//div[@id=\"link-items\"]')
            if len(links) > 0:
                for link in links.xpath('.//div[@class=\"data_display\"]'):
                    lin = ''.join(link.xpath('.//@href').extract()).strip()
                    linkset.append(lin)
                item['person_link'] = linkset
            # additional info
            addi = res.xpath('.//div[@id=\"additionalinfo-items\"]')
            if len(addi) > 0:
                addinfo = ''.join(addi.xpath('.//text()').extract()).strip()
                item['person_additional_info'] = addinfo
            yield item
