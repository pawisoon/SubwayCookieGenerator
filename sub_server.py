#!/usr/bin/python
# -*- coding: utf-8 -*-
err = False

import os, sys
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import Select
from time import sleep
#email = webdriver.Firefox()

print(str(sys.argv))

browser = webdriver.Firefox()
browser.get("http://tellsubway.ie/")
#email.get("http://10minutemail.com/")
sleep(3)

elem = browser.find_element_by_id('txtSearch') # Find the search box
elem.send_keys(str(sys.argv[5]))
browser.find_element_by_xpath(".//div[@class='TS_btn1']").click()
sleep(5)
browser.find_element_by_id('agree').click()
sleep(3)
date_elem=browser.find_element_by_id('answ4304')
date_elem.send_keys(str(sys.argv[1]))
hour_elem = browser.find_element_by_id('answHour4304')
hour_elem.send_keys(str(sys.argv[2]))
minutes_elem=browser.find_element_by_id('answMinute4304')
minutes_elem.send_keys(str(sys.argv[3]))
browser.find_element_by_id('answc430610').click()
browser.find_element_by_id('answ16472Q4307').click()

browser.find_element_by_id('answ16484C4309Q4308').click()
browser.find_element_by_id('answ16495C4310Q4308').click()
browser.find_element_by_id('answ16506C4311Q4308').click()
browser.find_element_by_id('answ16517C4312Q4308').click()
browser.find_element_by_id('answ16528C4313Q4308').click()
browser.find_element_by_id('answ16539C4314Q4308').click()

q1 = Select(browser.find_element_by_xpath(".//select[@id='answ4327']"))

q1.select_by_visible_text("No")

q2 = Select(browser.find_element_by_xpath(".//select[@id='answ4329']"))

q2.select_by_visible_text("No")

q3 = Select(browser.find_element_by_xpath(".//select[@id='answ4331']"))

q3.select_by_visible_text("2")

q4 = Select(browser.find_element_by_xpath(".//select[@id='answ4332']"))

q4.select_by_visible_text("2")

email_elem = browser.find_element_by_id('answ4333')

email_elem.send_keys(str(sys.argv[4]))

q5 = Select(browser.find_element_by_xpath(".//select[@id='answ4334']"))

q5.select_by_visible_text("No")

q6 = Select(browser.find_element_by_xpath(".//select[@id='DdlContact']"))

q6.select_by_visible_text("No")
sleep(3)

browser.find_element_by_id('btnSubmit').click()
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
	exit(0)
else:
	print("cookie send to "+str(sys.argv[4]))
	browser.close()
	sleep(3)
	exit(0)
