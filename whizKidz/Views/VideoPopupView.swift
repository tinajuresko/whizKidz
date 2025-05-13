//
//  VideoPopupView.swift
//  whizKidz
//
//  Created by Tina Jureško on 25.03.2025..
//

import SwiftUI
import WebKit

struct YouTubeView: UIViewRepresentable {
    let videoID: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        let url = URL(string: "https://www.youtube.com/embed/\(videoID)?autoplay=1")!
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {}
}

struct VideoPopupView: View {
    @Binding var showVideo: Bool

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: { showVideo = false }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundColor(.gray)
                        .padding()
                }
            }
            GifImageView(name: "astronautMusic")
                .frame(width: 120, height: 120)
                .offset(x: 100 ,y: 10)
                
            YouTubeView(videoID: "wCio_xVlgQ0")
                .frame(height: 300)
                .cornerRadius(10)
                .padding()
        }
    }
}

#Preview {
    VideoPopupView(showVideo: .constant(true))
}
