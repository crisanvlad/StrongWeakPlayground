//
//  WatchlistInteractor.swift
//  TestStrongCapture
//
//  Created by Vlad Crisan on 24.02.2025.
//
import Combine
import Foundation

/// Concrete interactor for testing
class WatchlistInteractor: WatchlistInteracting {
    private var count = 0
    
    func deleteWatchlistItems(_ identifiers: [String], for watchlist: String) -> AnyPublisher<DeleteResponse, Error> {
        // Simulate async network call
        return Future { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                promise(.success(DeleteResponse()))
            }
        }.eraseToAnyPublisher()
    }
    
    func deleteLocalWatchlistItems(_ identifiers: [String], for watchlist: String) {
        count += identifiers.count
        print("Local deletion performed: \(count)")
    }
    
    init() {
        print("Interactor Initialized")
    }
    
    deinit {
        print("Interactor deallocated")
    }
}
