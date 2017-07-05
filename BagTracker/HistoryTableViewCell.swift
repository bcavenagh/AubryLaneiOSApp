//
//  HistoryTableViewCell.swift
//  AubryLane
//
//  Created by Dhruv on 10/05/17.
//  Copyright © 2017 day. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var historyPlaceLbl: UILabel!
    @IBOutlet weak var historyDateLbl: UILabel!
    
    func setHistoryDataWith(date : String?, placeName : String?){
        
        self.historyDateLbl!.text = date
        self.historyPlaceLbl!.text = placeName
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
