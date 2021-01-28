//
//  HomeListViewProtocol.swift
//  Rick&Morty.VIPER
//
//  Created by Alvaro on 23/01/2021.
//  Copyright © 2021 Alvaro Orti Moreno. All rights reserved.
//

import Foundation

protocol HomeListViewProtocol: AnyObject {
    func setUpView()
    func reloadView()
    func endRefreshView()
    func showResponseError()
}
