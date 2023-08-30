//
//  NetworkManager.swift
//  GitHubFollowers
//
//  Created by Sadia on 28/8/23.
//

import Foundation

class NetworkManager{
    static let shared = NetworkManager()
    
    private init() {}
   
//    func getFollowers(for username: String, page: Int, completed: @escaping ([Follower]?, ErrorMessage?) -> Void) {
//
//        let END_POINT = API.BASE_URL+" \(username)/followers?per_page=100&page=\(page)"
//
//        guard let url = URL(string: END_POINT) else{
//            completed(nil, .invalidUsername)
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//
//            if let _ = error{
//                completed(nil, .unableToComplete )
//                return
//            }
//
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
//                completed(nil,.invalidResponse )
//                return
//            }
//
//            guard let data = data else{
//                completed(nil, .invalidData)
//                return
//            }
//
//            do{
//                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
//                let followers = try decoder.decode([Follower].self, from: data) // type- [Follower], from - data
//                completed(followers, nil)
//            }catch{
//                completed(nil, .invalidData)
//            }
//        }
//
//        task.resume()
//    }
//
//
    //----ER PORIBORTE --Result type refactor
    
    func getFollowers(for username: String, page: Int, completed: @escaping (Result<[Follower], ErrorMessage>) -> Void) {
        
        let END_POINT = API.BASE_URL+" \(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: END_POINT) else{
            completed(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error{
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let data = data else{
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data) // type- [Follower], from - data
                completed(.success(followers))
            }catch{
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
}
