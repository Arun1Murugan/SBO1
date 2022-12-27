//
//  JsonViewModel.swift
//  MyBook
//
//  Created by Arun Skyraan  on 21/12/22.
//

import SwiftUI
import Foundation


class JsonViewModel: ObservableObject {

    static var shared = JsonViewModel()
    
    @Published var categories: [categoriesList] = []
    @Published var bookLists: String = ""
    @Published var individualBook: [booksList] = []

    @Published var categoriesEntity: [CategoriesEntity] = []
    @Published var bookListEntity: [BookListEntity] = []
    @Published var individualBookEntity: [IndividualBookEntity] = []

    func getCategories() {

        categoriesEntity = CoreDataViewModel.instance.getCategoriesEntity()

        if categoriesEntity.count > 0 {

        } else {
            FetchCategory(categoryCountry: "IN")
        }
    }

    func getBooksList(bookCategory: String, categoryId: String) {

        bookListEntity = CoreDataViewModel.instance.PredicateBooksList(categoryId: categoryId)

        if bookListEntity.count > 0 {

        } else {
            FetchBookList(bookCategory: bookCategory, categoryId: categoryId)
        }
    }

    func getIndividualBook(bookId: String) {

        individualBookEntity = CoreDataViewModel.instance.PredicateIndividualBook(bookId: bookId)

        if individualBookEntity.count > 0 {

        } else {
            FetchBook(bookId: bookId)
        }
    }

    func FetchCategory(categoryCountry: String) { //Category API (categoryCountry : "IN")

        let postData = NSMutableData(data: "categoryCountry=\(categoryCountry)".data(using: String.Encoding.utf8)!)

        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        let request = NSMutableURLRequest(url: NSURL(string: "https://bookmaddie.com/webservice/api/get_categories.json")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)

        request.httpMethod = "POST"
        request.httpBody = postData as Data
        request.allHTTPHeaderFields = headers

        URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in

            if let data = data {
//                print(String(data: data, encoding: .utf8))
                if let decodedResponse = try? JSONDecoder().decode(CategoriesStruct.self, from: data) {
//                    print(decodedResponse)
                    DispatchQueue.main.async {

                        self.categories = decodedResponse.categoriesList

                        for i in self.categories {

//                            print(i.categoryId)

                            CoreDataViewModel.instance.saveCategories(categoryId: i.categoryId, categoryTitle: i.categoryTitle, catgoryThumbURL: i.catgoryThumbURL, isFav: i.isFav, categoryIconImage: i.categoryIconImage, icon_rgb: i.icon_rgb, categoryThumbUploadType: i.categoryThumbUploadType, categoryIconUploadType: i.categoryIconUploadType)
                        }

                        self.categoriesEntity = CoreDataViewModel.instance.getCategoriesEntity()

                    }
                    return
                }
                else {
                    print("json parse error")
                }
            }else{
                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")}

        }.resume()
    }


    func FetchBookList(bookCategory: String, categoryId: String) { //BookList API (bookCategory : "14")

        let postData = NSMutableData(data: "bookCategory=\(bookCategory)".data(using: String.Encoding.utf8)!)

        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        let request = NSMutableURLRequest(url: NSURL(string: "https://bookmaddie.com/webservice/api/get_books.json")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 30.0)

        request.httpMethod = "POST"
        request.httpBody = postData as Data
        request.allHTTPHeaderFields = headers

        URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in

            if let data = data {
//                print(String(data: data, encoding: .utf8))
                if let decodedResponse = try? JSONDecoder().decode(BookListStruct.self, from: data) {
//                    print(decodedResponse)
                    DispatchQueue.main.async {

                        self.bookLists = decodedResponse.booksList ?? ""

//                        for i in self.bookLists {
                        CoreDataViewModel.instance.saveBookList(booksList: self.bookLists, categoryId: categoryId)
                        print("\(self.bookLists)")
//                        }

                        self.bookListEntity = CoreDataViewModel.instance.PredicateBooksList(categoryId: categoryId)

                    }
                    return
                } else {
                    print("json parse error")
                }
            } else {
                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")}

        }.resume()
    }


    func FetchBook(bookId: String) { //Book API (bookId : "IN")

        let postData = NSMutableData(data: "bookId=\(bookId)".data(using: String.Encoding.utf8)!)

        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        let request = NSMutableURLRequest(url: NSURL(string: "https://bookmaddie.com/webservice/api/get_books_details.json")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)

        request.httpMethod = "POST"
        request.httpBody = postData as Data
        request.allHTTPHeaderFields = headers

        URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in

            if let data = data {
//                print(String(data: data, encoding: .utf8))
                if let decodedResponse = try? JSONDecoder().decode(IndividualBookStruct.self, from: data) {
                    print(decodedResponse)
                    DispatchQueue.main.async {
                        if let bookLIst = decodedResponse.booksList.relatedBooks{
                            CoreDataViewModel.instance.saveIndividualBook(bookId: decodedResponse.booksList.bookId, bookUserId: decodedResponse.booksList.bookUserId, bookAdmin: decodedResponse.booksList.bookAdmin, bookCountryCode: decodedResponse.booksList.bookCountryCode, bookLangCode: decodedResponse.booksList.bookLangCode, bookCategory: decodedResponse.booksList.bookCategory, bookName: decodedResponse.booksList.bookName, bookImageUploadType: decodedResponse.booksList.bookImageUploadType, bookImage: decodedResponse.booksList.bookImage, bookDescription: decodedResponse.booksList.bookDescription, BookPriceIdentifier: decodedResponse.booksList.BookPriceIdentifier, BookPublisherName: decodedResponse.booksList.BookPublisherName, bookAuthorName: decodedResponse.booksList.bookAuthorName, BookPublished: decodedResponse.booksList.BookPublished, bookType: decodedResponse.booksList.bookType, thumbAuto: decodedResponse.booksList.thumbAuto, bookOrgFile: decodedResponse.booksList.bookOrgFile, bookFileName: decodedResponse.booksList.bookFileName, bookSplitedPages: decodedResponse.booksList.bookSplitedPages, relatedBooks:  bookLIst.joined(separator: ","), bookKeywords: decodedResponse.booksList.bookKeywords, bookHighRes: decodedResponse.booksList.bookHighRes, is_lndscape: decodedResponse.booksList.is_lndscape, is_portrait: decodedResponse.booksList.is_portrait, is_sharing: decodedResponse.booksList.is_sharing, ismagfly: decodedResponse.booksList.ismagfly, isPreviewAvailable: decodedResponse.booksList.isPreviewAvailable, priceInCurr: decodedResponse.booksList.priceInCurr, advPages: decodedResponse.booksList.advPages, formats: decodedResponse.booksList.formats, lastReadPage: decodedResponse.booksList.lastReadPage, iss_version: decodedResponse.booksList.iss_version, is_tocAvailable: decodedResponse.booksList.is_tocAvailable, isArticleAvailable: decodedResponse.booksList.isArticleAvailable, isInternational: decodedResponse.booksList.isInternational, isSubscriptionAvailable: decodedResponse.booksList.isSubscriptionAvailable, geoblock: decodedResponse.booksList.geoblock, notes: decodedResponse.booksList.notes, isAdsupported: decodedResponse.booksList.isAdsupported, age_rate: decodedResponse.booksList.age_rate, rank: decodedResponse.booksList.rank, version: decodedResponse.booksList.version, bookisLoc: decodedResponse.booksList.bookisLoc, bookLocId: decodedResponse.booksList.bookLocId, bookLocLat: decodedResponse.booksList.bookLocLat, bookLocLng: decodedResponse.booksList.bookLocLng, bookLocName: decodedResponse.booksList.bookLocName, bookLocDes: decodedResponse.booksList.bookLocDes, bookLocTnxMsg: decodedResponse.booksList.bookLocTnxMsg, bookLocStartTime: decodedResponse.booksList.bookLocStartTime, bookLocEndTime: decodedResponse.booksList.bookLocEndTime, bookLocDuration: decodedResponse.booksList.bookLocDuration, locationaccess_type: decodedResponse.booksList.locationaccess_type, locationtime_acess: decodedResponse.booksList.locationtime_acess, bookLocRadius: decodedResponse.booksList.bookLocRadius, bookLocBanner: decodedResponse.booksList.bookLocBanner, bookLocIcon: decodedResponse.booksList.bookLocIcon, bookLocLibId: decodedResponse.booksList.bookLocLibId, bookLocBannerType: decodedResponse.booksList.bookLocBannerType, bookLocIconType: decodedResponse.booksList.bookLocIconType, bookPasscode: decodedResponse.booksList.bookPasscode, bookHtmlFiles: decodedResponse.booksList.bookHtmlFiles, booksToc: decodedResponse.booksList.booksToc, isPrime: decodedResponse.booksList.isPrime, time_based: decodedResponse.booksList.time_based, bookAdded: decodedResponse.booksList.bookAdded, bookUpdated: decodedResponse.booksList.bookUpdated, bookDisabled: decodedResponse.booksList.bookDisabled, bookDeleted: decodedResponse.booksList.bookDeleted, bookRatings: decodedResponse.booksList.bookRatings, bookDownloadCount: decodedResponse.booksList.bookDownloadCount, bookPreviewCount: decodedResponse.booksList.bookPreviewCount)
                        }else{
                            CoreDataViewModel.instance.saveIndividualBook(bookId: decodedResponse.booksList.bookId, bookUserId: decodedResponse.booksList.bookUserId, bookAdmin: decodedResponse.booksList.bookAdmin, bookCountryCode: decodedResponse.booksList.bookCountryCode, bookLangCode: decodedResponse.booksList.bookLangCode, bookCategory: decodedResponse.booksList.bookCategory, bookName: decodedResponse.booksList.bookName, bookImageUploadType: decodedResponse.booksList.bookImageUploadType, bookImage: decodedResponse.booksList.bookImage, bookDescription: decodedResponse.booksList.bookDescription, BookPriceIdentifier: decodedResponse.booksList.BookPriceIdentifier, BookPublisherName: decodedResponse.booksList.BookPublisherName, bookAuthorName: decodedResponse.booksList.bookAuthorName, BookPublished: decodedResponse.booksList.BookPublished, bookType: decodedResponse.booksList.bookType, thumbAuto: decodedResponse.booksList.thumbAuto, bookOrgFile: decodedResponse.booksList.bookOrgFile, bookFileName: decodedResponse.booksList.bookFileName, bookSplitedPages: decodedResponse.booksList.bookSplitedPages, relatedBooks: "", bookKeywords: decodedResponse.booksList.bookKeywords, bookHighRes: decodedResponse.booksList.bookHighRes, is_lndscape: decodedResponse.booksList.is_lndscape, is_portrait: decodedResponse.booksList.is_portrait, is_sharing: decodedResponse.booksList.is_sharing, ismagfly: decodedResponse.booksList.ismagfly, isPreviewAvailable: decodedResponse.booksList.isPreviewAvailable, priceInCurr: decodedResponse.booksList.priceInCurr, advPages: decodedResponse.booksList.advPages, formats: decodedResponse.booksList.formats, lastReadPage: decodedResponse.booksList.lastReadPage, iss_version: decodedResponse.booksList.iss_version, is_tocAvailable: decodedResponse.booksList.is_tocAvailable, isArticleAvailable: decodedResponse.booksList.isArticleAvailable, isInternational: decodedResponse.booksList.isInternational, isSubscriptionAvailable: decodedResponse.booksList.isSubscriptionAvailable, geoblock: decodedResponse.booksList.geoblock, notes: decodedResponse.booksList.notes, isAdsupported: decodedResponse.booksList.isAdsupported, age_rate: decodedResponse.booksList.age_rate, rank: decodedResponse.booksList.rank, version: decodedResponse.booksList.version, bookisLoc: decodedResponse.booksList.bookisLoc, bookLocId: decodedResponse.booksList.bookLocId, bookLocLat: decodedResponse.booksList.bookLocLat, bookLocLng: decodedResponse.booksList.bookLocLng, bookLocName: decodedResponse.booksList.bookLocName, bookLocDes: decodedResponse.booksList.bookLocDes, bookLocTnxMsg: decodedResponse.booksList.bookLocTnxMsg, bookLocStartTime: decodedResponse.booksList.bookLocStartTime, bookLocEndTime: decodedResponse.booksList.bookLocEndTime, bookLocDuration: decodedResponse.booksList.bookLocDuration, locationaccess_type: decodedResponse.booksList.locationaccess_type, locationtime_acess: decodedResponse.booksList.locationtime_acess, bookLocRadius: decodedResponse.booksList.bookLocRadius, bookLocBanner: decodedResponse.booksList.bookLocBanner, bookLocIcon: decodedResponse.booksList.bookLocIcon, bookLocLibId: decodedResponse.booksList.bookLocLibId, bookLocBannerType: decodedResponse.booksList.bookLocBannerType, bookLocIconType: decodedResponse.booksList.bookLocIconType, bookPasscode: decodedResponse.booksList.bookPasscode, bookHtmlFiles: decodedResponse.booksList.bookHtmlFiles, booksToc: decodedResponse.booksList.booksToc, isPrime: decodedResponse.booksList.isPrime, time_based: decodedResponse.booksList.time_based, bookAdded: decodedResponse.booksList.bookAdded, bookUpdated: decodedResponse.booksList.bookUpdated, bookDisabled: decodedResponse.booksList.bookDisabled, bookDeleted: decodedResponse.booksList.bookDeleted, bookRatings: decodedResponse.booksList.bookRatings, bookDownloadCount: decodedResponse.booksList.bookDownloadCount, bookPreviewCount: decodedResponse.booksList.bookPreviewCount)
                        }

//                        self.individualBook = decodedResponse.booksList

//                        for i in self.individualBook {

//                            print("\(de)")
                            
//                            CoreDataViewModel.instance.saveIndividualBook(bookId: i.bookId, bookName: i.bookName, bookDescription: i.bookDescription, BookPublisherName: i.BookPublisherName, bookAuthorName: i.bookAuthorName, BookPublished: i.BookPublished, bookImage: i.bookImage)
//                        }

                        self.individualBookEntity = CoreDataViewModel.instance.PredicateIndividualBook(bookId: bookId)
                    }
                    return
                }
                else {
                    print("json parse error")
                }
            }else{
                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")}

        }.resume()
    }
}
