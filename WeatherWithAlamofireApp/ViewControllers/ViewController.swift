//
//  ViewController.swift
//  WeatherWithAlamofireApp
//
//  Created by Aleksandr Rybachev on 13.04.2022.
//

import UIKit

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
        
        fetchData(from: Link.weatherAPI.rawValue)
        fetchImage(with: weather?.currentConditions?.iconURL)
        
        collectionView.register(UINib(nibName: "NextDayCell", bundle: nil), forCellWithReuseIdentifier: "NextDayCell")
        collectionView.dataSource = self
    }
    
    // MARK: - Private Methods
    private func fetchData(from url: String?) {
        NetworkManager.shared.getData(from: url) { weather in
            self.weather = weather
            self.currentDayHourLabel.text = weather.currentConditions?.dayhour
            self.currentWeatherConditionsLabel.text = weather.currentConditions?.currentWeather
            
            self.collectionView.reloadData()
        }
    }
    
    private func fetchImage(with image: String?) {
        NetworkManager.shared.fetchImage(from: image) { image in
            self.currentWeatherImage.image = UIImage(data: image)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        weather?.next_days?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NextDayCell", for: indexPath) as? NextDayCell else { return UICollectionViewCell() }
        cell.configureCell(with: weather?.next_days?[indexPath.item].iconURL)
        cell.configureCell(with: weather?.next_days?[indexPath.item])
        return cell
    }
}



