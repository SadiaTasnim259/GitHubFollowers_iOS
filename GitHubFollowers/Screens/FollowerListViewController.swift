//
//  FollowerListViewController.swift
//  GitHubFollowers
//
//  Created by Sadia on 17/8/23.
//

import UIKit

class FollowerListViewController: UIViewController {
    
    var username: String!
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureCollectionView()
        
        NetworkManager.shared.getFollowers(for: username, page: 1) { result in
// new way
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                self.presentGitHubAlertViewcontrollerOnMainThread(title: "Bad stuff Happend", message: failure.rawValue, buttonTitle: "OK")
            }
        }
        
        //old way
        //            guard let followers = followers else{
        //                self.presentGitHubAlertViewcontrollerOnMainThread(title: "Bad stuff Happend", message: errorMessage!.rawValue, buttonTitle: "OK")
        //                return
        //            }
        //            print("Followers.count = \(followers.count)")
        //            print(followers)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemPink
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }

}
