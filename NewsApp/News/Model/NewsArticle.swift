//
//  NewsArticle.swift
//  News
//
//  Created by Vitya Mandryk on 11.10.2023.
//

import Foundation

struct NewsArticle: Decodable {
    
    struct Source: Decodable {
        var id: String?
        var name: String
    }
    
    var author: String?
    var title: String
    var description: String?
    var url: String
    var urlToImage: String?
    var publishedAt: String
    var content: String?
    var category: String?
}

struct NewsArticlesResponse: Decodable {
    var status: String
    var totalResults: Int
    var articles: [NewsArticle]
}
