//
//  CompanySearchView.swift
//  ClearbitAutoComplete
//
//  Created by Hitesh Kumar on 08/03/20.
//  Copyright © 2020 Hitesh Kumar. All rights reserved.
//

import UIKit

class CompanySearchView: UIViewController {

    // MARK: - Constants
    
    private static let cellHeight: CGFloat = 80
    
    // MARK: - Views
    @IBOutlet weak var errorView: ErrorView!
    @IBOutlet weak var tableView: UITableView!

    private var cancelled: Bool = false
    private var timer: Timer?
    lazy var companyList = CompanyListController()
    
    init() {
        super.init(nibName: String(describing: type(of: self)), bundle: .main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overriden ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: String(describing: ComapnyCell.self), bundle: nil),
                           forCellReuseIdentifier: String(describing: ComapnyCell.self))
        setApperanceOnViewDidAppear()
        companyList.dataChanged = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        companyList.stateChanged = displayStateChange
        displayStateChange(state: companyList.searchState)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarApperanceOnViewWillAppear()
    }
    
    // MARK: - Configure Table View
    private func displayStateChange(state: SearchState) {
        DispatchQueue.main.async { [weak self] in
            switch state {
            case .initial:
                self?.tableView.isHidden = true
                self?.errorView.isHidden = true
            case .loaded:
                self?.tableView.isHidden = false
                self?.errorView.isHidden = true
            case .noData:
                self?.tableView.isHidden = true
                self?.errorView.isHidden = false
                self?.errorView.errorLabel.text = "Please try different! Unable to find content with search query."
            case .error:
                self?.tableView.isHidden = true
                self?.errorView.isHidden = false
                self?.errorView.errorLabel.text = "Something went wrong. Check your connection."
            }
        }
    }

    private func setApperanceOnViewDidAppear() {
        tableView.dataSource = self
        tableView.delegate = self
        createSearchBar()
        self.definesPresentationContext = true
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                                style: .plain,
                                                                target: nil,
                                                                action: nil)
    }

    private func createSearchBar() {
        guard navigationItem.searchController == nil else { return }
        let search = UISearchController(searchResultsController: nil)
        search.searchBar.delegate = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search company..."
        search.searchBar.tintColor = .white
        navigationItem.searchController = search
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    private func setNavigationBarApperanceOnViewWillAppear() {
        navigationController?.navigationBar.barTintColor =
            UIColor(red: 18/255.0, green: 41/255.0, blue: 59/255.0, alpha: 1)
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
}

extension CompanySearchView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CompanySearchView.cellHeight
    }
}

extension CompanySearchView: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        cancelled = false
        companyList.cancelLastRequest()
        searchTimerCancel()
        if let query = searchBar.text, !query.isEmpty {
            searchTimerStart(query: query)
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        search(searchText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        companyList.cancelPressed()
        cancelled = true
        tableView.setContentOffset(CGPoint.zero, animated: false)
    }
    
    // MARK: - Search Bar supporting method
    private func search(_ barText: String) {
        companyList.cancelLastRequest()
        companyList.search(with: barText)
    }

    private func searchTimerStart(query: String) {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:
            #selector(self.fireQuery(timer:)), userInfo: query, repeats: false)
    }

    private func searchTimerCancel() {
        if let timer = timer, timer.isValid {
            timer.invalidate()
            self.timer = nil
        }
    }

    @objc func fireQuery(timer: Timer) {
        if let query = timer.userInfo as? String {
            if !cancelled {
                search(query)
            }
        }
    }
}

extension CompanySearchView: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int { return 1 }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companyList.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //swiftlint:disable:next force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ComapnyCell.self)) as! ComapnyCell
        let company = companyList.details(for: indexPath.row)
        cell.configure(company: company)
        return cell
    }
}
