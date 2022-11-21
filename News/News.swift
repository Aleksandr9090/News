//
//  News.swift
//  News
//
//  Created by Aleksandr on 21.11.2022.
//

import Foundation


struct Welcome {
    let category: String
    let data: [News]
    let success: Bool
}

struct News {
    let author: String
    let content: String
    let date: String
    let imageURL: String
    let readMoreURL: String
    let time, title: String
    let url: String
}

enum Link: String {
    case all = "https://inshorts.deta.dev/news?category=all"
    case national = "https://inshorts.deta.dev/news?category=national"
    case business = "https://inshorts.deta.dev/news?category=business"
    case sports = "https://inshorts.deta.dev/news?category=sports"
    case world = "https://inshorts.deta.dev/news?category=world"
    case politics = "https://inshorts.deta.dev/news?category=politics"
    case technology = "https://inshorts.deta.dev/news?category=technology"
    case startup = "https://inshorts.deta.dev/news?category=startup"
    case entertainment = "https://inshorts.deta.dev/news?category=entertainment"
    case miscellaneous = "https://inshorts.deta.dev/news?category=miscellaneous"
    case hatke = "https://inshorts.deta.dev/news?category=hatke"
    case science = "https://inshorts.deta.dev/news?category=science"
    case automobile = "https://inshorts.deta.dev/news?category=automobile"
}
