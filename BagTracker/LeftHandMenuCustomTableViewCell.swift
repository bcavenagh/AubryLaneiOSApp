//
//  LeftHandMenuCustomTableViewCell.swift
//  AubryLane
//
//  Created by Dhruv on 02/05/17.
//  Copyright © 2017 day. All rights reserved.
//

import UIKit

class LeftHandMenuCustomTableViewCell: UITableViewCell {

    @IBOutlet weak var cellIconImgView: UIImageView!
    
    @IBOutlet weak var cellTextLbl: UILabel!
    var tableRowPressed : ((IndexPath) -> ())?
    
    var currentIndexPath : IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func tableCellBtnPressed(_ sender: UIButton) {
        if  let tableRowPressed = self.tableRowPressed, let indexPath = currentIndexPath{
            tableRowPressed(indexPath)
        }
    }
    
    
    func populateCellWithData(cellText : String, cellImageURL : String, indexPath : IndexPath){
        self.cellIconImgView.clipsToBounds = true
        self.cellTextLbl.text = cellText
        self.cellIconImgView.image = UIImage.init(named: cellImageURL)
        currentIndexPath = indexPath
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
