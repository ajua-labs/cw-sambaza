import datetime
import random
import urllib

def topup_from_numbers():
    username = 'safaricom-mt'
    password = 'wordpass'
    send_to = '140'
    sent_numbers = ['254700040030','254716287589','254700040007','254700040002','254701990055','254701990099','254701990050', '254701990090', '254724991061']
    #,'254719113618','254719113582','254719113539','254719113386','254719113724']
    sent_from=random.choice(sent_numbers)
    msg_text =  "180#0729628998"

    params = urllib.urlencode({ 'username': username,'password': password,'to': send_to,'from': sent_from,'text': msg_text })
    fullurl = 'http://23.21.163.195:81/cgi-bin/sendsms' + '?' + params
    #fullurl = 'http://10.0.1.100:81/cgi-bin/sendsms' + '?' + params

    ret = urllib.urlopen(fullurl)

    x = str(ret.readlines())
    print x
    #print fullurl

    if "Accepted for delivery" in x:
        print "Success"
        print x

    else:
        print "failed Unsucessful compensation by kannel"


topup_from_numbers()
