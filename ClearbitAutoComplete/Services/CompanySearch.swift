//
//  CompanySearch.swift
//  ClearbitAutoComplete
//
//  Created by Hitesh Kumar on 08/03/20.
//  Copyright © 2020 Hitesh Kumar. All rights reserved.
//

import Foundation

private let searchRESTMethod = "/v1/companies/suggest"
private let baseURL = "autocomplete.clearbit.com"

protocol CompanySearching: class {
    func result(companies: [Company])
    func fail(err: AppError)
}

class CompanySearch {
    private lazy var service = WebService(baseURL: baseURL)
    private weak var last: URLSessionTask?
    public weak var delegate: CompanySearching?
    
    func search(with query: String) {
        if query.isEmpty {
            delegate?.result(companies: [])
            return
        }
        let queryDic = ["query": query]
        let parse: (Data) -> [Company]? = { (data) -> [Company]? in
            let jsdec = JSONDecoder()
            var result: [Company]?
            do {
                result = try jsdec.decode([Company].self, from: data)
            } catch let err {
                print("not parsing", err)
            }
            return result
        }
        guard let allCompanies = try? service.prepareResource(pathForREST: searchRESTMethod, argsDict: queryDic, parse: parse) else {
            delegate?.result(companies: [])
            return
        }
        last = service.getMe(res: allCompanies) { [weak self] (result) in
            switch result {
            case let .success(companies):
                self?.delegate?.result(companies: companies)
            case let .failure(err):
                self?.delegate?.fail(err: err)
            }
        }
    }

    func cancel() {
        last?.cancel()
    }
}
