//
//  Copyright © 2018 Weedmaps, LLC. All rights reserved.
//

import UIKit


class BusinessCell: UICollectionViewCell {
    // IMPLEMENT
    @IBOutlet weak var bubinessImageView: UIImageView!
    @IBOutlet weak var businessTitleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    
    func setupCellWith(business: Business) {
        businessTitleLabel.text = business.name
        bubinessImageView.loadImage(from: business.image_url ?? "")
        if let rating = business.rating {
            ratingLabel.text = "Rating: \(rating)"
        }else {
            ratingLabel.text = ""
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bubinessImageView.image = nil
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
}
