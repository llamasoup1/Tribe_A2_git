//
//  CustomCell - UITableViewCell
//  Tribe
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var imageCellView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // circular mask on images
        imageCellView.layer.cornerRadius = 45;
        imageCellView.layer.masksToBounds = true;
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
