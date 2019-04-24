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
    
    func fetchApps(searchTerm: String, completion: @escaping ([Result], Error?) -> ()) {
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&media=software&entity=software"
        
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response , err) in
            
            if let err = err {
                print("Failed to fetch data", err)
                completion([], nil)
                return
            }
            
            guard let data = data else {return}
            
            do {
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                
                completion(searchResult.results, nil)
            } catch let jsonErr {
                print("Failed to decode json:", jsonErr)
                completion([], jsonErr)
            }
        }.resume()
    }
}
