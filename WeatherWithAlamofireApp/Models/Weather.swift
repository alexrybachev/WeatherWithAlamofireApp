//
//  Weather.swift
//  WeatherWithAlamofireApp
//
//  Created by Aleksandr Rybachev on 13.04.2022.
//

enum Link: String {
    case weatherAPI = "https://weatherdbi.herokuapp.com/data/weather/london"
}

struct Weather: Codable {
    let region: String
    let currentConditions: CurrentConditions
    let nextDays: [NextDay]
    let contactAuthor: Author
    let dataSource: String
    
    init(value: [String: Any]) {
        region = value["region"] as? String ?? ""
        
        let currentConditions = value["currentConditions"] as? [String: Any] ?? [:]
        self.currentConditions = CurrentConditions(value: currentConditions)
        
        let nextDays = value["next_days"] as? [[String: Any]] ?? []
        self.nextDays = nextDays.compactMap { NextDay(value: $0) }
        
        let contactAuthor = value["contact_author"] as? [String: String] ?? [:]
        self.contactAuthor = Author(value: contactAuthor)
        
        dataSource = value["data_source"] as? String ?? ""
    }
    
    static func getWeather(from value: Any) -> Weather? {
        guard let data = value as? [String: Any] else { return nil }
        return Weather(value: data)
    }
}

struct CurrentConditions: Codable {
    let dayhour, precip, humidity, iconURL, comment: String
    let temp: Temp
    let wind: Wind
    
    var currentWeather: String {
        """
        \(comment)
        
        Precipitation: \(precip)
        Humidity: \(humidity)
        
        Temperature (C): \(temp.celsius)
        """
    }
    
    init(value: [String: Any]) {
        dayhour = value["dayhour"] as? String ?? ""
        
        let temp = value["temp"] as? [String: Int] ?? [:]
        self.temp = Temp(value: temp)
        
        precip = value["precip"] as? String ?? ""
        humidity = value["humidity"] as? String ?? ""
        
        let wind = value["wind"] as? [String: Int] ?? [:]
        self.wind = Wind(value: wind)
        
        iconURL = value["iconURL"] as? String ?? ""
        comment = value["comment"] as? String ?? ""
    }
}

struct Temp: Codable {
    let celsius, fahrenheit: Int
    
    init(value: [String: Int]) {
        celsius = value["c"] ?? 0
        fahrenheit = value["f"] ?? 0
    }
}

struct Wind: Codable {
    let km, mile: Int
    
    init(value: [String: Int]) {
        km = value["km"] ?? 0
        mile = value["mile"] ?? 0
    }
}

struct NextDay: Codable {
    let day, comment, iconURL: String
    let maxTemp, minTemp: Temp
    
    init(value: [String: Any]) {
        day = value["day"] as? String ?? ""
        comment = value["comment"] as? String ?? ""
        
        let maxTemp = value["max_temp"] as? [String: Int] ?? [:]
        self.maxTemp = Temp(value: maxTemp)
        
        let minTemp = value["min_temp"] as? [String: Int] ?? [:]
        self.minTemp = Temp(value: minTemp)
        
        iconURL = value["iconURL"] as? String ?? ""
    }
}

struct Author: Codable {
    let email, authNote: String
    
    init(value: [String: String]) {
        email = value["email"] ?? ""
        authNote = value["auth_note"] ?? ""
    }
}


