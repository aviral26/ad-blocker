import facebook
import json
import time
import datetime
import csv, sys, urlparse

graph = facebook.GraphAPI('CAACEdEose0cBAOSB13Vpk1J3XwkF2Aq62TXQrdDNqUZCAZAuQ7tTIsDGi7ZCm4Y6ry5o9BIEiOMeEFvrWH9gVSB6FJPPxxoPhJRqMFxhyngfSmtcMN1Uyz8qrI7JEPih4rtxrQa5Y3aeCHIm9k4lMM6CwMXvmURNZAqnLewqGMpxGQfMPEmXT1xs7nuqKZAoZBGHBw1UgD6QZDZD')

records = []
count = 1
pageid = 'Tzinga'
posts = graph.get_connections(pageid, 'posts', date_format='U')

flag = 1
while True:
	print len(posts['data'])
	for post in posts['data']:
		post['likes'] = {}
		post['comments'] = {}

		print "\nPost #", count, "\n", post, "\n"
		count = count + 1
		if post['from']['name'] == pageid and 'status_type' in post and 'message' in post or 'caption' in post:
			likes = graph.get_connections(post['id'], 'likes', summary=1)
			comments = graph.get_connections(post['id'], 'comments', summary=1)

			rec = {}

			rec['likes'] = likes['summary']['total_count']
			rec['comments'] = comments['summary']['total_count']
			rec['type'] = str(post['type'])
			if 'status_type' in post:
				rec['status_type'] = str(post['status_type'])
			else:
				rec['status_type'] = 'unknown'
			rec['age'] = post['created_time']
			rec['date'] = datetime.datetime.fromtimestamp(int(post['created_time'])).strftime('%Y-%m-%d %H:%M:%S')
			if 'message' in post:
				rec['text'] = unicode(post['message']).encode("utf-8")
			else:
				rec['text'] = unicode(post['caption']).encode("utf-8")

			if 'shares' in post:
				rec['shares'] = post['shares']['count']
			else:
				rec['shares'] = 0

			records.append(rec)
			print rec
			print '\n=======================================\n'

	with open('cocacola.csv', 'wb') as f:  # Just use 'w' mode in 3.x
	    w = csv.DictWriter(f, records[0].keys())

	    if flag:
	    	w.writeheader()
	    	flag = 0

	    w.writerows(records)

	if 'paging' in posts:
		nxt = urlparse.parse_qs(posts['paging']['next'])
		untilVal = nxt['until'][0]
		posts = graph.get_connections(pageid, 'posts', until=untilVal, date_format='U', limit=25)
		print "\nGetting data until", untilVal, datetime.datetime.fromtimestamp(int(untilVal)).strftime('%Y-%m-%d %H:%M:%S')
	else:
		break



