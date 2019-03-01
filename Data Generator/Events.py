from FillMatches import FillMatches
from FillRandomData import FillRandomDataHowHaveLocation
from random import randrange
import random, requests, time, json
from datetime import datetime
import time

headers = {'Content-Type': 'application/json'}

class GenerateEvent:
    class Event:
        def __init__(self, MatchId, DescriptionEvent, ScoreHomeTeam, ScoreAwayTeam, TimeEvent):
            self.MatchId = MatchId
            self.DescriptionEvent = DescriptionEvent
            self.ScoreAwayTeam = ScoreAwayTeam
            self.ScoreHomeTeam = ScoreHomeTeam
            self.TimeEvent = TimeEvent

        def toJSON(self):
            return json.dumps(self.__dict__)

    def sendEventsToAPI(self, myAPIServer):
        server = myAPIServer + 'kafka/event'
        i = 0
        while True:
            # time.sleep(1)
            # FillMatches.lastIdMatch = 10
            if FillMatches.lastIdMatch > 1:
                randomMatchId = random.randint(1, FillMatches.lastIdMatch-1)
                matchById = requests.get(myAPIServer + 'data/match/' + str(randomMatchId))

                jsonMatch = json.loads(matchById.text)
                whoseBall = True if(random.randint(0, 20) > 10) else False
                scoreHomeTeam =  jsonMatch['scoreHomeTeam'] + 1 if (whoseBall) else jsonMatch['scoreHomeTeam'] 
                scoreAwayTeam = jsonMatch['scoreAwayTeam'] + 1 if (whoseBall == False) else jsonMatch['scoreAwayTeam']
                
                typeEvent = ['Goal', 'Card', 'Started']
                indexEvent = random.randint(0, len(typeEvent)-1)
                description = typeEvent[0] if (indexEvent == 0) else typeEvent[2] if (indexEvent == 2) else self.getRandomCard()

                data = self.Event(random.randint(1, FillMatches.lastIdMatch - 1), description, 
                    scoreHomeTeam, 
                    scoreAwayTeam, 
                    str(datetime.now().time()))

                response = requests.post(server, data=data.toJSON(), headers=headers)
                print 'Event sent!' + str(i) + '     ' + str(scoreHomeTeam) + ':' + str(scoreAwayTeam)

                i = i + 1
    
    def getRandomCard(self):
        listPlayers = [
            'Sherry George',
            'Willie Graves',
            'Chad Mckinney',
            'Ritthy Morris',
            'Brennan Rhodes',
            'Chester Wheeler',
            'Kent Johnston',
            'Arthur Smith',
            'Clarence Robinson'
        ]
        cardTypes = ['Red Card', 'Yellow Card']
        teams = ['Shields',
        'Pros',
        'Majors',
        'Kings']
        indexPlayer = random.randint(0, len(listPlayers)-1)
        indexCard = random.randint(0, len(cardTypes)-1)
        indexTeams = random.randint(0, len(teams)-1)

        return cardTypes[indexCard] + '; ' + listPlayers[indexPlayer] + '; ' + teams[indexTeams]
