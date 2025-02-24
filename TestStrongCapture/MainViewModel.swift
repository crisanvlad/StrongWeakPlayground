//
//  MainViewModel.swift
//  TestStrongCapture
//
//  Created by Vlad Crisan on 24.02.2025.
//

import Combine
import Foundation

final class MainViewModel: ObservableObject {
    private var childViewModel: ChildViewModel?
    init() {
        print("MainViewModel initialized")
    }

    deinit {
        print("MainViewModel deallocated")
    }
    
    func handleOnDisappear() {
        childViewModel = nil
    }

    func makeChildViewModel() -> ChildViewModel {
        if let childViewModel { return childViewModel }
        let newViewModel = ChildViewModel(interactor: WatchlistInteractor())
        childViewModel = newViewModel
        return newViewModel
    }
}
