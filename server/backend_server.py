#!/usr/bin/env python3

from http.server import BaseHTTPRequestHandler, HTTPServer
from urllib.parse import urlparse,parse_qs
from bson import json_util
import json
import pymysql.cursors

class PollenServer(BaseHTTPRequestHandler):
	
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

	# Close the connection.
	def closeDBconnection(self):
		self.conn.close()


	''' 
	PollenQuery - Returns a string that pulls pollen data

	Change the query to acquire specific pollen data.

	MySQL PollenData table description below. 
	
	+--------------+--------------+------+-----+---------+----------------+
	| Field        | Type         | Null | Key | Default | Extra          |
	+--------------+--------------+------+-----+---------+----------------+
	| id           | int(11)      | NO   | PRI | NULL    | auto_increment |
	| date         | date         | NO   |     | NULL    |                |
	| time         | varchar(10)  | YES  |     | NULL    |                |
	| location     | varchar(10)  | NO   |     | NULL    |                |
	| alder        | int(11)      | NO   |     | NULL    |                |
	| willow       | int(11)      | NO   |     | NULL    |                |
	| poplar_aspen | int(11)      | NO   |     | NULL    |                |
	| birch        | int(11)      | NO   |     | NULL    |                |
	| spruce       | int(11)      | NO   |     | NULL    |                |
	| other1_tree  | int(11)      | NO   |     | NULL    |                |
	| other2_tree  | int(11)      | NO   |     | NULL    |                |
	| total_tree   | int(11)      | NO   |     | NULL    |                |
	| grass        | int(11)      | NO   |     | NULL    |                |
	| grass_2      | int(11)      | NO   |     | NULL    |                |
	| total_grass  | int(11)      | NO   |     | NULL    |                |
	| weed         | int(11)      | NO   |     | NULL    |                |
	| other1       | int(11)      | NO   |     | NULL    |                |
	| other2       | int(11)      | NO   |     | NULL    |                |
	| total_pollen | int(11)      | NO   |     | NULL    |                |
	| mold         | int(11)      | NO   |     | NULL    |                |
	| comments     | varchar(400) | YES  |     | NULL    |                |
	+--------------+--------------+------+-----+---------+----------------+
	'''
	def pollenQuery(self):
		query = "SELECT date, alder, willow, \
			poplar_aspen, birch, spruce, \
			other1_tree, other2_tree, grass, grass_2, \
			weed, other1, other2, mold FROM PollenData;"

		return query


	# On GET request, query the MySQL DB, format data into pollendata blocks, and return
	# as a string.
	def do_GET(self):

		params = parse_qs(urlparse(self.path).query)
		cursor = self.DBconnection()


		cursor.execute(self.pollenQuery())
		response = cursor.fetchall()

		pollenList = []

		for row in response:
			#print(row)
			#print(len(row))
			for i in range(len(row)):
				print(row[i])

		retStr = ''

#		retStr1 = json.dumps(response, default=json_util.default)

		retStr1 = ''

		for r in response:

			str1 = ''
			str1 += '('
			for j in r:

				str1 += str(j) + ' '

			str1 += ')'
			retStr += str1 + '\n'


		self.closeDBconnection()

		self.send_response(200)
		self.end_headers()
		self.wfile.write(bytes(retStr,"utf8"))



if __name__ == '__main__':
	server_address = ('127.0.0.1',8080)
	server = HTTPServer(server_address,PollenServer)
	server.serve_forever()
