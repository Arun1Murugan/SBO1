//
//  SamplePDFView.swift
//  MyBook
//
//  Created by Arun Skyraan  on 27/12/22.
//

import SwiftUI
import PDFKit

struct SamplePDFView: View {

    let documentURL = Bundle.main.url(forResource: "Sample1", withExtension: "pdf")!
//    let configuration = PSPDFConfiguration {
//            $0.pageTransition = .scrollContinuous
//            $0.pageMode = .single
//            $0.scrollDirection = .vertical
//            $0.backgroundColor = .white
//        }
    @State var isPDFReading: Bool = false

    var body: some View {

        ZStack {
            VStack {
                HStack {
                    Button(action: {
                        isPDFReading = true
                    }, label: {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.blue.opacity(0.5))
                            .frame(width: 100, height: 100)
                            .overlay(
                                ZStack {
                                    Text("PDF")
                                }
                            )
                    })
                }
            }
            if isPDFReading {
                PDFKitView(url: documentURL, isPDFReading: $isPDFReading)
            }
        }
    }
}

struct SamplePDFView_Previews: PreviewProvider {
    static var previews: some View {
        SamplePDFView()
    }
}

struct PDFKitRepresentedView: UIViewRepresentable {
    let url: URL

    init(_ url: URL) {
        self.url = url
    }

    func makeUIView(context: UIViewRepresentableContext<PDFKitRepresentedView>) -> PDFKitRepresentedView.UIViewType {
        // Create a `PDFView` and set its `PDFDocument`.
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: self.url)
        return pdfView
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PDFKitRepresentedView>) {
        // Update the view.
    }
}

struct PDFKitView: View {

    var url: URL
    @Binding var isPDFReading: Bool
    @State var isOnTapped: Bool = false

    var body: some View {
        ZStack {
            VStack {
//                HStack {
//                    if isOnTapped {
//                        Button(action: {
//                            isPDFReading = false
//                        }, label: {
//                            Image(systemName: "chevron.left")
//                        })
//                        Spacer()
//                    }
//
//                }

                PDFKitRepresentedView(url)
                    .onTapGesture {
                        isOnTapped.toggle()
                    }
            }

//            if isOnTapped {
//                VStack {

//                    Spacer()
//                }
//            }
        }
        
    }
}

//struct PDFViewController: UIViewControllerRepresentable {
//    let url: URL
//    let configuration: PSPDFConfiguration?
//
//    init(_ url: URL, configuration: PSPDFConfiguration?) {
//        self.url = url
//        self.configuration = configuration
//    }
//
//    func makeUIViewController(context: UIViewControllerRepresentableContext<PDFViewController>) -> UINavigationController {
//        // Create a `PSPDFDocument`.
//        let document = PSPDFDocument(url: url)
//
//        // Create the `PSPDFViewController`.
//        let pdfController = PSPDFViewController(document: document, configuration: configuration)
//        return UINavigationController(rootViewController: pdfController)
//    }
//
//    func updateUIViewController(_ uiViewController: UINavigationController, context: UIViewControllerRepresentableContext<PDFViewController>) {
//        // Update the view controller.
//    }
//}

//struct PSPDFKitView: View {
//    var url: URL
//    var configuration: PSPDFConfiguration?
//
//    var body: some View {
//        PDFViewController(url, configuration: configuration)
//    }
//}

