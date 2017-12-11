#!/usr/bin/env python3


from http.server import BaseHTTPRequestHandler, HTTPServer
from urllib.parse import urlparse,parse_qs

from copy import deepcopy
import json
import pymysql.cursors


class echoServer(BaseHTTPRequestHandler):


	# Create DB connections, return cursor.
	def DBconnection(self):
		self.conn = pymysql.connect(
			host="127.0.0.1",
			port='3306',
			user="sneezy",
			passwd="sneezing",
			db="pollen",
			unix_socket="/var/run/mysqld/mysqld.sock"
			)

		return self.conn.cursor()

	# Close DB connection.
	def closeDBconnection(self):
		self.conn.close()

	# Pollen Query
	# Adjust query as needed. You'll need to update jsonify() below
	# to capture the correct items you're looking for. 
	def pollenQuery(self):
		query = "SELECT date, alder, willow, \
			poplar_aspen, birch, spruce, \
			other1_tree, other2_tree, grass, grass_2, \
			weed, other1, other2, mold FROM PollenData;"

		return query

	def tableQuery(self):
		query = "desc PollenData;"

		return query

	# On GET request, query the MySQL DB, format data into pollendata blocks, and return
	# as a string.


	# Regular jsonify function. Returns regular JSON data, non-separated. 
	def jsonify(self, response):
		
		allPollenData = {}

		polArray = []

		counter = 0
		for r in response:

			emptyDict = {
				"Year": r[0].year,
				"Data":{

					"Day": r[0].day,
					"Month": r[0].month,
					
					"Alder": r[1], 
					"Willow": r[2], 
					"Poplar Aspen": r[3], 
					"Birch":r[4],
					"Spruce": r[5], 
					"Other1 Tree": r[6], 
					"Other2 Tree": r[7], 
					"Grass": r[8], 
					"Grass2":r[9],
					"Weed": r[10], 
					"Other1": r[11], 
					"Other2": r[12],
					"Mold": r[13]
				},
			}

			polArray.append(emptyDict)

		return polArray


	# Easy to parse JSON, categorized by year objects. 
	def easyJsonify(self, response):
		# Store to JSON array.
		polArray = []
		dummy_year = -1

		yearHolder = dummy_year # Set dummy starting year.

		workingYear = {
			"Year": -1,
			"Data": []
		}


		lists = []

		for r in response:
			lists.append({
				"Day": r[0].day,
				"Month": r[0].month,
				"Alder": r[1], 
				"Willow": r[2], 
				"Poplar Aspen": r[3], 
				"Birch":r[4],
				"Spruce": r[5], 
				"Other1 Tree": r[6], 
				"Other2 Tree": r[7], 
				"Grass": r[8], 
				"Grass2":r[9],
				"Weed": r[10], 
				"Other1": r[11], 
				"Other2": r[12],
				"Mold": r[13]
			})

			# Adjust for when year changes. 
			if yearHolder != r[0].year:
				workingYear["Data"] = lists
				yearHolder = r[0].year
				workingYear["Year"] = yearHolder
				polArray.append(deepcopy(workingYear))
			 
				lists = []

		return json.dumps(polArray)


	def do_GET(self):

		# Use this for passing parameters. Functions for specific query still need to 
		# dealt with. 
		params = parse_qs(urlparse(self.path).query)


		cursor = self.DBconnection()
		cursor.execute(self.pollenQuery())
		
		# Retrieve ALL data.
		response = cursor.fetchall()

		self.send_response(200)
		self.send_header("Content-Type",'application/json')
		self.end_headers()
		self.wfile.write(bytes(str(self.easyJsonify(response)),"utf8"))

		self.closeDBconnection()





if __name__ == '__main__':
	server_address = ('127.0.0.1',8080)
	server = HTTPServer(server_address,echoServer)
	server.serve_forever()
