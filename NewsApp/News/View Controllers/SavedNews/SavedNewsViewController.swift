//
//  SavedNewsViewController.swift
//  News
//
//  Created by Vitya Mandryk on 11.10.2023.
//

import Foundation
import UIKit
import RealmSwift

class SavedNewsViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var savedNews: [SavedNews] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    private func initUI() {
        tableView.delegate = self
        tableView.dataSource = self
        savedNews = RealmManager().getSavedNews()
        savedNews = savedNews.reversed()
        tableView.reloadData()
    }
}


extension SavedNewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedNews.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsCell
        
        let savedNewsItem = savedNews[indexPath.row]
        
        if let imageUrlString = savedNewsItem.imageUrl, let imageUrl = URL(string: imageUrlString) {
            cell.articleImageView.af.setImage(withURL: imageUrl)
        }
        cell.titleLabel.text = savedNewsItem.title
        cell.descriptionLabel.text = savedNewsItem.descriptionText
        
        return cell
    }
}


