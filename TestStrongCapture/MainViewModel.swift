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
    
    /// https://forums.swift.org/t/does-assign-to-produce-memory-leaks/29546
    func testAssignToWeakSelf() {
        var bar: Bar? = Bar(testType: .weakSelf)
        let foo = bar?.$output.sink { print($0) }
        bar?.input = "Hello"
        bar = nil
        foo?.cancel()
    }
    
    func testAssignToAssignStrongSelf() {
        var bar: Bar? = Bar(testType: .assignStrongSelf)
        let foo = bar?.$output.sink { print($0) }
        bar?.input = "Hello"
        bar = nil
        foo?.cancel()
    }
    
    func testAssignToWithoutSelf() {
        var bar: Bar? = Bar(testType: .weakSelf)
        let foo = bar?.$output.sink { print($0) }
        bar?.input = "Hello"
        bar = nil
        foo?.cancel()
    }
    
    func makeChildViewModel() -> ChildViewModel {
        if let childViewModel { return childViewModel }
        let newViewModel = ChildViewModel(interactor: WatchlistInteractor())
        childViewModel = newViewModel
        return newViewModel
    }
}
