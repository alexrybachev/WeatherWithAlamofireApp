//
//  NetworkManager.swift
//  WeatherWithAlamofireApp
//
//  Created by Aleksandr Rybachev on 13.04.2022.
//

import Foundation

enum Link: String {
    case weatherAPI = "https://weatherdbi.herokuapp.com/data/weather/london"
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func getData() {
        
    }
}
