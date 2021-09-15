//
//  Article.swift
//  iosexercise
//
//  Created by Raghad alfuhaid on 08/02/1443 AH.
//

import UIKit




class Articles: Codable {
    let articles: [Article]
    
    init(articles: [Article]) {
        self.articles = articles
    }
}


class Article: Codable {
    let title: String
    let authors: String
    let date: String
    let content: String
    let image_url: String
    let website:String
    
    init(title: String, authors: String, date: String, content: String, image_url: String, website:String ) {
        self.title = title
        self.authors = authors
        self.date = date
        self.content = content
        self.image_url = image_url
        self.website = website
    }
}
