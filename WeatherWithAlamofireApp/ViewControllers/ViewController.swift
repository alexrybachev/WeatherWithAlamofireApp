//
//  ViewController.swift
//  WeatherWithAlamofireApp
//
//  Created by Aleksandr Rybachev on 13.04.2022.
//

import UIKit
//import Alamofire

class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet var currentDayHourLabel: UILabel!
    @IBOutlet var currentWeatherImage: UIImageView!
    @IBOutlet var currentWeatherConditionsLabel: UILabel!
    
    @IBOutlet var collectionView: UICollectionView!
    
    // MARK: - Private Properties
    private var weather: Weather?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alamofireFetchData(with: Link.weatherAPI.rawValue)
        
        collectionView.register(UINib(nibName: "NextDayCell", bundle: nil), forCellWithReuseIdentifier: "NextDayCell")
        collectionView.dataSource = self
    }
    
    // MARK: - Private Methods
    private func alamofireFetchData(with url: String) {
        NetworkManager.shared.fetchDataWithAlamofire(url) { result in
            switch result {
            case .success(let weather):
                self.weather = weather
                self.title = "Weather in \(weather.region)"
                self.currentDayHourLabel.text = weather.currentConditions.dayhour
                self.currentWeatherConditionsLabel.text = weather.currentConditions.currentWeather
                self.alamofireFetchImage(with: weather.currentConditions.iconURL)
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func alamofireFetchImage(with image: String) {
        guard let imageURL = weather?.currentConditions.iconURL else { return }
        print(imageURL)
        NetworkManager.shared.fetchImageWithAlamofire(imageURL) { result in
            switch result {
            case .success(let data):
                self.currentWeatherImage.image = UIImage(data: data)
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        weather?.nextDays.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NextDayCell", for: indexPath) as? NextDayCell else { return UICollectionViewCell() }
        cell.configureCell(with: weather?.nextDays[indexPath.item].iconURL)
        cell.configureCell(with: weather?.nextDays[indexPath.item])
        return cell
    }
}



