//
//  Service.swift
//  AppleStore
//
//  Created by 豊岡正紘 on 2019/04/21.
//  Copyright © 2019 Masahiro Toyooka. All rights reserved.
//

import Foundation

class Service {
    
    static let shared = Service()
    
    func fetchApps(searchTerm: String, completion: @escaping (SearchResult?, Error?) -> ()) {
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&media=software&entity=software"

        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchGames(completion: @escaping (AppGroup?, Error?) -> ()) {
        
        let urlString = "https://rss.itunes.apple.com/api/v1/jp/ios-apps/new-games-we-love/all/50/explicit.json"
        
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchTopGrossingGames(completion: @escaping (AppGroup?, Error?) -> ()) {
        
        let urlString = "https://rss.itunes.apple.com/api/v1/jp/ios-apps/top-grossing/all/50/explicit.json"
        fetchGenericJSONData(urlString: urlString, completion: completion)
        
    }
    
    func fetchTopGames(completion: @escaping (AppGroup?, Error?) -> ()) {
        
        let urlString = "https://rss.itunes.apple.com/api/v1/jp/ios-apps/top-free/all/50/explicit.json"
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetvchAppGroup(urlString: String, completion: @escaping (AppGroup?, Error?) -> Void) {
      
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchSocialApps(completion: @escaping ([SocialApp]?, Error?) -> Void) {
        
        let urlString = "https://api.letsbuildthatapp.com/appstore/social"
        
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> ()) {
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                return
            }
            do {
                let objects = try JSONDecoder().decode(T.self, from: data!)
                // success
                completion(objects, nil)
            } catch {
                completion(nil, error)
            }
            }.resume()
    }
}

class Stack<T: Decodable> {
    var items = [T]()
    func push(item: T) { items.append(item) }
    func pop() -> T? { return items.last }
}

import UIKit

func dummyFunc() {
    //    let stackOfImages = Stack<UIImage>()
    
    let stackOfStrings = Stack<String>()
    stackOfStrings.push(item: "HAS TO BE STRING")
    
    let stackOfInts = Stack<Int>()
    stackOfInts.push(item: 1)
}
