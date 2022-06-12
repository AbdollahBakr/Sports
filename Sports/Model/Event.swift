//
//  Event.swift
//  Sports
//
//  Created by Abdollah Bakr on 11/06/2022.
//

import Foundation

struct Event: Decodable {
    var idEvent:String?
    var strEvent:String?
    var strEventAlternate:String?
    var strFilename:String?
    var strSport:String?
    var idLeague:String?
    var strLeague:String?
    var strSeason:String?
    var strHomeTeam:String?
    var strAwayTeam:String?
    var intHomeScore:String?
    var intRound:String?
    var intAwayScore:String?
    var strTimestamp:String?
    var dateEvent:String?
    var dateEventLocal:String?
    var strTime:String?
    var strTimeLocal:String?
    var strCountry:String?
    var strThumb:String?
    var strStatus:String?
}
struct EventsResponse: Decodable {
    var events: [Event]
}

/*
 {
       "idEvent": "1369075",
       "idSoccerXML": null,
       "idAPIfootball": "787153",
       "strEvent": "KS Teuta vs Partizani",
       "strEventAlternate": "Partizani @ KS Teuta",
       "strFilename": "Albanian Superliga 2021-09-10 KS Teuta vs Partizani",
       "strSport": "Soccer",
       "idLeague": "4617",
       "strLeague": "Albanian Superliga",
       "strSeason": "2021-2022",
       "strDescriptionEN": "",
       "strHomeTeam": "KS Teuta",
       "strAwayTeam": "Partizani",
       "intHomeScore": "1",
       "intRound": "1",
       "intAwayScore": "0",
       "intSpectators": null,
       "strOfficial": "",
       "strTimestamp": "2021-09-10T17:45:00+00:00",
       "dateEvent": "2021-09-10",
       "dateEventLocal": "2021-09-11",
       "strTime": "17:45:00",
       "strTimeLocal": "17:00:00",
       "strTVStation": null,
       "idHomeTeam": "134055",
       "idAwayTeam": "137799",
       "intScore": null,
       "intScoreVotes": null,
       "strResult": "",
       "strVenue": "Stadiumi Niko Dovana",
       "strCountry": "Albania",
       "strCity": "",
       "strPoster": "",
       "strSquare": "",
       "strFanart": null,
       "strThumb": "https://www.thesportsdb.com/images/media/event/thumb/omth271639087437.jpg",
       "strBanner": "",
       "strMap": null,
       "strTweet1": "",
       "strTweet2": "",
       "strTweet3": "",
       "strVideo": "",
       "strStatus": "Match Finished",
       "strPostponed": "no",
       "strLocked": "unlocked"
     }
 */
