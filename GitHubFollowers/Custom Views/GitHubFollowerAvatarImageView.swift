//
//  GitHubFollowerAvatarImageView.swift
//  GitHubFollowers
//
//  Created by Sadia on 30/8/23.
//

import UIKit

class GitHubFollowerAvatarImageView: UIImageView {
    let cache = NetworkManager.shared.cache
    let placeholderImage = UIImage(named: "avatarIMG")
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
    
    func downloadImage(from urlString: String){
        
        // প্রতিবারে image download এর  আগে  cache memory check করবো image আছে কিনা সেটা দেখার জন্য।
        let cacheKey = NSString(string: urlString) // string কে NSString এ convert করা।
        if let image = cache.object(forKey: cacheKey){
            self.image = image
            return
        } // image থাকলে এই উপরের code use করবো cache memory থেকে আর image না থাকলে image download করবে নিচের code use করে।
        guard let url = URL(string: urlString) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            //guard let self = self else {return}
            if error != nil {return}
            guard let response = response as? HTTPURLResponse,response.statusCode == 200 else {return}
            guard let data = data else {return}
            guard let image = UIImage(data: data) else {return}
            // downloaded image কে cache memory  তে save করছি
            self.cache.setObject(image, forKey: cacheKey)
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }
}
