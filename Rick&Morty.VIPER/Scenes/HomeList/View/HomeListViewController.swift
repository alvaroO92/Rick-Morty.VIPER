//
//  HomeListViewController.swift
//  Rick&Morty.VIPER
//
//  Created by Alvaro on 23/01/2021.
//  Copyright © 2021 Alvaro Orti Moreno. All rights reserved.
//

import UIKit

final class HomeListViewController: BaseTableViewController {
    
    lazy var refresher : UIRefreshControl = {
        let refreshControl = UIRefreshControl()
         refreshControl.tintColor = .blue
         return refreshControl
     }()
  
    let presenter: HomeListPresenterProtocol
    
    init(presenter: HomeListPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    @|v@roO92
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        tableView.separatorStyle = .none
        tableView.refreshControl = refresher
        tableView.register(HomeListTableViewCell.self, forCellReuseIdentifier: "HomeListTableViewCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let character = presenter.modelForCell(at: indexPath)
        
        switch character {
        case .result(let model):
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeListTableViewCell", for: indexPath) as! HomeListTableViewCell
            cell.setUpData(response: model)
            return cell
        case .noResult(let message):
            let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
            cell.textLabel?.text = message
            return cell
        }
    }
}

extension HomeListViewController : HomeListViewProtocol {
   
    func setUpView() {
        self.addNavigationBar(title: Constants.App.navTitle, titleColor: AppColors.secondary, titleFont: UIFont.boldSystemFont(ofSize: 16), backgroundColor: AppColors.primary)
        refresher.addTarget(presenter, action: #selector(presenter.refreshView), for: .valueChanged)
    }
    
    func endRefreshView() {
        refresher.endRefreshing()
    }
    
    func showResponseError() {
        self.showAlertError()
    }

    func reloadView() {
        tableView.reloadData()
    }
}
