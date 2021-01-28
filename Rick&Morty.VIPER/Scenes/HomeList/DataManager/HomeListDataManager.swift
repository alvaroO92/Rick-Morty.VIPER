//
//  HomeListDataManager.swift
//  Rick&Morty.VIPER
//
//  Created by Alvaro on 23/01/2021.
//  Copyright © 2021 Alvaro Orti Moreno. All rights reserved.
//

import Foundation

final class HomeListDataManager: HomeListDataManagerProtocol {
    func getCharacters(completion: @escaping (Result<CharacterResponse, Error>) -> Void) {
        API(endPoint: .getCharacters).request { (response : Result<CharacterResponse, Error>) in
            completion(response)
        }
    }
}
