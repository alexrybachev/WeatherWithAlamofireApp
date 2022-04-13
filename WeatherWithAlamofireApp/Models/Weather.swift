//
//  Weather.swift
//  WeatherWithAlamofireApp
//
//  Created by Aleksandr Rybachev on 13.04.2022.
//


struct Weather {
    let region: String?
    let currentConditions: CurrentConditions?
    let next_days: [NextDay]?
    let contact_author: Author?
    let data_source: String?
}

struct CurrentConditions {
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

struct Temp {
    let c: Int?
    let f: Int?
}

struct Wind {
    let km: Int?
    let mile: Int?
}

struct NextDay {
    let day: String?
    let comment: String?
    let max_temp: Temp?
    let min_temp: Temp?
    let iconURL: String?
}

struct Author {
    let email: String?
    let auth_note: String?
}


