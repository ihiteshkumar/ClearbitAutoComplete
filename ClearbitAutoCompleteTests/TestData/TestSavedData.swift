//
//  TestSavedData.swift
//  ClearbitAutoCompleteTests
//
//  Created by Hitesh Kumar on 08/03/20.
//  Copyright © 2020 Hitesh Kumar. All rights reserved.
//

import XCTest

@testable import ClearbitAutoComplete

class TestSavedData: SaveData {
    let companies = TestData.companies

    func fetchSavedCompanies(query: String, completionHandler: @escaping ([Company]?) -> Void) {
        completionHandler(companies)
    }
    
    func saveCompanies(_ query: String, companies: [Company]) {
        // Do nothing
    }
}
