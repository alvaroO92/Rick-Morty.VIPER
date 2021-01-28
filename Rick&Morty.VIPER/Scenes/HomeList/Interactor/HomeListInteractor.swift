//
//  HomeListInteractor.swift
//  Rick&Morty.VIPER
//
//  Created by Alvaro on 23/01/2021.
//  Copyright © 2021 Alvaro Orti Moreno. All rights reserved.
//

import Foundation

final class HomeListInteractor {
    let dataManager: HomeListDataManagerProtocol
    
    init(dataManager: HomeListDataManagerProtocol) {
        self.dataManager = dataManager
    }
}

extension HomeListInteractor : HomeListInteractorProtocol {
    func getCharacters(completion: @escaping (Result<CharacterResponse, Error>) -> Void) {
        dataManager.getCharacters { (response : Result<CharacterResponse, Error>) in
            switch response {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
