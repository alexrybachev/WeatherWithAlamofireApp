//
//  NetworkManager.swift
//  WeatherWithAlamofireApp
//
//  Created by Aleksandr Rybachev on 13.04.2022.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
//    func getData(from url: String?, with completion: @escaping(Weather) -> Void) {
//        guard let url = URL(string: url ?? "") else { return }
//        
//        URLSession.shared.dataTask(with: url) { data, _, error in
//            guard let data = data else {
//                print(error?.localizedDescription ?? "No error description")
//                return
//            }
//            
//            do {
//                let weather = try JSONDecoder().decode(Weather.self, from: data)
//                DispatchQueue.main.async {
//                    completion(weather)
//                }
//            } catch let error {
//                print(error)
//            }
//        }.resume()
//    }
//    
//    func fetchImage(from url: String?, with completion: @escaping(Result<Data, NetworkError>) -> Void) {
//        guard let url = URL(string: url ?? "" ) else {
//            completion(.failure(.invalidURL))
//            return
//        }
//        
//        DispatchQueue.global().async {
//            guard let imageData = try? Data(contentsOf: url) else {
//                completion(.failure(.noData))
//                return
//            }
//            DispatchQueue.main.async {
//                completion(.success(imageData))
//            }
//        }
//    }
    
    func fetchDataWithAlamofire(_ url: String, completion: @escaping(Result<Weather, NetworkError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    guard let weather = Weather.getWeather(from: value) else { return }
                    completion(.success(weather))
                case .failure(let error):
                    print(error)
                    completion(.failure(.decodingError))
                }
            }
    }
    
    func fetchImageWithAlamofire(_ url: String, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { dataResponse in
                switch dataResponse.result {
                case .success(_):
                    guard let imageData = dataResponse.data else { return }
                    completion(.success(imageData))
                case .failure(let error):
                    print(error)
                    completion(.failure(.noData))
                }
            }
    }
}

