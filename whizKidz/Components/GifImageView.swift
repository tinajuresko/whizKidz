//
//  GifImageView.swift
//  whizKidz
//
//  Created by Tina Jureško on 31.12.2024..
//

import SwiftUI
import UIKit

// Extension for UIImage that allows loading GIFs from Assets
extension UIImage {
    public class func gif(asset: String) -> UIImage? {
        if let asset = NSDataAsset(name: asset) {
            return UIImage.gif(data: asset.data)
        }
        return nil
    }

    private class func gif(data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            return nil
        }
        
        let count = CGImageSourceGetCount(source)
        var images = [UIImage]()
        
        for i in 0..<count {
            if let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(UIImage(cgImage: cgImage))
            }
        }
        return UIImage.animatedImage(with: images, duration: Double(count) * 0.1)
    }
}

struct GifImageView: UIViewRepresentable {
    private let name: String
    
    init(name: String) {
        self.name = name
    }
    func makeUIView(context: Context) -> UIImageView {
        let imageView = UIImageView()
        if let gifImage = UIImage.gif(asset: name) {
            imageView.image = gifImage
        }
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    func updateUIView(_ uiView: UIImageView, context: Context) {}
}

