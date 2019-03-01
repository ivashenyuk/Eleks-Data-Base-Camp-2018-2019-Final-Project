import requests, datetime, random, json
from random import randrange
from decimal import Decimal, getcontext

class FillTeamsAndClubs:
    
    headers = {'Content-Type': 'application/json'}
    class Club:
        def __init__(self, id, clubManagerId, name):
            self.id = id
            self.clubManagerId = clubManagerId
            self.name = name
        def toJSON(self):
            return json.dumps(self.__dict__)

    class Team:
        def __init__(self, id, clubId, teamManagerId, name):
            self.id = id
            self.clubId = clubId
            self.teamManagerId = teamManagerId
            self.name = name
        def toJSON(self):
            return json.dumps(self.__dict__)

    def sendTeamsToAPI(self, myAPIServer):
        
        while True:
            try:
                jsonResponse = requests.post("http://fantasyfootball.sportsunlimitedinc.com/ajax.php?action=getRandomName&_=154970089")
                if (FillTeamsAndClubs.lastIdClub > 1):
                    randomClubId = random.randint(0, FillTeamsAndClubs.lastIdClub-1)
                    if (randomClubId ==  34 or randomClubId == 167 or randomClubId == random.randint(0, 237)):
                        randomClubId = 0
                    data = self.Team(0, randomClubId, 5, jsonResponse.text)

                    response = requests.post(myAPIServer + "/data/team", data=data.toJSON(), headers=self.headers)
                    FillTeamsAndClubs.lastIdTeam = int(response.text)
                    print 'Team with id ' + response.text + ' was added.'
            except:
                pass

    def sendClubsToApi(self, myAPIServer):
        while True:
            try:
                jsonResponse = requests.post("http://fantasyfootball.sportsunlimitedinc.com/ajax.php?action=getRandomName&_=154970089")
                data = self.Club(0, 4, jsonResponse.text)

                response = requests.post(myAPIServer + "/data/club", data=data.toJSON(), headers=self.headers)
                FillTeamsAndClubs.lastIdClub = int(response.text)
                print 'Club with id '  + response.text +' was added.'
            except:
                pass
FillTeamsAndClubs.lastIdTeam = 0
FillTeamsAndClubs.lastIdClub = 0
        
