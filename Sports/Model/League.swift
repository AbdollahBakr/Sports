//
//  League.swift
//  Sports
//
//  Created by Abdollah Bakr on 05/06/2022.
//

import Foundation

struct League: Decodable {
    var idLeague:String?
    var strSport:String?
    var strLeague:String?
    var strLeagueAlternate:String?
    var strCurrentSeason:String?
    var strCountry:String?
    var strWebsite:String?
    var strFacebook:String?
    var strTwitter:String?
    var strYoutube:String?
    var strRSS:String?
    var strDescriptionEN:String?
    var strBanner:String?
    var strBadge:String?
    var strLogo:String?
    var strPoster:String?
    var strTrophy:String?
    
}

struct LeaguesResponse: Decodable {
    var countries: [League]
}

// https://www.thesportsdb.com/api/v1/json/2/search_all_leagues.php?c=England
/*
 {
   "countries": [
     {
       "idLeague": "4372",
       "idSoccerXML": null,
       "idAPIfootball": null,
       "strSport": "Motorsport",
       "strLeague": "BTCC",
       "strLeagueAlternate": "British Touring Car Championship",
       "intDivision": "1",
       "idCup": "0",
       "strCurrentSeason": "2022",
       "intFormedYear": "1958",
       "dateFirstEvent": "2015-04-04",
       "strGender": "Mixed",
       "strCountry": "England",
       "strWebsite": "btcc.net",
       "strFacebook": "www.facebook.com/OfficialBTCC",
       "strInstagram": null,
       "strTwitter": "twitter.com/dunlopbtcc",
       "strYoutube": "www.youtube.com/user/btccdotnet",
       "strRSS": "http://www.btcc.net/feed/",
       "strDescriptionEN": "The British Touring Car Championship is a touring car racing series held each year in the United Kingdom, currently organized and administered by ToCA. It was established in 1958 as the British Saloon Car Championship and was renamed as the British Touring Car Championship in 1987. The championship has been run to various national and international regulations over the years including FIA Group 2, FIA Group 5, FIA Group 1, FIA Group A, FIA Super Touring and FIA Super 2000. A lower-key Group N series for production cars ran from 2000 until 2003.\r\n\r\nThe championship was initially run with a mix of classes, divided according to engine capacity, racing simultaneously. This often meant that a driver who chose the right class could win the overall championship without any chance of overall race wins, thereby devaluing the title for the spectators – for example, in the 1980s Chris Hodgetts won two overall titles in a small Toyota Corolla prepared by Hughes Of Beaconsfield, at that time a Mercedes-Benz/Toyota main dealer when most of the race wins were going to much larger cars; and while the Ford Sierra Cosworth RS500s were playing at the front of the field, Frank Sytner took a title in a Class B BMW M3 and John Cleland's first title was won in a small Class C Vauxhall Astra.\r\n\r\nAfter the domination (and expense) of the Ford Sierra Cosworth in the late 1980s, the BTCC was the first to introduce a 2.0 L formula, in 1990, which later became the template for the Supertouring class that exploded throughout Europe. The BTCC continued to race with Supertouring until 2000 and for 2001 adopted its own BTC Touring rules. However, the Super 2000 rules have now been observed for the overall championship since the 2007 season. The 2000s have seen cheaper cars than the later Supertouring era, with fewer factory teams and fewer international drivers.\r\n\r\nIn 2009, the BTCC released details of its Next Generation Touring Car (NGTC) specification, to be introduced from 2011. The introduction of these new technical regulations were designed to dramatically reduce the design, build and running costs of the cars and engines as well as reducing the potential for significant performance disparities between cars. The NGTC specification also aimed to cut costs by reducing reliance on WTCC/S2000 equipment, due to increasing costs/complexity and concerns as to its future sustainability and direction.",
       "strDescriptionDE": "Die British Touring Car Championship (BTCC, Britische Tourenwagen-Meisterschaft) ist eine Tourenwagen-Rennserie.\r\n\r\nPro Rennwochenende finden sonntags drei gleich lange Wertungsläufe statt. Samstags stehen zwei 40-minütige Trainingsdurchgänge auf dem Programm, in denen die Teams an der Abstimmung arbeiten können. Nachmittags entscheidet eine 30-minütige Qualifikation über die Startaufstellung des ersten Laufs. Die Startaufstellung des zweiten Laufs entspricht dem Zieleinlauf des ersten Rennens. Ähnlich wie in der Tourenwagen-Weltmeisterschaft erfolgt die Startreihenfolge für den dritten Lauf in umgekehrter Reihenfolge der Zieleinkunft. Im Gegensatz zur WTCC ist nicht auf die ersten acht festgelegt, sondern der Sieger des zweiten Laufes lost aus, ob dies für die ersten 6 bis 10 Fahrzeuge gilt. Nach dem ersten und zweiten Rennen werden jeweils Zusatzgewichte zwischen 45 und 9 Kilo für die fünf Bestplatzierten vergeben. Pro Fahrzeug sind in der Saison lediglich fünf Motoren zugelassen. Wer ein zusätzliches Triebwerk benötigt, verliert zehn Meisterschaftszähler in der Hersteller- und Teamwertung.",
       "strDescriptionFR": "Le Championnat britannique des voitures de tourisme (British Touring Car Championship, ou BTCC, en anglais) a été organisé pour la première fois en 1958 à l'occasion du British Saloon Car Championship.",
       "strDescriptionIT": null,
       "strDescriptionCN": null,
       "strDescriptionJP": null,
       "strDescriptionRU": null,
       "strDescriptionES": null,
       "strDescriptionPT": null,
       "strDescriptionSE": null,
       "strDescriptionNL": null,
       "strDescriptionHU": null,
       "strDescriptionNO": null,
       "strDescriptionPL": null,
       "strDescriptionIL": null,
       "strTvRights": null,
       "strFanart1": "https://www.thesportsdb.com/images/media/league/fanart/rvytyq1422037335.jpg",
       "strFanart2": "https://www.thesportsdb.com/images/media/league/fanart/swyyuy1432747584.jpg",
       "strFanart3": "https://www.thesportsdb.com/images/media/league/fanart/wstuqu1432747622.jpg",
       "strFanart4": "https://www.thesportsdb.com/images/media/league/fanart/xpywtt1422039975.jpg",
       "strBanner": "https://www.thesportsdb.com/images/media/league/banner/vrruvt1422121957.jpg",
       "strBadge": "https://www.thesportsdb.com/images/media/league/badge/a0xreq1556444753.png",
       "strLogo": "https://www.thesportsdb.com/images/media/league/logo/0d5zf81556444796.png",
       "strPoster": "https://www.thesportsdb.com/images/media/league/poster/ev49rz1539014930.jpg",
       "strTrophy": "https://www.thesportsdb.com/images/media/league/trophy/vba0vd1560370776.png",
       "strNaming": "{strEvent}",
       "strComplete": "yes",
       "strLocked": "unlocked"
     }
 */
