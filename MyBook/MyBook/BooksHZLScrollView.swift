//
//  BooksHZLScrollView.swift
//  MyBook
//
//  Created by Arun Skyraan  on 27/12/22.
//

import SwiftUI

struct BooksHZLScrollView: View {

    @ObservedObject var jsonvm = JsonViewModel()
    @State var bookList: [BookListEntity] = []

    @State var categoryID: String
    @State var categoryTitle: String


    var body: some View {
        VStack {
            HStack {
                Text("\(categoryTitle)")
                Spacer()
                NavigationLink(destination: {
                    BookListView(categoryID: categoryID, categoryTitle: categoryTitle)
                }, label: {
                    Text("More")
                })
            }
//            ScrollView(.horizontal) {
                if jsonvm.bookListEntity.isEmpty {
                    Text("NULL")
                        .onAppear {
                            jsonvm.getBooksList(bookCategory: categoryID, categoryId: categoryID)
                        }
                } else {

                    ForEach(jsonvm.bookListEntity, id: \.self) { index in

                        if let item = index.booksList, let ItemArr = item.split(separator: ","){ //spliting the Array[String]
                            ScrollView(.horizontal) {
                                ForEach(ItemArr,id:\.self){ i in

                                    NavigationLink(destination: {
                                        IndividualBookView(bookId: String(i))
                                    }, label: {
                                        Text(i)
                                    })
                                }
                            }
                        }
                    }
                }
//            }
        }
    }
}

struct BooksHZLScrollView_Previews: PreviewProvider {
    static var previews: some View {
        BooksHZLScrollView(categoryID: "14", categoryTitle: "Programming")
    }
}
