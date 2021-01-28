//
//  HomeListBuilder.swift
//  Rick&Morty.VIPER
//
//  Created by Alvaro on 23/01/2021.
//  Copyright © 2021 Alvaro Orti Moreno. All rights reserved.
//

import Foundation
import UIKit

final class HomeListBuilder: Builder {
    let coordinatorOutput: (HomeListOutput) -> Void
    
    init(coordinatorOutput: @escaping (HomeListOutput) -> Void) {
        self.coordinatorOutput = coordinatorOutput
    }
    
    func build() -> UIViewController {
        let dataManager = HomeListDataManager()
        let interactor = HomeListInteractor(dataManager: dataManager)
        let presenter = HomeListPresenter(interactor: interactor, coordinatorOutput: coordinatorOutput)
        let viewController = HomeListViewController(presenter: presenter)
        
        presenter.view = viewController
        
        return viewController
    }
}
