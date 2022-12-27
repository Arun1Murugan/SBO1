//
//  ContentView.swift
//  MyBook
//
//  Created by Arun Skyraan  on 21/12/22.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var jsonvm = JsonViewModel()

    @State var categoriesEntity: [CategoriesEntity] = CoreDataViewModel.instance.getCategoriesEntity()

    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                ForEach(jsonvm.categoriesEntity, id: \.self) { index in

                    

                    BooksHZLScrollView(categoryID: index.categoryId ?? "", categoryTitle: index.categoryTitle ?? "")

//                    NavigationLink(destination: {
//                        BookListView(categoryID: index.categoryId ?? "", categoryTitle: index.categoryTitle ?? "")
//                    }, label: {
//                        Text("\(index.categoryTitle!)")
//                    })

                }
            }


        }
        .padding()
        .onAppear {
            jsonvm.getCategories()
        }
        .navigationTitle("My Book")
//        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
//            ToolbarItemGroup(placement: .bottomBar) {
//                NavigationLink(destination: {
//
//                }, label: {
//                    Image(systemName: "plus.square")
//                })
//                NavigationLink(destination: {
//
//                }, label: {
//                    Image(systemName: "plus.square")
//                })
//                NavigationLink(destination: {
//
//                }, label: {
//                    Image(systemName: "plus.square")
//                })
//                NavigationLink(destination: {
//
//                }, label: {
//                    Image(systemName: "plus.square")
//                })
//            }

            ToolbarItemGroup(placement: .navigationBarTrailing) {

                NavigationLink(destination: {
                    SamplePDFView()
                }, label: {
                    Image(systemName: "square.and.arrow.down.on.square.fill")
                })

            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
