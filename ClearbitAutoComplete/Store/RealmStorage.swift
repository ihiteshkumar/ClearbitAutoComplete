//
//  RealmStorage.swift
//  ClearbitAutoComplete
//
//  Created by Hitesh Kumar on 08/03/20.
//  Copyright © 2020 Hitesh Kumar. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmStorage {
    let storeQueue = DispatchQueue(label: "com.queue.store")
}

extension RealmStorage: SaveData {
    // MARK: - Save companies name
    func saveCompanies(_ query: String, companies: [Company]) {
        storeQueue.async {
            autoreleasepool {
                let realm = try! Realm() // swiftlint:disable:this
                realm.beginWrite()
                let companiesList = List<RealmCompany>()
                for company in companies {
                    let realmCompany = RealmCompany(company: company)
                    companiesList.append(realmCompany)
                }
                let realmCompanies = RealmCompanies(query: query, companies: companiesList)
                realm.add(realmCompanies)
                try! realm.commitWrite() // swiftlint:disable:this
            }
        }
    }

    // MARK: - Fetch saved company list with query
    func fetchSavedCompanies(query: String, completionHandler: @escaping ([Company]?) -> Void) {
        storeQueue.async {
            autoreleasepool {
                let realm = try! Realm() // swiftlint:disable:this
                let realmCompanies = realm.object(ofType: RealmCompanies.self, forPrimaryKey: query) //objects(RealmCompanies.self).filter("query == \(query)")
                guard let companiesList = realmCompanies?.companies else {
                    completionHandler(nil)
                    return
                }
                let companies: [Company] = companiesList.compactMap({ (realmCompany: RealmCompany) -> Company? in
                    let company = Company(realmCompany: realmCompany)
                    return company
                })
                completionHandler(companies)
            }
        }
    }
    
}
