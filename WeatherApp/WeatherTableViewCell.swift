//
//  WeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Software Merchant on 1/13/17.
//  Copyright © 2017 Instock. All rights reserved.
//

import UIKit

protocol WeatherTableCellDelegate {
    func weatherSelected(at: Int)
}

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var btnIcon: UIButton!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblHumadity: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    var delegate: WeatherTableCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func btnImagePressed(_ sender: Any) {
        delegate?.weatherSelected(at: self.tag)
    }
}
