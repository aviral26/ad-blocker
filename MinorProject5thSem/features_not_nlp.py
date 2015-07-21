import csv, datetime, re, sys

# keys = []
# postWords = []
# cnt = 0
# with open('data_posts.csv', 'rb') as csvfile:
#     posts = csv.reader(csvfile)
#     for post in posts:
#         txt = post[0] + " "
#         txt = re.sub(r'(.*?)http.*?(\s|\n|\r)(.*)', r'\1 \3', txt)
#         words = nltk.word_tokenize(txt)
#         words = [w.replace(".", "") for w in words]
#         words = [w.replace(",", "") for w in words]
#         words = [w.replace("'", "") for w in words]
#         words = [w.replace("__", "") for w in words]
#         tags = nltk.pos_tag(words)
#         porter = nltk.PorterStemmer()
#         foo = [porter.stem(t[0]) for t in tags if t[1] != 'CC' and t[1] != 'DT' and t[1] != 'IN' and t[1] != 'PRP' and t[1] != 'TO' and t[1] != 'VBP' and len(t[0]) > 3]
#         postWords.append(foo)
#         cnt = cnt + 1
#         [keys.append(w) for w in foo if w not in keys]



# print keys
# allKeys = keys.extend(('str_length', 'newlines', 'hour', 'age', 'day'))
features = []
outputs = []
initRow = {}

cnt = 0
with open('wsj.csv', 'rb') as csvfile:
    posts = csv.reader(csvfile)
    for post in posts:
        row = {}
    	row['str_length'] = len(post[0])
    	row['newlines'] = post[0].count("\n")
        a = post[5].split(" ")
        b = a[1].split(":")
        row['hour'] = b[0]
        dcomps = a[0].split("-")
        row['day'] = datetime.date(int(dcomps[0]), int(dcomps[1]), int(dcomps[2])).weekday()
        row['age'] = post[1]


        if post[0].count("http://") >= 1:
            row['link'] = 1
        else:
            row['link'] = 0

        t = post[6];

        if row['link'] == 1 or t == 'link':
            row['type'] = 4
        elif t == 'photo':
            row['type'] = 3
        elif t == 'status':
            row['type'] = 2
        elif t == 'video':
            row['type'] = 1

        row['status'] = 0
    	row['photo'] = 0
    	row['link'] = 0
    	row['video'] = 0
        if post[6] == 'swf':
            post[6] = 'video'
    	row[post[6]] = 1

        row['likes'] = post[4]
    	row['shares'] = post[3]
    	row['comments'] = post[2]

    	features.append(row)
        cnt = cnt+1
    	print "\n=============================\n", row


with open('/Users/ayushchd/Documents/ml/ml-003/ex1_003/ex1/data_input_wsj.csv', 'wb') as f:  # Just use 'w' mode in 3.x
	    w = csv.DictWriter(f, features[0].keys())
	    w.writeheader()
	    w.writerows(features)
