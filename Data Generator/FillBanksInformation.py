from FillSportAndTournaments import FillSportAndTournaments
from FillTeamsAndClubs import FillTeamsAndClubs
from FillRandomData import FillRandomDataHowHaveLocation
from random import randrange
import random, requests, time, json
import xml.etree.ElementTree as ET

headers = {'Content-Type': 'application/json'}

class FillBanksInformation:


    class BankCard:
        def __init__(self, id, userId, bankId, cardNumber,expiryDateCard, digitsOnBackOfCard, isConfirmedCard):
            self.id = id 
            self.userId = userId
            self.bankId = bankId
            self.cardNumber = cardNumber
            self.expiryDateCard = expiryDateCard
            self.digitsOnBackOfCard = digitsOnBackOfCard
            self.isConfirmedCard = isConfirmedCard

        def toJSON(self):
            return json.dumps(self.__dict__)

    class Bank:
        def __init__(self, id, name, minMoneyToWithdraw, commission, timeOfProcessing, description):
            self.id = id
            self.name = name
            self.minMoneyToWithdraw = minMoneyToWithdraw
            self.commission = commission
            self.timeOfProcessing = timeOfProcessing
            self.description = description

        def toJSON(self):
            return json.dumps(self.__dict__)

    def sendBanksToAPI(self, myAPIServer):
        server = myAPIServer + 'data/bank'
        # try:
        
        banks = requests.post('https://www.mithrilandmages.com/utilities/BankNames.php?xjxfun=generate_names&xjxr=1549743558037&xjxargs[]=S50&xjxargs[]=S0')
        
        root = ET.fromstring(banks.text)
        tmpList = root[0].text.split('\n')
        bankNames = []
        for li in tmpList:
            li = li.replace('<li>', '')
            li = li.replace('</li>', '')
            li = li.replace('S<ul>', '')
            li = li.replace('</ul', '')
            if(li != ''):
                bankNames.append(li)
        
        for bankName in bankNames:
            randomTimeOfProcessing = random.randint(60, 3600)
            bank = self.Bank(0, bankName, 500, random.uniform(0.05, 0.4), randomTimeOfProcessing, bankName)
            response = requests.post(server, data=bank.toJSON(), headers=headers)
            FillBanksInformation.lastIdBank = int(response.text)
            print 'Bank with id ' + response.text + ' was added.'
        # except:
        #     print 'Error!'
        #     pass
FillBanksInformation.lastIdBank = 0