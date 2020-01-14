//
//  RepoTableViewCell.swift
//  AlexGithubTestApp
//
//  Created by Alex Miculescu on 14/01/2020.
//  Copyright © 2020 Alex Miculescu. All rights reserved.
//

import UIKit
import AlamofireImage

class RepoTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet private weak var repoTitleLabel: UILabel!
    @IBOutlet private weak var ownerImageView: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with viewData: ReposListViewData) {
        self.repoTitleLabel.text = viewData.name
        self.ownerNameLabel.text = viewData.ownerName
        
        if let imageURL = viewData.ownerImageURL {
            self.ownerImageView.af_setImage(withURL: imageURL, placeholderImage: .githubPlaceholder)
        } else {
            self.ownerImageView.image = .githubPlaceholder
        }
    }
}
