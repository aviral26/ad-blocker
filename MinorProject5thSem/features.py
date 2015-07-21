import csv

features = []
with open('data_posts.csv', 'rb') as csvfile:
    posts = csv.reader(csvfile)
    for post in posts:
    	row = {}
    	row['string_length'] = len(post[0])
    	row['newlines'] = post[0].count("\n")
    	row['status'] = 0
    	row['photo'] = 0
    	row['link'] = 0
    	row['video'] = 0
    	row[post[6]] = 1
    	a = post[5].split(" ")
    	b = a[1].split(":")
    	row['hour'] = b[0]
    	if post[0].count("http://") >= 1:
    		row['link'] = 1
    	row['likes'] = post[4]
    	row['shares'] = post[3]
    	row['comments'] = post[2]
    	row['age'] = post[1]
    	features.append(row)
    	print "\n=============================\n", row

with open('data_features.csv', 'wb') as f:  # Just use 'w' mode in 3.x
	    w = csv.DictWriter(f, features[0].keys())
	    w.writeheader()
	    w.writerows(features)