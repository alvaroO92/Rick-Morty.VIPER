//
//  HomeListPresenterProtocol.swift
//  Rick&Morty.VIPER
//
//  Created by Alvaro on 23/01/2021.
//  Copyright © 2021 Alvaro Orti Moreno. All rights reserved.
//

import Foundation

protocol HomeListPresenterProtocol: HomeListReloadViewProtocol {
    func viewDidLoad()
    func numberOfRowsInSection(_ section: Int) -> Int
    func modelForCell(at indexPath: IndexPath) -> HomeListTableViewCellCase
}

@objc protocol HomeListReloadViewProtocol {
    func refreshView()
}
