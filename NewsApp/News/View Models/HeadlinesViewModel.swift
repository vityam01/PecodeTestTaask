//
//  HeadlinesViewModel.swift
//  News
//
//  Created by Vitya Mandryk on 11.10.2023.
//

import Foundation
import Combine

class HeadlinesViewModel {
    @Published private(set) var articles = [NewsArticle]()
    @Published private(set) var filteredResults = [NewsArticle]() 

    private var observer: AnyCancellable?
    private let apiService: APICaller!

    init(apiService: APICaller) {
        self.apiService = apiService
        fetchHeadlines()
        filteredResults = articles
    }

    deinit {
        observer?.cancel()
    }
    
    
    
    func filterArticlesByCategory(_ category: String?, completion: @escaping () -> Void) {
        if let category = category {
            articles = articles.filter { $0.category == category }
            completion()
        } else {
            articles = articles
        }
    }
    // get articles
    func fetchHeadlines() {
        observer = apiService.getTopHeadline()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Finished getting news articles")
                case .failure(let error):
                    print("Error getting news articles: \(error)")
                }
            }, receiveValue: { [weak self] value in
                self?.articles = value
                
            })
    }

    func fetchSearchResults(search: String) {
        observer = apiService.getSearchResults(search: search)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Finished getting search results")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }, receiveValue: { [weak self] value in
                self?.filteredResults = value
            })
    }
}

