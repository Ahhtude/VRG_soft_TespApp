//
//  FavoriteDetailViewController.swift
//  VRG_soft_demo_NewsReader
//
//  Created by Sergey berdnik on 21.06.2020.
//  Copyright © 2020 Sergey berdnik. All rights reserved.
//


import UIKit
import Alamofire

class FavoriteDetailViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: FavoriteDetailToPresenterProtocol!
    
    private var newsFeeds: [NewsFeed] = []
    private var dataSource: [NewsFeed] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        configureTableView()
        self.title = "Favorite"
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension FavoriteDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteViewCell") as? FavoriteViewCell else { return UITableViewCell() }
        let feed = dataSource[indexPath.row]
        cell.fill(post: feed)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if newsFeeds.count > 0 && newsFeeds.count - 1 == indexPath.row && newsFeeds.count == dataSource.count {
            let activity = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
            activity.startAnimating()
            activity.color = UIColor.black
            tableView.tableFooterView = activity
            presenter.fetchNewsFeed()
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let feed = dataSource[indexPath.row]
        presenter.showPostDetail(from: self, forPost: feed)
    }
    
}

extension FavoriteDetailViewController: FavoriteDetailViewProtocol {

    func showFavoriveNews(news: [NewsFeed]) {
        tableView.tableFooterView = nil
        newsFeeds = news
        dataSource = newsFeeds
        tableView.reloadData()
    }
    
    func showError(error: Error?) {
        let alert = UIAlertController(title: "Alert", message: "Problem Fetching News", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        tableView.tableFooterView = nil
    }
}
