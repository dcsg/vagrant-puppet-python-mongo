__author__      = 'Daniel Gomes <me@danielcsgomes.com>'
__description__ = 'Sample example on creating a database, colletion and documents and printing them on MongoDB using pymongo.'

from pymongo import MongoClient

class Sample:
    def __init__(self):
        self.connection = MongoClient('localhost', 27017)
        self.db = self.connection.sample
        self.collection = self.db.countries
        self.data = self.collection.find({})
        if self.data.count() == 0:
            self.collection.insert([
                {'name': 'Portugal'},
                {'name': 'USA'},
                {'name': 'Spain'},
                {'name': 'France'},
                {'name': 'UK'},
                {'name': 'Brasil'},
            ])
            self.data = self.collection.find({})

        self.printDatabaseContent()

    def printDatabaseContent(self):
        for document in self.data:
            print document.get('name')

Sample()


