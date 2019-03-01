from FillMatches import FillMatches
from FillRandomData import FillRandomDataHowHaveLocation
from random import randrange
import random, requests, time, json

headers = {'Content-Type': 'application/json'}

class Generate:
    class Bet:
        def __init__(self, MatchId, UserId, ScoreHomeTeam, ScoreAwayTeam, PutMoney ):
            self.MatchId = MatchId
            self.UserId = UserId
            self.ScoreAwayTeam = ScoreAwayTeam
            self.ScoreHomeTeam = ScoreHomeTeam
            self.PutMoney = PutMoney
        def toJSON(self):
            return json.dumps(self.__dict__)

    def sendBetsToAPI(self, myAPIServer):
        server = myAPIServer + 'kafka/bet'
        counter = 0
        timeStart =  time.time()
        timeEnd = 0
        while True:

            # FillMatches.lastIdMatch = 33
            # FillRandomDataHowHaveLocation.lastIdUser = 47
            if FillMatches.lastIdMatch > 2 and FillRandomDataHowHaveLocation.lastIdUser > 2:
                data = self.Bet(random.randint(1, FillMatches.lastIdMatch-1), random.randint(1, FillRandomDataHowHaveLocation.lastIdUser-1), random.randint(0, 30), random.randint(0, 30), random.randint(1, 10000))
                response = requests.post(server, data=data.toJSON(), headers=headers)
                print 'Bet sent!' + ' >>>>> response  >>>>> ' + response.text
                counter = counter + 1
                
            timeEnd =  time.time()
            # if(timeEnd - timeStart > 10):

            #     print counter
            #     break


