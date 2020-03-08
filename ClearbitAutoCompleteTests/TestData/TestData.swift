//
//  TestData.swift
//  ClearbitAutoCompleteTests
//
//  Created by Hitesh Kumar on 08/03/20.
//  Copyright © 2020 Hitesh Kumar. All rights reserved.
//

import XCTest
@testable import ClearbitAutoComplete

enum TestData {
    static let companies: [Company] = [
        Company(name: "American Express", domain: "americanexpress.com", logo: "https://logo.clearbit.com/americanexpress.com"),
        Company(name: "American Airlines", domain: "aa.com", logo: "https://logo.clearbit.com/aa.com"),
        Company(name: "Americas Cardroom", domain: "americascardroom.eu", logo: "https://logo.clearbit.com/americascardroom.eu"),
        Company(name: "American Heart Association", domain: "heart.com", logo: "https://logo.clearbit.com/heart.com")
    ]
}
