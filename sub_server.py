#!/usr/bin/python
# -*- coding: utf-8 -*-
err = False

import os, sys
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import Select
from time import sleep

print(str(sys.argv))

browser = webdriver.Firefox()
sleep(3)
browser.get("http://tellsubway.ie/")

elem = browser.find_element_by_id('txtSearch') # Find the search box
elem.send_keys(str(sys.argv[5]))
browser.find_element_by_xpath(".//div[@class='TS_btn1']").click()
sleep(5)
browser.find_element_by_id('agree').click()
sleep(5)
date_elem=browser.find_element_by_id('date_10102')
date_elem.send_keys(str(sys.argv[1]))
hour_elem = browser.find_element_by_id('hour_10102')
hour_elem.send_keys(str(sys.argv[2]))
minutes_elem=browser.find_element_by_id('minute_10102')
minutes_elem.send_keys(str(sys.argv[3]))
browser.find_element_by_xpath(".//div[@class='StepBtn']").click()

browser.find_element_by_id('opt_10').click()
browser.find_element_by_id('opt_49799').click()
browser.find_element_by_id('opt_49811').click()
browser.find_element_by_id('opt_49822').click()
browser.find_element_by_id('opt_49833').click()
browser.find_element_by_id('opt_49844').click()
browser.find_element_by_id('opt_49855').click()
browser.find_element_by_id('opt_49866').click()

sleep(5)

browser.find_element_by_xpath('//*[@id="page_2"]/div[2]/a[1]/div').click()

browser.find_element_by_xpath('//*[@id="question_10124"]/div/div/label[2]').click()
browser.find_element_by_xpath('//*[@id="question_10126"]/div/div/label[2]').click()
q3 = Select(browser.find_element_by_xpath('//*[@id="10128"]'))
q3.select_by_visible_text("2")
q4 = Select(browser.find_element_by_xpath('//*[@id="10129"]'))
q4.select_by_visible_text("2")

browser.find_element_by_xpath('//*[@id="page_3"]/div[2]/a[1]/div').click()


email_elem = browser.find_element_by_xpath('//*[@id="10130"]')
email_elem.send_keys(str(sys.argv[4]))
browser.find_element_by_xpath('//*[@id="question_10131"]/div/div/label[2]').click()
browser.find_element_by_xpath('//*[@id="question_contact_me"]/div/div/label[2]').click()

sleep(3)
browser.find_element_by_xpath('//*[@id="page_4"]/div[2]/a[1]/div').click()

sleep(9)

try:
	print(browser.find_element_by_id('lblCorrectError').text)
	print(browser.find_element_by_id('popText').text)
	err = True
except Exception:
	err = False

if err:
	print("Can't get a cookie")
	browser.close()
	sleep(3)
	exit(1)
else:
	print("cookie send to "+str(sys.argv[4]))
	browser.close()
	sleep(3)
	exit(0)
