//
//  ImageCacheType.swift
//  SwiftUIThinking
//
//  Created by Mohamed Sliem on 10/12/2025.
//


// AsyncImageView.swift
// Reusable Async Image View for SwiftUI
// Requires iOS 15+ (for async/await & Swift concurrency)

import SwiftUI
import Combine
import UIKit

// MARK: - Image Cache Protocol & Default Implementation

public protocol ImageCacheType: AnyObject {
    subscript(_ url: URL) -> UIImage? { get set }
    func removeAll()
}

public final class TemporaryImageCache: ImageCacheType {
    private let cache = NSCache<NSURL, UIImage>()
    
    public init(totalCostLimit: Int = 1024 * 1024 * 100) { // ~100MB default
        cache.totalCostLimit = totalCostLimit
    }
    
    public subscript(_ key: URL) -> UIImage? {
        get { cache.object(forKey: key as NSURL) }
        set {
            if let image = newValue {
                let cost = image.pngData()?.count ?? 0
                cache.setObject(image, forKey: key as NSURL, cost: cost)
            } else {
                cache.removeObject(forKey: key as NSURL)
            }
        }
    }
    
    public func removeAll() {
        cache.removeAllObjects()
    }
}

// MARK: - Image Loader Actor

@MainActor
final class AsyncImageLoader: ObservableObject {
    enum State {
        case idle
        case loading
        case success(UIImage)
        case failure(Error)
    }
    
    @Published private(set) var state: State = .idle
    private var task: Task<Void, Never>?
    private let cache: ImageCacheType?
    private let session: URLSession
    
    init(cache: ImageCacheType? = nil, session: URLSession = .shared) {
        self.cache = cache
        self.session = session
    }
    
    deinit {
        task?.cancel()
    }
    
    func load(url: URL, forceReload: Bool = false) {
        // If we already have a successful image and not forceReload, keep it
        if case .success = state, !forceReload {
            return
        }
        
        // Check cache first
        if !forceReload, let cached = cache?[url] {
            state = .success(cached)
            return
        }
        
        state = .loading
        task?.cancel()
        task = Task { [weak self] in
            guard let self = self else { return }
            do {
                let (data, response) = try await session.data(from: url)
                guard let httpResponse = response as? HTTPURLResponse,
                      200...299 ~= httpResponse.statusCode else {
                    throw URLError(.badServerResponse)
                }
                guard let image = UIImage(data: data) else {
                    throw URLError(.cannotDecodeContentData)
                }
                // Cache image
                self.cache?[url] = image
                self.state = .success(image)
            } catch {
                if Task.isCancelled { return }
                self.state = .failure(error)
            }
        }
    }
    
    func cancel() {
        task?.cancel()
        task = nil
    }
    
    func clearCache(for url: URL) {
        cache?[url] = nil
    }
}
