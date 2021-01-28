//
//  HomeListView.swift
//  Rick&Morty.VIPER
//
//  Created by Alvaro on 23/01/2021.
//  Copyright © 2021 Alvaro Orti Moreno. All rights reserved.
//

import UIKit

enum HomeListTableViewCellCase {
    case result(HomeListModel)
    case noResult(message: String)
    
    struct HomeListModel {
        var id : Int!
        var name : String?
        var species : String?
        var gender : String?
        var image : String?
        var status : String?
        var dotStatus : UIColor? {
            let dotStatus = DotStatus.init(rawValue: status ?? "")
            return dotStatus?.color
        }
    }
    
    enum DotStatus : String {
        case Alive
        case unknown
        case Dead
        
        var color : UIColor {
            switch self {
            case .Alive:
                return .green
            case .Dead:
                return .red
            case .unknown:
                return .gray
            }
        }
    }
}

class HomeListTableViewCell : UITableViewCell {
    
    lazy var characterImageView: CacheImageView = {
        let imageview = CacheImageView()
        imageview.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        imageview.clipsToBounds = true
        imageview.layer.cornerRadius = 10
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var infoStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [
       statusDotView,
       genderLabel,
       specieLabel
       ])
        stackView.axis = .horizontal
        stackView.spacing = 4.0
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let genderLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let specieLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let statusDotView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = view.frame.width/2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        contentView.addSubview(characterImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(infoStackView)
        
        
        NSLayoutConstraint.activate([
            statusDotView.heightAnchor.constraint(equalToConstant: 10),
            statusDotView.widthAnchor.constraint(equalToConstant: 10)
        ])
        
        let views = [
            "image" : characterImageView,
            "name"  : nameLabel,
            "stackview" : infoStackView]
    
        
        var allConstraints: [NSLayoutConstraint] = []
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-[image(50)]", options: [], metrics: nil, views: views)
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-[name]-[stackview]-|", options: [], metrics: nil, views: views)
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[image(50)]-[name]-|", options: [], metrics: nil, views: views)
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[image(50)]-[stackview]-|", options: [], metrics: nil, views: views)
        
        NSLayoutConstraint.activate(allConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpData(response : HomeListTableViewCellCase.HomeListModel) {
        characterImageView.download(imageURL: response.image ?? "")
        nameLabel.text = response.name
        genderLabel.text = response.gender
        specieLabel.text = response.species
    
        if let color = response.dotStatus {
            statusDotView.backgroundColor = color
        }
    }
    
}
