# import requests, json, csv, pdb
import json, csv, pdb
import datetime
import random
import urllib

# filename = '/tmp/CW_May_June_Backlog.csv'
#filename = '/tmp/Incentives_17thOct_to_23rdOct.csv'
#filename = '/tmp/CW_11th_Oct_to_16th_Oct_2022.csv'
#filename = '/tmp/lines_test.csv'
#filename = '/tmp/line_test2.csv'

username = 'safaricom-mt'
password = 'wordpass'
send_to = '140'

sent_numbers = ['254700040030','254700040007','254700040002','254701990055','254701990050', '254701990090', '254701990099', '254724991061', '254716287589']
#sent_numbers = ['254700122344']
#sent_numbers = ['254701990090', '254701990099']    

# with open(filename, 'r') as csvFile:
#     csvFile = csv.reader(csvFile)
#     next(csvFile)

#     for line in csvFile :

recipient = '0707610667'
# {line[0]}
incentive_amount = '20'

sent_from=random.choice(sent_numbers)
#amount_hash =  "5#"
msg_text = (','.join(incentive_amount)+"#"+','.join(recipient))

params = urllib.urlencode({ 'username': username,'password': password,'to': send_to,'from': sent_from,'text': msg_text })

fullurl = 'http://23.21.163.195:81/cgi-bin/sendsms' + '?' + params

ret = urllib.urlopen(fullurl)

x = str(ret.readlines())
#print x
#print fullurl

if "Accepted for delivery" in x:
    print "Success" + x + " - " + msg_text
#    print x

else:
    print ("failed Unsucessful compensation by kannel")
