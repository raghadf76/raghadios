//
//  TableViewCell.swift
//  iosexercise
//
//  Created by Raghad alfuhaid on 08/02/1443 AH.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imageViewCell: UIImageView!
    
    
    @IBOutlet weak var cellTitleLabel: UILabel!
    
    
    @IBOutlet weak var authorLabel: UILabel!
    
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    @IBOutlet weak var webLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
