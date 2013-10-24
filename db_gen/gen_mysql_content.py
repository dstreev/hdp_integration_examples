#!/usr/bin/env
import csv
import mysql.connector
import random
import os
import sys

class Mgen:
    def __init__(self, server='localhost', port=3306):
        self.script_path = os.path.dirname(os.path.realpath(sys.argv[0]))
        self.server = server
        self.port = port
        self.states = {}
        self.state_codes = []
        self.first_names = []
        self.cities = []
        self.last_names = []
        self.load_states(self.script_path + "/data/states.csv")
        self.load_male_first_names(self.script_path + "/data/male.firstnames.csv")
        self.load_female_first_names(self.script_path + "/data/female.firstnames.csv")
        self.load_cities(self.script_path + "/data/cities.csv")
        self.load_last_names(self.script_path + "/data/surnames.csv")

    def load_states(self, path):
        try:
            csv_reader  = csv.reader(open(path, 'r'))
            for long_name, code in csv_reader:
                self.states[code] = long_name 
                self.state_codes.append(code)
        except:
            print "Could not load the states.csv"

    def load_male_first_names(self, path):
        csv_reader = csv.reader(open(path, 'r'))
        for first_name in csv_reader:
            if "None" not in first_name:
                self.first_names.append(first_name[0])        

    def load_female_first_names(self, path):
        csv_reader = csv.reader(open(path, 'r'))
        for first_name in csv_reader:
            if "None" not in first_name:
                self.first_names.append(first_name[0])

    def load_cities(self, path):
        #this isn't really a csv
        csv_reader = csv.reader(open(path, 'r'))
        for city in csv_reader:
            self.cities.append(city[0])

    def load_last_names(self, path):
        csv_reader = csv.reader(open(path,'r'))
        for name in csv_reader:
            self.last_names.append(name[0])        

    def generate_zip(self):
        return random.randrange(15000, 28000, 1)

    def generate_row(self):
        first_name = self.first_names[random.randrange(0, len(self.first_names), 1)]
        last_name = self.last_names[random.randrange(0, len(self.last_names), 1)]
        state_code = self.state_codes[random.randrange(0, len(self.state_codes), 1)]        
        zip = self.generate_zip()
        city = self.cities[random.randrange(0, len(self.cities), 1)]
        return first_name, last_name, state_code, city, zip

    def generate_states_table(self):
        try:
            myconnector = mysql.connector.connect(user='sample', password='sample', database='sample')
            cursor = myconnector.cursor()
            print "Connected"

            query = ("DROP table IF EXISTS states")
            cursor.execute(query)
            query = ("CREATE TABLE states (state VARCHAR(100), state_code CHAR(2))")
            cursor.execute(query)
            for key in self.states:
                cursor.execute("INSERT INTO states (state, state_code) VALUES (%s, %s)", (self.states[key], key))
            myconnector.commit()
            cursor.close()
            myconnector.close()
        except:
            print "Unexpected error:", sys.exc_info()[0]
            return

    def test_users_table_exists(self):
        try:
            myconnector = mysql.connector.connect(user='sample', password='sample', database='sample')
            cursor = myconnector.cursor()
            cursor.execute("SELECT count(*) FROM information_schema.tables WHERE table_schema = 'sample' and table_name = 'users'")

            table_status = cursor.fetchone()[0]
            if table_status == 1:
                return True
            else:
                return False
        except:
            return False
    def generate_users_table(self, rowcount):
        if not self.test_users_table_exists():
            print "'sample.users' doesn't exist.  Did you initialize the db?"
            return
        user_count = 0
        try:
            myconnector = mysql.connector.connect(user='sample', password='sample', database='sample')
            cursor = myconnector.cursor()
            print "Connected"

            for i in range(rowcount): 
                first_name, last_name, state_code, zip, city = self.generate_row()
                cursor.execute("INSERT INTO users (first_name, last_name, state_code, city, zipcode) VALUES (%s, %s, %s, %s, %s)", (first_name, last_name, state_code, zip, city))
                user_count += 1
            myconnector.commit()
            cursor.close()
            myconnector.close()
            print "Inserted %d users." % (user_count)
        except:
            print "Unexpected error:", sys.exc_info()[0]
            return

if __name__ == "__main__":
    try:
        runner = Mgen()
        runner.generate_states_table()
        runner.generate_users_table(rowcount=10000)
    except:
        print "Unexpected error:", sys.exc_info()[0]
