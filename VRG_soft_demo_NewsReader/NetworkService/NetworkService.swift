//
//  NetworkService.swift
//  VRG_soft_demo_NewsReader
//
//  Created by Sergey berdnik on 20.06.2020.
//  Copyright © 2020 Sergey berdnik. All rights reserved.
//

import Foundation
import Alamofire

protocol NewsFeedListRemoteDataManagerProtocol {
    func getNews(pagination: Pagination, resultHandler: @escaping ([NewsFeed]) -> (), errorHandler: @escaping (NetworkError?) -> ())
}

struct Constants {
    static let baseURL = "https://api.nytimes.com/svc/search/v2/articlesearch.json?q=election&api-key=eSIo1TcjJ1rQ1EGIMpAnLdTplROqXZyH"
}

struct HttpStatusCode {
    static let successful           = 200
}


enum DateFormatterConstants {
    static var iso8601Full: String {
        return "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    }
}


extension DateFormatter {
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatterConstants.iso8601Full
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
}


enum NetworkError: Error {
    case server(Int, String, URL?)
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
    
    func getNews(pagination: Pagination, resultHandler: @escaping ([NewsFeed]) -> (), errorHandler: @escaping (NetworkError?) -> ()) {
        let path = String(format: Constants.baseURL, pagination.getCurrentPage())
        guard let url = URL(string: path) else { return }
        
        Alamofire.request(url).responseJSON { response in
            
            var responseData: Page<NewsFeed>?
            var error: NetworkError?
            
            if response.response?.statusCode == HttpStatusCode.successful, let data = response.data {
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
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
}

