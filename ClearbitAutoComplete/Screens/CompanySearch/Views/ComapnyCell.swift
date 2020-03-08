//
//  ComapnyCell.swift
//  ClearbitAutoComplete
//
//  Created by Hitesh Kumar on 08/03/20.
//  Copyright © 2020 Hitesh Kumar. All rights reserved.
//

import UIKit

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
//            logoImage.image =
            logoImage.image = UIImage(named: "noImage")
        } else {
            logoImage.image = UIImage(named: "noImage")
        }
    }
}
