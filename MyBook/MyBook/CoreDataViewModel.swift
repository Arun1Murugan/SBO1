//
//  CoreDataViewModel.swift
//  MyBook
//
//  Created by Arun Skyraan  on 21/12/22.
//

import SwiftUI
import Foundation
import CoreData

class CoreDataViewModel {

    static let instance = CoreDataViewModel()

    let persistentContainer: NSPersistentContainer

    init() {
        persistentContainer = NSPersistentContainer(name: "DBModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Core Data Store failed \(error.localizedDescription)")
            }
        }
    }

    //CategoriesEntity

    func saveCategories(categoryId: String, categoryTitle: String, catgoryThumbURL: String, isFav: String, categoryIconImage: String?, icon_rgb: String, categoryThumbUploadType: String, categoryIconUploadType: String) {

        if CategoriesExists(categoryId: categoryId) {
            print("Category Already exists in CoreData")
        } else {

            let data_1 = CategoriesEntity(context: persistentContainer.viewContext)

            data_1.categoryId = categoryId
            data_1.categoryTitle = categoryTitle
            data_1.catgoryThumbURL = catgoryThumbURL
            data_1.isFav = isFav
            data_1.categoryIconImage = categoryIconImage
            data_1.icon_rgb = icon_rgb
            data_1.categoryThumbUploadType = categoryThumbUploadType
            data_1.categoryIconImage = categoryIconImage

            do {
                try persistentContainer.viewContext.save()
            } catch {
                print("Failed to save data \(error)")
            }
        }
    }

    func getCategoriesEntity() -> [CategoriesEntity] {
        let fetchRequest: NSFetchRequest<CategoriesEntity> = CategoriesEntity.fetchRequest()
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return[]
        }
    }

    func CategoriesExists(categoryId: String) -> Bool {

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CategoriesEntity")

        fetchRequest.predicate = NSPredicate(format: "categoryId = %@", categoryId)

        var results: [NSManagedObject] = []

        do {
            results = try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print("error executing fetch request: \(error)")
        }
        return results.count > 0
    }

    //BookListEntity

    func saveBookList(booksList: String?, categoryId: String) {

        if BookListExists(booksList: booksList, categoryId: categoryId) {

            print("BookList already exists")

        } else {

            let data_2 = BookListEntity(context: persistentContainer.viewContext)

            data_2.booksList = booksList
            data_2.categoryId = categoryId

            do {
                try persistentContainer.viewContext.save()
            } catch {
                print("Failed to save data \(error)")
            }
        }
    }

    func getBookListEntity() -> [BookListEntity] {
        let fetchRequest: NSFetchRequest<BookListEntity> = BookListEntity.fetchRequest()
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return[]
        }
    }
    func BookListExists(booksList: String?, categoryId: String) -> Bool {

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "BookListEntity")

        fetchRequest.predicate = NSPredicate(format: "booksList = %@ && categoryId = %@", booksList!, categoryId)

        var results: [NSManagedObject] = []

        do {
            results = try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print("error executing fetch request: \(error)")
        }
        return results.count > 0
    }

    func PredicateBooksList(categoryId: String)->[BookListEntity]{
        let fetchRequest: NSFetchRequest<BookListEntity> = BookListEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format:"categoryId == %@", categoryId)
        do {
            let fetchedResults = try persistentContainer.viewContext.fetch(fetchRequest)
            return fetchedResults
        } catch {
            return[]
        }
    }

    //IndividualBookEntity


    func saveIndividualBook(bookId: String?, bookUserId: String?, bookAdmin: String?, bookCountryCode: String?, bookLangCode: String?, bookCategory: String?, bookName: String?, bookImageUploadType: String?, bookImage: String?, bookDescription: String?, BookPriceIdentifier: String?, BookPublisherName: String?, bookAuthorName: String?, BookPublished: String?, bookType: String?, thumbAuto: String?, bookOrgFile: String?, bookFileName: String?, bookSplitedPages: String?, relatedBooks: String?, bookKeywords: String?, bookHighRes: String?, is_lndscape: String?, is_portrait: String?, is_sharing: String?, ismagfly: String?, isPreviewAvailable: String?, priceInCurr: String?, advPages: String?, formats: String?, lastReadPage: String?, iss_version: String?, is_tocAvailable: String?, isArticleAvailable: String?, isInternational: String?, isSubscriptionAvailable: String?, geoblock: String?, notes: String?, isAdsupported: String?, age_rate: String?, rank: String?, version: String?, bookisLoc: String?, bookLocId: String?, bookLocLat: String?, bookLocLng: String?, bookLocName: String?, bookLocDes: String?, bookLocTnxMsg: String?, bookLocStartTime: String?, bookLocEndTime: String?, bookLocDuration: String?, locationaccess_type: String?, locationtime_acess: String?, bookLocRadius: String?, bookLocBanner: String?, bookLocIcon: String?, bookLocLibId: String?, bookLocBannerType: String?, bookLocIconType: String?, bookPasscode: String?, bookHtmlFiles: String?, booksToc: String?, isPrime: String?, time_based: String?, bookAdded: String?, bookUpdated: String?, bookDisabled: String?, bookDeleted: String?, bookRatings: String?, bookDownloadCount: String?, bookPreviewCount: String?) {

        let data_3 = IndividualBookEntity(context: persistentContainer.viewContext)

        data_3.bookId = bookId
        data_3.bookUserId = bookUserId
        data_3.bookAdmin = bookAdmin
        data_3.bookCountryCode = bookCountryCode
        data_3.bookLangCode = bookLangCode
        data_3.bookCategory = bookCategory
        data_3.bookName = bookName
        data_3.bookImageUploadType = bookImageUploadType
        data_3.bookImage = bookImage
        data_3.bookDescription = bookDescription
        data_3.bookPriceIdentifier = BookPriceIdentifier
        data_3.bookPublisherName = BookPublisherName
        data_3.bookAuthorName = bookAuthorName
        data_3.bookPublished = BookPublished
        data_3.bookType = bookType
        data_3.thumbAuto = thumbAuto
        data_3.bookOrgFile = bookOrgFile
        data_3.bookFileName = bookFileName
        data_3.bookSplitedPages = bookSplitedPages
        data_3.relatedBooks = relatedBooks
        data_3.bookKeywords = bookKeywords
        data_3.bookHighRes = bookHighRes
        data_3.is_lndscape = is_lndscape
        data_3.is_portrait = is_portrait
        data_3.is_sharing = is_sharing
        data_3.ismagfly = ismagfly
        data_3.isPreviewAvailable = isPreviewAvailable
        data_3.priceInCurr = priceInCurr
        data_3.advPages = advPages
        data_3.formats = formats
        data_3.lastReadPage = lastReadPage
        data_3.iss_version = iss_version
        data_3.is_tocAvailable = is_tocAvailable
        data_3.isArticleAvailable = isArticleAvailable
        data_3.isInternational = isInternational
        data_3.isSubscriptionAvailable = isSubscriptionAvailable
        data_3.geoblock = geoblock
        data_3.notes = notes
        data_3.isAdsupported = isAdsupported
        data_3.age_rate = age_rate
        data_3.rank = rank
        data_3.version = version
        data_3.bookisLoc = bookisLoc
        data_3.bookLocId = bookLocId
        data_3.bookLocLat = bookLocLat
        data_3.bookLocLng = bookLocLng
        data_3.bookLocName = bookLocName
        data_3.bookLocDes = bookLocDes
        data_3.bookLocTnxMsg = bookLocTnxMsg
        data_3.bookLocStartTime = bookLocStartTime
        data_3.bookLocEndTime = bookLocEndTime
        data_3.bookLocDuration = bookLocDuration
        data_3.locationaccess_type = locationaccess_type
        data_3.locationtime_acess = locationtime_acess
        data_3.bookLocRadius = bookLocRadius
        data_3.bookLocBanner = bookLocBanner
        data_3.bookLocIcon = bookLocIcon
        data_3.bookLocLibId = bookLocLibId
        data_3.bookLocBannerType = bookLocBannerType
        data_3.bookLocIconType = bookLocIconType
        data_3.bookPasscode = bookPasscode
        data_3.bookHtmlFiles = bookHtmlFiles
        data_3.booksToc = booksToc
        data_3.isPrime = isPrime
        data_3.time_based = time_based
        data_3.bookAdded = bookAdded
        data_3.bookUpdated = bookUpdated
        data_3.bookDisabled = bookDisabled
        data_3.bookDeleted = bookDeleted
        data_3.bookRatings = bookRatings
        data_3.bookDownloadCount = bookDownloadCount
        data_3.bookPreviewCount = bookPreviewCount

        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("Failed to save data \(error)")
        }
    }

    func getIndividualBook() -> [IndividualBookEntity] {
        let fetchRequest: NSFetchRequest<IndividualBookEntity> = IndividualBookEntity.fetchRequest()
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return[]
        }
    }

    func PredicateIndividualBook(bookId: String)->[IndividualBookEntity]{
        let fetchRequest: NSFetchRequest<IndividualBookEntity> = IndividualBookEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format:"bookId == %@", bookId)
        do {
            let fetchedResults = try persistentContainer.viewContext.fetch(fetchRequest)
            return fetchedResults
        } catch {
            return[]
        }
    }

}



