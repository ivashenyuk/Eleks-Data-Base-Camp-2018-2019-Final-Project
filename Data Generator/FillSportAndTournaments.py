import requests, datetime, random, json
from random import randrange
from decimal import Decimal, getcontext
from arrayWithSports import arrayWithSports
import lxml.html
from bs4 import BeautifulSoup
from html_table_parser import HTMLTableParser
import urllib

headers = {'Content-Type': 'application/json'}

class FillSportAndTournaments:

    class Sport:
        def __init__(self, id, name, description):
            self.id = id
            self.name = name
            self.description = description

        def toJSON(self):
            return json.dumps(self.__dict__)

    class Tournament:
        def __init__(self, id, name, organizationName, description):
            self.id = id
            self.name = name
            self.organizationName = organizationName
            self.description = description

        def toJSON(self):
            return json.dumps(self.__dict__)

    def fillSports(self, myAPIServer):
        server = myAPIServer + 'data/sport'
        
        for sportname in arrayWithSports:
            try:
                sportObject = self.Sport(0, sportname, 'Kind of sport')
                response = requests.post(server, data=sportObject.toJSON(), headers=headers)
                FillSportAndTournaments.lastIdSport = int(response.text)
                print 'Kind of sport with id ' + response.text + ' was added.'
            except:
                pass
    
    def fillTournaments(self, myAPIServer):
        server = myAPIServer + 'data/tournament'
        

        page = 0
        while page <= 5400:
            try:
                xhtml = self.url_get_contents('https://www.cagematch.net/?id=26&s='+str(page)).decode('utf-8')
                page = page + 100
                p = HTMLTableParser()
                p.feed(xhtml)
                table = p.tables[0]
                table.pop(0)
                
                for title in table:
                    data = self.Tournament(0, title[2], 'FIFA', None).toJSON()
                    response = requests.post(server, data=data, headers=headers)
                    FillSportAndTournaments.lastIdTournament = int(response.text)
                    print 'Tournament with id ' + response.text + ' was added.'
            except:
                pass

    def url_get_contents(self, url):
        """ Opens a website and read its binary contents (HTTP Response Body) """
        # req = urllib.Request(url=url)
        f = urllib.urlopen(url)
        return f.read()
FillSportAndTournaments.lastIdTournament = 0
FillSportAndTournaments.lastIdSport = 0