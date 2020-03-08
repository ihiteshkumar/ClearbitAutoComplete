//
//  SaveData.swift
//  ClearbitAutoComplete
//
//  Created by Hitesh Kumar on 08/03/20.
//  Copyright © 2020 Hitesh Kumar. All rights reserved.
//

import Foundation
/*
 Protocol to save the data
 */
protocol SaveData {
    func saveCompanies(_ query: String, companies: [Company])
    func fetchSavedCompanies(query: String, completionHandler: @escaping ([Company]?) -> Void)
}
