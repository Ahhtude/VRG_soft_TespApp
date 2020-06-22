//
//  NewsFeedViewController.swift
//  VRG_soft_demo_NewsReader
//
//  Created by Sergey berdnik on 20.06.2020.
//  Copyright © 2020 Sergey berdnik. All rights reserved.
//

import UIKit
import PKHUD

fileprivate struct Constants {
    static var heighOfActivityIndicator : CGFloat = CGFloat.init(100.0)
    static var titleMostViewed = "Most viewed"
    static var titleMostMailed = "Most mailed"
    static var titleMostShared = "Most shared"
}

class NewsFeedViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: NewsFeedToPresenterProtocol!
    
   private var newsFeeds: [NewsFeed] = []
   private var dataSource: [NewsFeed] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        self.presenter.interector?.currentNewsState = .mostViewed
        configureTableView()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func favoriteButtonTap(_ sender: Any) {
        presenter.showFavoriteDetail(from: self)
    }
    
}

extension NewsFeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedViewCell") as? FeedViewCell else { return UITableViewCell() }
        let feed = dataSource[indexPath.row]
        cell.fill(post: feed)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if newsFeeds.count > 0 && newsFeeds.count - 1 == indexPath.row && newsFeeds.count == dataSource.count {
            let activity = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: view.frame.width,
                                                                 height: Constants.heighOfActivityIndicator))
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


extension NewsFeedViewController: NewsFeedViewProtocol {
    func showLoadingView() {
        HUD.show(.progress)
    }
    
    func hideLoadingView() {
        HUD.hide()
    }
    
    func showNews(news: [NewsFeed]) {
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


class ViewdFeedViewController : NewsFeedViewController {
    override func viewDidLoad() {
         super.viewDidLoad()
         self.title = Constants.titleMostViewed
    }
}

class MailedFeedViewController : NewsFeedViewController {
    override func viewDidLoad() {
         super.viewDidLoad()
        self.title = Constants.titleMostMailed
    }
}

class SharedFeedViewController : NewsFeedViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Constants.titleMostShared
    }
}
