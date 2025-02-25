//
//  MainView.swift
//  TestStrongCapture
//
//  Created by Vlad Crisan on 24.02.2025.
//

import SwiftUI

struct MainView: View {
    enum Destinations {
        case child
    }
    
    @State private var isPresented: Bool = false
    @State private var destinations: [Destinations] = []
    @StateObject private var viewModel: MainViewModel = .init()
    
    var body: some View {
        NavigationStack(path: $destinations) {
            VStack(spacing: 30) {
                Button("Open Modal") {
                    isPresented.toggle()
                }
                Button("Push Child") {
                    destinations.append(.child)
                }
                
                Button("Test Assign To Weak Self") {
                    viewModel.testAssignToWeakSelf()
                }
                
                Button("Test Assign To Strong Self") {
                    viewModel.testAssignToAssignStrongSelf()
                }
                
                Button("Test Assign To Without Self") {
                    viewModel.testAssignToWithoutSelf()
                }
            }
            .navigationDestination(for: Destinations.self) { _ in
                ChildView(viewModel: viewModel.makeChildViewModel())
                    .onDisappear {
                        viewModel.handleOnDisappear()
                    }
            }
        }
        .padding()
        .sheet(isPresented: $isPresented) {
            ChildView(viewModel: viewModel.makeChildViewModel())
                .onDisappear {
                    viewModel.handleOnDisappear()
                }
        }
    }
}

#Preview {
    MainView()
}
