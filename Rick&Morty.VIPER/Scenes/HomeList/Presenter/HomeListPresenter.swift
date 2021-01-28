//
//  HomeListPresenter.swift
//  Rick&Morty.VIPER
//
//  Created by Alvaro on 23/01/2021.
//  Copyright © 2021 Alvaro Orti Moreno. All rights reserved.
//

import Foundation

final class HomeListPresenter {
    weak var view: HomeListViewProtocol?
    let interactor: HomeListInteractorProtocol
    let coordinatorOutput: (HomeListOutput) -> Void
    private var characters : [Character] = []
 
    init(interactor: HomeListInteractorProtocol, coordinatorOutput: @escaping (HomeListOutput) -> Void) {
        self.interactor = interactor
        self.coordinatorOutput = coordinatorOutput
    }
}

extension HomeListPresenter : HomeListPresenterProtocol {
    @objc func refreshView() {
        self.characters.removeAll()
        interactor.getCharacters { [weak self] (response : Result<CharacterResponse,Error>) in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                self.characters = data.characters ?? []
                self.view?.reloadView()
                self.view?.endRefreshView()
                break
            case .failure(_):
                self.view?.showResponseError()
                self.view?.reloadView()
                self.view?.endRefreshView()
                break
            }
        }
    }
    
    func viewDidLoad() {
        view?.setUpView()
        interactor.getCharacters { [weak self] (response : Result<CharacterResponse,Error>) in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                self.characters = data.characters ?? []
                self.view?.reloadView()
                break
            case .failure(_):
                self.view?.showResponseError()
                self.view?.reloadView()
                break
            }
        }
    }

    func numberOfRowsInSection(_ section: Int) -> Int {
        return characters.count
    }
    
    func modelForCell(at indexPath: IndexPath) -> HomeListTableViewCellCase {
        
        guard !characters.isEmpty else {
            return .noResult(message: "No Results")
        }
        
        let character = characters[indexPath.row]
        return .result(.init(id: character.id, name: character.name, species: character.species, gender: character.gender, image: character.image,status: character.status))
    }
}
