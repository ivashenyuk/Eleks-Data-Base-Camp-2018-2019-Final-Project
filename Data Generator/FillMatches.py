from FillSportAndTournaments import FillSportAndTournaments
from FillTeamsAndClubs import FillTeamsAndClubs
from FillRandomData import FillRandomDataHowHaveLocation
from random import randrange
import random, requests, time, json

headers = {'Content-Type': 'application/json'}

class FillMatches:
    class Match:
        def __init__(self,  id, homeTeamId,awayTeamId,managerId,locationId,sportId,
            tournamentId,date):
            self.id = id
            self.homeTeamId = homeTeamId
            self.awayTeamId = awayTeamId
            self.managerId = managerId
            self.locationId = locationId
            self.sportId = sportId
            self.tournamentId = tournamentId
            self.date = date

        def toJSON(self):
            return json.dumps(self.__dict__)

    def sendToApi(self, myAPIServer):
        server = myAPIServer + 'data/match'
        while True:
            try:
                
                if (FillSportAndTournaments.lastIdSport > 1 and FillSportAndTournaments.lastIdTournament > 1
                    and  FillTeamsAndClubs.lastIdTeam  > 1 and FillRandomDataHowHaveLocation.lastIdLocation > 1):

                    randomSportId = random.randint(1, FillSportAndTournaments.lastIdSport-1)
                    randomTournamentId = random.randint(1, FillSportAndTournaments.lastIdTournament-1)
                    randomHomeTeamId = random.randint(1, FillTeamsAndClubs.lastIdTeam-1)
                    randomAwayTeamId = random.randint(1, FillTeamsAndClubs.lastIdTeam-1)
                    if(randomHomeTeamId == randomAwayTeamId):
                        randomAwayTeamId = random.randint(1, FillTeamsAndClubs.lastIdTeam-1)
                    randomLocationId = random.randint(1, FillRandomDataHowHaveLocation.lastIdLocation-1)
                    randomDateVar = self.randomDate("1/1/2019 1:30 PM", "1/1/2025 4:50 AM", random.random())

                    match = self.Match(0, randomHomeTeamId, randomAwayTeamId, 6, randomLocationId, randomSportId, randomTournamentId, randomDateVar)
                    response = requests.post(server, data=match.toJSON(), headers=headers)
                    FillMatches.lastIdMatch = int(response.text)
                    print 'Match with id ' + response.text + ' was added.'
            except:
                pass

    def strTimeProp(self, start, end, format, prop):
        stime = time.mktime(time.strptime(start, format))
        etime = time.mktime(time.strptime(end, format))

        ptime = stime + prop * (etime - stime)

        return time.strftime(format, time.localtime(ptime))


    def randomDate(self, start, end, prop):
        return self.strTimeProp(start, end, '%m/%d/%Y %I:%M %p', prop)
FillMatches.lastIdMatch = 0

    
    
