//
//  GitHubFollowerAvatarImageView.swift
//  GitHubFollowers
//
//  Created by Sadia on 30/8/23.
//

import UIKit

class GitHubFollowerAvatarImageView: UIImageView {

    let placeholderImage = UIImage(named: "")
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
}
