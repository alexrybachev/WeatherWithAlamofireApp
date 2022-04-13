//
//  Weather.swift
//  WeatherWithAlamofireApp
//
//  Created by Aleksandr Rybachev on 13.04.2022.
//

enum Link: String {
    case weatherAPI = "https://weatherdbi.herokuapp.com/data/weather/london"
}

struct Weather: Decodable {
    let region: String?
    let currentConditions: CurrentConditions?
    let next_days: [NextDay]?
    let contact_author: Author?
    let data_source: String?
}

struct CurrentConditions: Decodable {
    let dayhour: String?
    let temp: Temp?
    let precip: String?
    let humidity: String?
    let wind: Wind?
    let iconURL: String?
    let comment: String?
    
    var currentWeather: String {
        """
        \(comment ?? "")
        
        Precipitation: \(precip ?? "")
        Humidity: \(humidity ?? "")
        
        Temperature (C): \(temp?.c ?? 0)
        """
    }
}

struct Temp: Decodable {
    let c: Int?
    let f: Int?
}

struct Wind: Decodable {
    let km: Int?
    let mile: Int?
}

struct NextDay: Decodable {
    let day: String?
    let comment: String?
    let max_temp: Temp?
    let min_temp: Temp?
    let iconURL: String?
}

struct Author: Decodable {
    let email: String?
    let auth_note: String?
}


