//
//  Model.swift
//  MyBook
//
//  Created by Arun Skyraan  on 21/12/22.
//

import SwiftUI
import Foundation

//1

struct CategoriesStruct: Codable, Hashable {

    var categoriesList : [categoriesList]
}

struct categoriesList: Codable, Hashable {

    var categoryId: String
    var categoryTitle: String
    var catgoryThumbURL: String
    var isFav: String
    var categoryIconImage: String?
    var icon_rgb: String
    var categoryThumbUploadType: String
    var categoryIconUploadType: String

}

//2

struct BookListStruct: Codable, Hashable {
    var result : String
    var booksList: String?

}


//3

struct IndividualBookStruct: Hashable, Decodable{

    var result: String
    var booksList: booksList

}

struct booksList: Hashable, Decodable{

    var bookId: String?
    var bookUserId: String?
    var bookAdmin: String?
    var bookCountryCode: String?
    var bookLangCode: String?
    var bookCategory: String?
    var bookName: String?
    var bookImageUploadType: String?
    var bookImage: String?
    var bookDescription: String?
    var BookPriceIdentifier: String?
    var BookPublisherName: String?
    var bookAuthorName: String?
    var BookPublished: String?
    var bookType: String?
    var thumbAuto: String?
    var bookOrgFile: String?
    var bookFileName: String?
    var bookSplitedPages: String?
    var relatedBooks: [String]?
    var bookKeywords: String?
    var bookHighRes: String?
    var is_lndscape: String?
    var is_portrait: String?
    var is_sharing: String?
    var ismagfly: String?
    var isPreviewAvailable: String?
    var priceInCurr: String?
    var advPages: String?
    var formats: String?
    var lastReadPage: String?
    var iss_version: String?
    var is_tocAvailable: String?
    var isArticleAvailable: String?
    var isInternational: String?
    var isSubscriptionAvailable: String?
    var geoblock: String?
    var notes: String?
    var isAdsupported: String?
    var age_rate: String?
    var rank: String?
    var version: String?
    var bookisLoc: String?
    var bookLocId: String?
    var bookLocLat: String?
    var bookLocLng: String?
    var bookLocName: String?
    var bookLocDes: String?
    var bookLocTnxMsg: String?
    var bookLocStartTime: String?
    var bookLocEndTime: String?
    var bookLocDuration: String?
    var locationaccess_type: String?
    var locationtime_acess: String?
    var bookLocRadius: String?
    var bookLocBanner: String?
    var bookLocIcon: String?
    var bookLocLibId: String?
    var bookLocBannerType: String?
    var bookLocIconType: String?
    var bookPasscode: String?
    var bookHtmlFiles: String?
    var booksToc: String?
    var isPrime: String?
    var time_based: String?
    var bookAdded: String?
    var bookUpdated: String?
    var bookDisabled: String?
    var bookDeleted: String?
    var bookRatings: String?
    var bookDownloadCount: String?
    var bookPreviewCount: String?

}

