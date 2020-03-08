//
//  Company.swift
//  ClearbitAutoComplete
//
//  Created by Hitesh Kumar on 08/03/20.
//  Copyright © 2020 Hitesh Kumar. All rights reserved.
//

import Foundation

struct Company: Codable {
    let name: String
    let domain: String
    let logo: String
}

extension Company {
    init(realmCompany: RealmCompany) {
        self.init(name: realmCompany.name,
                  domain: realmCompany.domain,
                  logo: realmCompany.logo)
    }
}
