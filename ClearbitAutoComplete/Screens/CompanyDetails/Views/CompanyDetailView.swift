//
//  CompanyDetailView.swift
//  ClearbitAutoComplete
//
//  Created by Hitesh Kumar on 09/03/20.
//  Copyright © 2020 Hitesh Kumar. All rights reserved.
//

import UIKit

class CompanyDetailView: UIViewController {
    
    @IBOutlet weak var companyNameLable: UILabel!
    @IBOutlet weak var logoImage: UIImageView!

    var company: Company
    
    init(company: Company) {
        self.company = company
        super.init(nibName: String(describing: type(of: self)), bundle: .main)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setCompanyDetails()
    }

    // MARK: - Private Methods
    private func setCompanyDetails() {
        companyNameLable.text = company.name
    }
}
