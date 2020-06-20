//
//  NewsFeed.swift
//  VRG_soft_demo_NewsReader
//
//  Created by Sergey berdnik on 20.06.2020.
//  Copyright © 2020 Sergey berdnik. All rights reserved.
//

import Foundation

struct NewsFeed: Decodable {

    let publishDate : Date?
    let title: String
    let body : String
    let media : MediaModel

    private enum CodingKeys: String, CodingKey {
        case publishDate = "published_date"
        case title = "title"
        case body = "abstract"
        case media = "media"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try! values.decode(String.self, forKey: .title)
        body = try! values.decode(String.self, forKey: .body)
        media = try! values.decode(MediaModel.self, forKey: .media)
        publishDate = try values.decodeIfPresent(Date.self, forKey: .publishDate)
    }
}

struct MediaModel: Decodable {
    let mediaFiles : [MediaData]
    
    private enum CodingKeys: String, CodingKey {
         case mediaFiles = "media-metadata"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        mediaFiles = try! values.decode([MediaData].self, forKey: .mediaFiles)
    }
}

struct MediaData: Decodable {
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
