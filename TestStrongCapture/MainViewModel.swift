//
//  MainViewModel.swift
//  TestStrongCapture
//
//  Created by Vlad Crisan on 24.02.2025.
//

import Combine
import Foundation

final class MainViewModel: ObservableObject {
    init() {
        print("MainViewModel initialized")
    }

    deinit {
        print("MainViewModel deallocated")
    }

    func makeChildViewModel() -> ChildViewModel {
        let newViewModel = ChildViewModel(interactor: WatchlistInteractor())
        return newViewModel
    }
}
