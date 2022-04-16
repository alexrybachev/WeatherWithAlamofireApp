//
//  NextDayCell.swift
//  WeatherWithAlamofireApp
//
//  Created by Aleksandr Rybachev on 13.04.2022.
//

import UIKit

class NextDayCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet var dayWeek: UILabel!
    @IBOutlet var weatherImage: UIImageView!
    @IBOutlet var weatherComment: UILabel!
    @IBOutlet var maxTempLabel: UILabel!
    @IBOutlet var minTempLabel: UILabel!
    
    // MARK: - Configure Cell   
    func configureCell(with image: String?) {
        guard let imageURL = image else { return}
        NetworkManager.shared.fetchImageWithAlamofire(imageURL) { result in
            switch result {
            case .success(let data):
                self.weatherImage.image = UIImage(data: data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func configureCell(with data: NextDay?) {
        dayWeek.text = data?.day
        weatherComment.text = data?.comment
        maxTempLabel.text = "t max: \(data?.maxTemp.celsius ?? 0)°"
        minTempLabel.text = "t min: \(data?.minTemp.celsius ?? 0)°"
    }
}
