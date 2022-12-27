//
//  IndividualBookView.swift
//  MyBook
//
//  Created by Arun Skyraan  on 27/12/22.
//

import SwiftUI

struct IndividualBookView: View {

    @ObservedObject var jsonvm = JsonViewModel()

    @State var bookId: String

    @State var individualBook: [IndividualBookEntity] = []

    var body: some View {
        if jsonvm.individualBookEntity.count > 0 {
            VStack {
                ForEach(jsonvm.individualBookEntity) { index in
                    Text("\(index.bookId ?? "")")
                    Text("\(index.bookName ?? "")")
                    Text("\(index.bookAuthorName ?? "")")
                    Text("\(index.bookRatings ?? "")")
                }
            }
        } else {
            ProgressView("Fetching...")
                .onAppear {
                    jsonvm.getIndividualBook(bookId: bookId)
//                    jsonvm.FetchBook(bookId: bookId)
                }
        }
    }
}

struct IndividualBookView_Previews: PreviewProvider {
    static var previews: some View {
        IndividualBookView(bookId: "115")
    }
}
