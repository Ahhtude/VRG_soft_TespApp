//
//  NetworkService.swift
//  VRG_soft_demo_NewsReader
//
//  Created by Sergey berdnik on 20.06.2020.
//  Copyright © 2020 Sergey berdnik. All rights reserved.
//

import Foundation
import Alamofire
import CoreData

protocol NewsFeedListRemoteDataManagerProtocol {
    func getNews(pagination: Pagination, type: CurrentControllerState, resultHandler: @escaping ([NewsFeed]) -> (), errorHandler: @escaping (NetworkError?) -> ())
    
    func getFavorite(pagination: Pagination, resultHandler: @escaping ([NewsFeed]) -> (), errorHandler: @escaping (NetworkError?) -> ())
}

struct Constants {
    //static let baseURL = "https://api.nytimes.com/svc/mostpopular/v2/shared/30.json?api-key=eSIo1TcjJ1rQ1EGIMpAnLdTplROqXZyH"
    static let baseURL = "https://api.nytimes.com/svc/mostpopular/v2"
    static let endURL  = "30.json?api-key=eSIo1TcjJ1rQ1EGIMpAnLdTplROqXZyH"

}

struct HttpStatusCode {
    static let successful           = 200
 }



enum NetworkError: Error {
    case server(Int, String, URL?)
    case localStore(String)
}


class Page<Model: Decodable>: Decodable {
    
    typealias ItemType = Model
    
    private(set) var totalResults: Int?
    private(set) var items: [Model]
    
    private enum CodingKeys: String, CodingKey {
        case totalResults = "num_results"
        case items = "results"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        totalResults = try values.decodeIfPresent(Int.self, forKey: .totalResults)
        do {
            items = try values.decode([Model].self, forKey: .items)
        } catch let error {
            print(error)
            items = []
        }
    }
}


class NewsFeedListRemoteDataManager: NewsFeedListRemoteDataManagerProtocol {
    
    func getNews(pagination: Pagination,type: CurrentControllerState, resultHandler: @escaping ([NewsFeed]) -> (), errorHandler: @escaping (NetworkError?) -> ()) {
        
        var test : String = Constants.baseURL + type.rawValue + Constants.endURL
        let path = String(format: test, pagination.getCurrentPage())
        
        print("Current path to request ---- \n \(path) \n ----------")
        
        guard let url = URL(string: path) else { return }
        
        Alamofire.request(url).responseJSON { response in
            
            var responseData: Page<NewsFeed>?
            var error: NetworkError?
            
            if response.response?.statusCode == HttpStatusCode.successful, let data = response.data {
                
                let decoder = JSONDecoder()
                do {
                    responseData =  try decoder.decode(Page<NewsFeed>.self, from: data)
                    
                } catch _ {
                    error = NetworkError.server(response.response?.statusCode ?? 0, "Can not decodable response", response.request?.url)
                }
            }
            
            if responseData != nil {
                resultHandler(responseData?.items ?? [])
            } else {
                errorHandler(error)
            }
        }
    }
    
    func getFavorite(pagination: Pagination, resultHandler: @escaping ([NewsFeed]) -> (), errorHandler: @escaping (NetworkError?) -> ()) {
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "News")
                request.returnsObjectsAsFaults = false
        
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        
        var responseData: [NewsFeed] = []
        var error: NetworkError?
        
        
        do {
            let result = try context.fetch(request)
            for data in result as! [News] {
                let new = NewsFeed.init(title: data.title!, body: data.body!, date: data.publishDate!, image: data.image, moreDetail: data.more!)
                    responseData.append(new)
                 }
            
            } catch {
                //error = NetworkError.localStore("Some troubles in request from local store")
               }
        if responseData != nil {
            resultHandler(responseData)
        } else {
            errorHandler(error)
        }
    }
}

