//
//  ViewController.swift
//  News
//
//  Created by Vitya Mandryk on 11.10.2023.
//

import UIKit
import Combine
import AlamofireImage

class HeadlinesViewController: UIViewController {
    
    @IBOutlet weak var filterSegment: UISegmentedControl!
    @IBOutlet private weak var tableView: UITableView!
    
    var headlinesVM: HeadlinesViewModel!
    var cancellables = Set<AnyCancellable>()
    private var selectedCategory: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let apiService = APICaller()
        headlinesVM = HeadlinesViewModel(apiService: apiService)
        headlinesVM.$articles
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the index path from the cell that was tapped
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        
        let article = headlinesVM.articles[indexPath.row]
        
        let detailViewController = segue.destination as! NewsWebViewController
        detailViewController.newsSelected = article
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
    @IBAction func categorySegmentedControlChanged(_ sender: UISegmentedControl) {
        let selectedSegmentIndex = sender.selectedSegmentIndex

            switch selectedSegmentIndex {
            case 0:
                selectedCategory = "Work"
            case 1:
                selectedCategory = "Food"
            case 2:
                selectedCategory = "Nature"
            case 3:
                selectedCategory = "Cars"
            case 4:
                selectedCategory = "Education"
            default:
                selectedCategory = nil
            }
        
        headlinesVM.filterArticlesByCategory(selectedCategory) { [weak self] in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
}

extension HeadlinesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headlinesVM.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell") as! NewsCell
        
        let article = headlinesVM.articles[indexPath.row]
        
        if let imageUrlString = article.urlToImage, let imageUrl = URL(string: imageUrlString) {
            cell.articleImageView.af.setImage(withURL: imageUrl)
        }
        cell.titleLabel.text = article.title
        cell.descriptionLabel.text = article.description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let saveAction = UIContextualAction(style: .normal, title: "Save") { [weak self] (action, view, completionHandler) in
                guard let article = self?.headlinesVM.articles[indexPath.row] else { return }
                RealmManager().saveNews(article)
                completionHandler(true)
            }
            saveAction.backgroundColor = .orange
            return UISwipeActionsConfiguration(actions: [saveAction])
        }
}

