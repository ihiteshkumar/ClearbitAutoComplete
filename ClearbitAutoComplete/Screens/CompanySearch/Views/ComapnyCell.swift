//
//  ComapnyCell.swift
//  ClearbitAutoComplete
//
//  Created by Hitesh Kumar on 08/03/20.
//  Copyright © 2020 Hitesh Kumar. All rights reserved.
//

import UIKit
import Kingfisher

class ComapnyCell: UITableViewCell {

    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var domainLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        logoImage.layer.cornerRadius = 2.0
        logoImage.layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        logoImage.image = nil
        companyNameLabel.text = nil
        domainLabel.text = nil
    }

    // MARK: - Configure cell
    
    func configure(company: Company) {
        companyNameLabel.text = company.name
        domainLabel.text = company.domain
        if let imageURL = URL(string: company.logo) {
            logoImage.kf.setImage(with: imageURL,
                                  placeholder: UIImage(named: "noImage"))
        } else {
            logoImage.backgroundColor = .gray
            logoImage.image = UIImage(named: "noImage")
            logoImage.contentMode = .scaleAspectFit
        }
    }
}
