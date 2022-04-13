//
//  NextDayCell.swift
//  WeatherWithAlamofireApp
//
//  Created by Aleksandr Rybachev on 13.04.2022.
//

import UIKit

class NextDayCell: UICollectionViewCell {
    
    @IBOutlet var dayWeek: UILabel!
    @IBOutlet var weatherImage: UIImageView!
    @IBOutlet var weatherComment: UILabel!
    @IBOutlet var maxTempLabel: UILabel!
    @IBOutlet var minTempLabels: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell() {
        
    }

}
