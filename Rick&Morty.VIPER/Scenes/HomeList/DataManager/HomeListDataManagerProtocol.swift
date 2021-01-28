//
//  HomeListDataManagerProtocol.swift
//  Rick&Morty.VIPER
//
//  Created by Alvaro on 23/01/2021.
//  Copyright © 2021 Alvaro Orti Moreno. All rights reserved.
//

import Foundation

protocol HomeListDataManagerProtocol: AnyObject {
    func getCharacters(completion: @escaping (Result<CharacterResponse,Error>) -> Void)
}
