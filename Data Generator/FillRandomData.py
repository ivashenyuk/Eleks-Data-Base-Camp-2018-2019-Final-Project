# coding=utf-8
import requests, datetime, random, json, time, pprint
from random import randrange
from decimal import Decimal, getcontext
from bs4 import BeautifulSoup as BS
import urllib2
import lxml.html
from facebookads.adobjects.targetingsearch import TargetingSearch
from facebookads.session import FacebookSession


headers = {'Content-Type': 'application/json'}

class FillRandomDataHowHaveLocation:

    class User: 
        def __init__(self,  id, roleId, locationId, userGroupId, firstName, lastName, birthDay, email, phone, password, age, emailIsConfirmed,
            phoneIsConfirmed, isConfirmedAdministrations, language):
            self.id = id
            self.roleId = roleId
            self.locationId = locationId
            self.userGroupId = userGroupId
            self.firstName = firstName
            self.lastName = lastName
            self.birthDay = birthDay
            self.email = email
            self.phone = phone
            self.password = password
            self.age = age
            self.emailIsConfirmed = emailIsConfirmed
            self.phoneIsConfirmed = phoneIsConfirmed
            self.isConfirmedAdministrations = isConfirmedAdministrations
            self.language = language

        def toJSON(self):
            return json.dumps(self.__dict__)
    
    def RandomUser(self):
        #  headers = {'Content-Type': 'application/json'}
        jsonResponse = requests.get("https://randomuser.me/api/")

        informationAbouUser = json.loads(jsonResponse.text)

        firstname = informationAbouUser['results'][0]['name']['first']
        lastname = informationAbouUser['results'][0]['name']['last']
        email =  informationAbouUser['results'][0]['email']
        phone =  informationAbouUser['results'][0]['phone']
        birthday = informationAbouUser['results'][0]['dob']['date']
        age = informationAbouUser['results'][0]['dob']['age']
        password = informationAbouUser['results'][0]['login']['password']
        randomLocationId = 0
        if (FillRandomDataHowHaveLocation.lastIdLocation > 1):
            randomLocationId = random.randint(1, FillRandomDataHowHaveLocation.lastIdLocation-1)

        return self.User(-1, 1, randomLocationId, random.randint(1, 3), firstname, lastname, birthday, email, phone, password, age, False, False, False, 'English')

    def getLocationFromFaceBookAPI(self):
        params = {
            'q': '9',
            'type': 'adgeolocation',
            'location_types': ['zip'],
            'limit': 50000,
            'access_token': '2380417028852569|eRAylHLRbRViWJMMI30YDWDvfPE'
        }
        
        resp = requests.get('https://graph.facebook.com/v2.11/search', headers=headers, params=params)
        jsonFacebook = json.loads(resp.text)

        return jsonFacebook['data']
        

    def sendLocationToMyAPI(self, myAPIServer):
        server = myAPIServer + 'data/location'
        jsonFacebook = self.getLocationFromFaceBookAPI()
        
        for location in jsonFacebook:    
            try:
                country = location['country_name']
                state = location['region']
                city = location['primary_city']
                # print city
                # break
                data = {
                    'city': city,
                    'state': state,
                    'country': country
                }
                response = requests.post(server, data=json.dumps(data), headers=headers)
                FillRandomDataHowHaveLocation.lastIdLocation = int(response.text)
                print 'Location with id ' + response.text + ' was added.'
            except:
                pass   
            


    def register(self, myAPIServer):
       
        server = myAPIServer + 'data/user'
        while True:
            try:
                randomUser = self.RandomUser()
                response = requests.post(server, data=randomUser.toJSON(), headers=headers)
                FillRandomDataHowHaveLocation.lastIdUser = int(response.text)
                print 'User with id ' + response.text + ' was added.'
            except:
                pass
FillRandomDataHowHaveLocation.lastIdLocation = 0
FillRandomDataHowHaveLocation.lastIdUser = 0
