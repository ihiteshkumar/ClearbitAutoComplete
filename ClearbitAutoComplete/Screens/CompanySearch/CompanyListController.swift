//
//  CompanyListController.swift
//  ClearbitAutoComplete
//
//  Created by Hitesh Kumar on 08/03/20.
//  Copyright © 2020 Hitesh Kumar. All rights reserved.
//

import Foundation

enum SearchState {
    case initial
    case noData
    case loaded
    case error(Error)
}

class CompanyListController {

    var dataChanged: (() -> Void)?
    var stateChanged: ((SearchState) -> Void)?
    private var companySearch: CompanySearch
//    private var companies: [Company] = [Company]
    
    // MARK: - Callbacks
    private var companies: [Company] = [Company]() {
        didSet {
            dataChanged?()
        }
    }
    
    private(set) var searchState: SearchState = .initial {
        didSet {
            stateChanged?(searchState)
        }
    }

    init() {
        companySearch = CompanySearch()
        companySearch.delegate = self
    }

    func cancelPressed() {
        searchState = .initial
    }

    func search(with query: String) {
        companySearch.search(with: query)
    }

    func cancelLastRequest() {
        companySearch.cancel()
    }

    func numberOfRows() -> Int {
        return companies.count
    }

    func details(for row: Int) -> Company {
        return companies[row]
    }
}

extension CompanyListController: CompanySearching {
    func fail(err: AppError) {
        guard case .networkError(let ntwErr) = err, ntwErr.code != .cancelled else { return }
        searchState = .error(err)
    }

    func result(companies: [Company]) {
        searchState = companies.count > 0 ? .loaded : .noData
        self.companies = companies
    }
}
