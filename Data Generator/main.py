# coding=utf-8
import threading
import multiprocessing
from FillTeamsAndClubs import FillTeamsAndClubs
from FillRandomData import FillRandomDataHowHaveLocation
from FillSportAndTournaments import FillSportAndTournaments
from FillMatches import FillMatches
from FillBanksInformation import FillBanksInformation
from Bets import Generate
from Events import GenerateEvent

headers = {'Content-Type': 'application/json'}

fillTeamsAndClubs = FillTeamsAndClubs()
randomData = FillRandomDataHowHaveLocation()
sportAndTournaments = FillSportAndTournaments()
randomMatch = FillMatches()
fillBanksInformation = FillBanksInformation()
betsGenerator = Generate()
eventsGenerator = GenerateEvent()

def fillData():
    myAPIServer = "http://localhost:8080/api/"
    # randomData.sendLocationToMyAPI(myAPIServer) #register(myAPIServer)
  
    thread0 = threading.Thread(target=fillTeamsAndClubs.sendClubsToApi, args=[myAPIServer])
    thread1 = threading.Thread(target=fillTeamsAndClubs.sendTeamsToAPI, args=[myAPIServer])
    thread2 = threading.Thread(target=randomData.sendLocationToMyAPI, args=[myAPIServer])
    thread3 = threading.Thread(target=sportAndTournaments.fillSports, args=[myAPIServer])
    thread4 = threading.Thread(target=sportAndTournaments.fillTournaments, args=[myAPIServer])
    thread5 = threading.Thread(target=randomMatch.sendToApi, args=[myAPIServer])
    thread6 = threading.Thread(target=randomData.register, args=[myAPIServer])
    thread7 = threading.Thread(target=fillBanksInformation.sendBanksToAPI, args=[myAPIServer])
    thread8 = threading.Thread(target=betsGenerator.sendBetsToAPI, args=[myAPIServer])
    thread9 = threading.Thread(target=eventsGenerator.sendEventsToAPI, args=[myAPIServer])

    thread0.start()
    thread1.start()
    thread2.start()
    thread3.start()
    thread4.start()
    thread5.start()
    thread6.start()
    thread7.start()
    thread8.start()
    thread9.start()

    thread0.join()
    thread1.join()
    thread2.join()
    thread3.join()
    thread4.join()
    thread5.join()
    thread6.join()
    thread7.join()
    thread8.join()
    thread9.join()


if(__name__ == "__main__"):
    # while True:
    fillData()
        # time.sleep(1)