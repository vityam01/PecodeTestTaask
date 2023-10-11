//
//  SavedNews.swift
//  News
//
//  Created by Vitya Mandryk on 11.10.2023.
//

import Foundation
import RealmSwift

class SavedNews: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String = ""
    @Persisted var descriptionText: String?
    @Persisted var url: String = ""
    @Persisted var imageUrl: String?
    @Persisted var dateSaved = Date()
}
