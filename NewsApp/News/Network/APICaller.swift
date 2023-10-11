//
//  APICaller.swift
//  News
//
//  Created by Vitya Mandryk on 11.10.2023.
//

import Foundation
import Combine

enum API: String {
    case key = "8d154952fbe043b6a1ad8d2bcda85232"
}

class APICaller {
    
    // Top Headline
    func getTopHeadline() -> AnyPublisher<[NewsArticle], Error> {
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(API.key.rawValue)") else {
            return Fail(error: NSError(domain: "Invalid url", code: 0)).eraseToAnyPublisher()
        }
        
        let urlRequest = URLRequest(url: url)
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map { $0.data }
            .decode(type: NewsArticlesResponse.self, decoder: JSONDecoder())
            .map { $0.articles }
            .eraseToAnyPublisher()
    }
    
    // Search
    func getSearchResults(search: String) -> AnyPublisher<[NewsArticle], Error> {
        guard let encodedSearch = search.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
              let url = URL(string: "https://newsapi.org/v2/everything?q=\(encodedSearch)&apiKey=\(API.key.rawValue)")
        else {
            return Fail(error: NSError(domain: "Invalid url", code: 0)).eraseToAnyPublisher()
        }
        
        let urlRequest = URLRequest(url: url)
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map { $0.data }
            .decode(type: NewsArticlesResponse.self, decoder: JSONDecoder())
            .map { $0.articles }
            .eraseToAnyPublisher()
    }
}
