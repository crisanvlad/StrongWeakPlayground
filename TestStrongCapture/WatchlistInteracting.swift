//
//  WatchlistInteracting.swift
//  TestStrongCapture
//
//  Created by Vlad Crisan on 24.02.2025.
//

import Combine
protocol WatchlistInteracting {
    func deleteWatchlistItems(_ identifiers: [String], for watchlist: String) -> AnyPublisher<DeleteResponse, Error>
    func deleteLocalWatchlistItems(_ identifiers: [String], for watchlist: String)
}
