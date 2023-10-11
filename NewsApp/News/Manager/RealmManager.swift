//
//  RealmManager.swift
//  News
//
//  Created by Vitya Mandryk on 11.10.2023.
//

import Foundation
import RealmSwift

class RealmManager {
    let realm = try! Realm()

    func saveNews(_ news: NewsArticle) {
        let savedNews = SavedNews()
        savedNews.title = news.title
        savedNews.descriptionText = news.description
        savedNews.url = news.url
        savedNews.imageUrl = news.urlToImage
        try! realm.write {
            realm.add(savedNews)
        }
    }

    func getSavedNews() -> [SavedNews] {
        return Array(realm.objects(SavedNews.self))
    }
}
