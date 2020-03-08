//
//  RealmCompany.swift
//  ClearbitAutoComplete
//
//  Created by Hitesh Kumar on 08/03/20.
//  Copyright © 2020 Hitesh Kumar. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmCompanies: Object {
    dynamic var companies = List<RealmCompany>()
    @objc dynamic var query = ""
    override static func primaryKey() -> String {
        return "query"
    }
    convenience init(query: String, companies: List<RealmCompany>) {
        self.init()
        self.query = query
        self.companies = companies
    }
}

final class RealmCompany: Object {
    @objc dynamic var ID = 0
//    @objc dynamic var query = ""
    @objc dynamic var name = ""
    @objc dynamic var domain = ""
    @objc dynamic var logo = ""
    
//    override static func primaryKey() -> String {
//        return "ID"
//    }
//    convenience init(query: String, company: Company) {
    convenience init(company: Company) {
        self.init()
        name = company.name
        domain = company.domain
        logo = company.logo
    }
}
