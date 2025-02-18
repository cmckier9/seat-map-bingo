//
//  View+Extensions.swift
//  Seat Map Bingo
//
//  Created by Evan Westermann on 10/22/24.
//

import SwiftUI

extension View {
//    func asImage() -> UIImage {
//        let controller = UIHostingController(rootView: self)
//        let view = controller.view
//
//        let targetSize = CGSize(width: 300, height: 500) // Adjust as needed
//        view?.bounds = CGRect(origin: .zero, size: targetSize)
//        view?.backgroundColor = .clear
//        
//        // Render the view into an image
//        let renderer = UIGraphicsImageRenderer(size: targetSize)
//        return renderer.image { _ in
//            view?.drawHierarchy(in: view!.bounds, afterScreenUpdates: true)
//        }
//    }
    
    // A function to render the SwiftUI view as a UIImage
    func asImage(scrollViewSize: CGSize) -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        // Set the size of the view to be the same as the ScrollView content size
        view?.bounds = CGRect(origin: .zero, size: scrollViewSize)
        view?.backgroundColor = .clear

        // Render the view into an image
        let renderer = UIGraphicsImageRenderer(size: scrollViewSize)
        return renderer.image { _ in
            view?.drawHierarchy(in: view!.bounds, afterScreenUpdates: true)
        }
    }
    
    @ViewBuilder func `if`<Content: View>(
        _ condition: Bool,
        transform: (Self) -> Content
    ) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
