//
//  BookListView.swift
//  MyBook
//
//  Created by Arun Skyraan  on 26/12/22.
//

import SwiftUI

struct BookListView: View {

    @ObservedObject var jsonvm = JsonViewModel()

    @State var categoryID: String
    @State var categoryTitle: String
    

    @State var bookList: [BookListEntity] = []

    var body: some View {
        if jsonvm.bookListEntity.count > 0 {
        VStack {
            ForEach(jsonvm.bookListEntity, id: \.self) { index in
                if let item = index.booksList, let ItemArr = item.split(separator: ","){ //spliting the Array[String]
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
        .navigationTitle(categoryTitle)
        .navigationBarTitleDisplayMode(.inline)


        } else {
            ProgressView("Fetching...")
                .onAppear {
//                    print(categoryID)
                    jsonvm.getBooksList(bookCategory: categoryID, categoryId: categoryID)
                }
                .navigationTitle(categoryTitle)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

//struct BookListView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookListView()
//    }
//}
