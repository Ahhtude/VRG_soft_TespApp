//
//  NewsFeed.swift
//  VRG_soft_demo_NewsReader
//
//  Created by Sergey berdnik on 20.06.2020.
//  Copyright © 2020 Sergey berdnik. All rights reserved.
//

import Foundation

struct NewsFeed: Decodable {

    let publishDate : String
    let title: String
    let body : String
    private let media : [MediaModel]?
    
    var image : String?

    private enum CodingKeys: String, CodingKey {
        case publishDate = "published_date"
        case title = "title"
        case body = "abstract"
        case media = "media"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
        body = try values.decodeIfPresent(String.self, forKey: .body) ?? ""
        publishDate = try values.decode(String.self, forKey: .publishDate)
        media = try values.decodeIfPresent([MediaModel].self, forKey: .media)!
        image = media?.first?.mediaFiles.last?.imgString
    }
    init(title: String, body: String, date: String, image: String) {
        self.title = title
        self.body = body
        self.publishDate = date
        self.image = image
        self.media = nil
    }
}

fileprivate struct MediaModel: Decodable {
    let mediaFiles : [MediaData]
    
    private enum CodingKeys: String, CodingKey {
         case mediaFiles = "media-metadata"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        mediaFiles = try! values.decode([MediaData].self, forKey: .mediaFiles)
    }
}

fileprivate struct MediaData: Decodable {
    let imgString : String
    let height : Int
    let width : Int
    
    private enum CodingKeys: String, CodingKey {
        case imgString = "url"
        case height = "height"
        case width = "width"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        imgString = try! values.decode(String.self, forKey: .imgString)
        height = try! values.decode(Int.self, forKey: .height)
        width = try! values.decode(Int.self, forKey: .width)
    }
}
