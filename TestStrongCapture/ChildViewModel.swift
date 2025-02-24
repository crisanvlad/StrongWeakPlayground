//
//  ChildViewModel.swift
//  TestStrongCapture
//
//  Created by Vlad Crisan on 24.02.2025.
//

import Combine
import Foundation

final class ChildViewModel: ObservableObject {
    private var interactor: WatchlistInteracting
    private var subscriptions = Set<AnyCancellable>()
    
    init(interactor: WatchlistInteracting) {
        self.interactor = interactor
        print("ChildViewModel initialized")
    }
    
    deinit {
        print("ChildViewModel deallocated")
    }
    
    func testSelfStrongCapture() {
        print("Testing self strong capture...")
        interactor.deleteWatchlistItems(["1", "2"], for: "test")
            .receive(on: DispatchQueue.main)
            .sink { _ in
                print("Completion received")
            } receiveValue: { _ in
                print("Deallocate view")
                DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                    // In this case the interactor will execute the use case, it will be deallocated at scope exit with self
                    // For the duration of this closure both ChildViewModel and interactor are in held in memory
                    self.interactor.deleteLocalWatchlistItems(["1", "2", "3"], for: "test")
                    print("Value received")
                }
            }
            .store(in: &subscriptions)
    }
    
    func testInteractorStrongCapture() {
        print("Testing interactor strong capture...")
        interactor.deleteWatchlistItems(["1", "2"], for: "test")
            .receive(on: DispatchQueue.main)
            .sink { _ in
                print("Completion received")
            } receiveValue: { [interactor] _ in
                print("Deallocate view")
                DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                    // In this case the interactor will execute the use case, it will be deallocated at scope exit
                    // For the duration of this closure ONLY interactor is held in memory, self is immediately deallocated with view
                    interactor.deleteLocalWatchlistItems(["1", "2", "3"], for: "test")
                    print("Value received")
                }
            }
            .store(in: &subscriptions)
    }
    
    func testWeakCapture() {
        print("Testing weak capture...")
        interactor.deleteWatchlistItems(["1", "2"], for: "test")
            .receive(on: DispatchQueue.main)
            .sink { _ in
                print("Completion received")
            } receiveValue: { [weak self] _ in
                print("Deallocate view")
                DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                    // In this case the interactor will NOT execute the use case, it will be deallocated
                    // with self immedtiately at view deallocation and we will only print "Value Received"
                    self?.interactor.deleteLocalWatchlistItems(["1", "2", "3"], for: "test")
                    print("Value received")
                }
            }
            .store(in: &subscriptions)
    }
}
