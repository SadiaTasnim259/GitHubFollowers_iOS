//
//  FollowerListViewController.swift
//  GitHubFollowers
//
//  Created by Sadia on 17/8/23.
//

import UIKit

class FollowerListViewController: UIViewController {
    
    enum Section{
        case main
    }
    
    var username: String!
    var followers:[Follower] = []
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureCollectionView()
        configureDataSource()
        getFollowers()
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
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view) )
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    func getFollowers(){
        NetworkManager.shared.getFollowers(for: username, page: 1) { [weak self] result in
            // [weak self] এর যায়গায় [unowned self] use করলে force unwrap করে তখন option unwrap করতে হয়না। কিন্তু safe এটা না।
// new way
            guard let self = self else {return}
            switch result {
            case .success(let success):
                self.followers = success
                self.updateData()
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
    
    func updateData(){
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async { [self] in
            dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
        }
    }
    
}

extension FollowerListViewController: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // Scroll করা শেষ হলে এই func কাজ করবে।
        let offsetY = scrollView.contentOffset.y
        let constentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        
    }
}


