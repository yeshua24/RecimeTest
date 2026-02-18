//
//  CachedAsyncImage.swift
//  RecimeTest
//
//  Created by Yeshua Lagac on 2/15/26.
//

import Foundation
import SwiftUI
import UIKit

final class ImageCache {

    static let shared = ImageCache()

    private let memory = NSCache<NSString, UIImage>()
    private let fileManager = FileManager.default
    private let diskURL: URL

    private init() {
        memory.countLimit = 200

        let urls = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)
        diskURL = urls[0].appendingPathComponent("image_cache")

        try? fileManager.createDirectory(at: diskURL, withIntermediateDirectories: true)
    }

    // MARK: Public

    func image(for url: URL) -> UIImage? {
        let key = cacheKey(url)

        if let mem = memory.object(forKey: key as NSString) {
            return mem
        }

        let path = diskURL.appendingPathComponent(key)
        if let data = try? Data(contentsOf: path),
           let image = UIImage(data: data) {
            memory.setObject(image, forKey: key as NSString)
            return image
        }

        return nil
    }

    func save(_ image: UIImage, for url: URL) {
        let key = cacheKey(url)
        memory.setObject(image, forKey: key as NSString)

        let path = diskURL.appendingPathComponent(key)
        if let data = image.jpegData(compressionQuality: 0.85) {
            try? data.write(to: path)
        }
    }

    private func cacheKey(_ url: URL) -> String {
        url.absoluteString.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? UUID().uuidString
    }
}

import UIKit

actor ImageDownloader {

    static let shared = ImageDownloader()

    private var runningTasks: [URL: Task<UIImage?, Never>] = [:]

    func load(_ url: URL) async -> UIImage? {

        if let cached = ImageCache.shared.image(for: url) {
            return cached
        }

        if let existing = runningTasks[url] {
            return await existing.value
        }

        let task = Task<UIImage?, Never> {
            defer { runningTasks[url] = nil }

            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                guard let image = UIImage(data: data) else { return nil }

                ImageCache.shared.save(image, for: url)
                return image
            } catch {
                return nil
            }
        }

        runningTasks[url] = task
        return await task.value
    }
}

struct CachedAsyncImage: View {

    let url: URL?

    @State private var image: UIImage?
    @State private var isLoading = false
    @State private var didFail = false

    init(url: URL?) {
        self.url = url
    }

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                if let image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: proxy.size.width, height: proxy.size.height)
                        .clipped()
                        .transition(.opacity)
                } else if didFail {
                    ZStack {
                        Color.gray.opacity(0.15)
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.system(size: 22))
                            .foregroundStyle(.gray)
                    }
                    .frame(width: proxy.size.width, height: proxy.size.height)
                } else {
                    Color.gray.opacity(0.5)
                        .modifier(Shimmer())
                }
            }
        }
        .task(id: url) {
            await load()
        }
    }

    @MainActor private func load() async {
        guard let url, image == nil else { return }

        isLoading = true
        let result = await ImageDownloader.shared.load(url)

        if let result {
            withAnimation(.easeOut(duration: 0.25)) {
                image = result
            }
            didFail = false
        } else {
            didFail = true
        }
        isLoading = false
    }
}
