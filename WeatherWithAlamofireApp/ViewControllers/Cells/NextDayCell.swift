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
        NetworkManager.shared.fetchImage(from: image) { image in
            self.weatherImage.image = UIImage(data: image)
        }
    }
    
    func configureCell(with data: NextDay?) {
        dayWeek.text = data?.day
        weatherComment.text = data?.comment
        maxTempLabel.text = "t max: \(data?.max_temp?.c ?? 0)"
        minTempLabel.text = "t min: \(data?.min_temp?.c ?? 0)"
    }

}
