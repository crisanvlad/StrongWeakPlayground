//
//  Bar.swift
//  TestStrongCapture
//
//  Created by Vlad Crisan on 25.02.2025.
//
import Combine
import Foundation

final class Bar: ObservableObject {
    enum TestType {
        case weakSelf
        case assignStrongSelf
        case assignToWithoutSelf
    }
    
    @Published var input: String = ""
    @Published var output: String = ""
    
    private var subscription: AnyCancellable?
    
    init(testType: TestType) {
        switch testType {
            case .weakSelf:
                subscription = $input
                    .filter { !$0.isEmpty }
                    .map { "\($0) World!" }
                    // Sink [weak self]  will not create a memory leak
                    .sink { [weak self] input in
                        self?.output = input
                    }
            case .assignStrongSelf:
                subscription = $input
                    .filter { !$0.isEmpty }
                    .map { "\($0) World!" }
                    // Assign to(: on: self) will create a strong reference memory leak
                    .assign(to: \.output, on: self)
            case .assignToWithoutSelf:
                $input
                    .filter { !$0.isEmpty }
                    .map { "\($0) World!" }
                    // Assign to(:) will NOT create a memory leak
                    .assign(to: &$output)
        }
    }
    
    deinit {
        subscription?.cancel()
        print("\(self): \(#function)")
    }
}
