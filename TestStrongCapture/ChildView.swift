//
//  ChildView.swift
//  TestStrongCapture
//
//  Created by Vlad Crisan on 24.02.2025.
//

import SwiftUI

struct ChildView: View {
    @ObservedObject private var viewModel: ChildViewModel

    init(viewModel: ChildViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(spacing: 50) {
            Button("Test Self Strong Capture") {
                viewModel.testSelfStrongCapture()
            }

            Button("Test Interactor Strong Capture") {
                viewModel.testInteractorStrongCapture()
            }

            Button("Test Weak Capture") {
                viewModel.testWeakCapture()
            }
        }
    }
}
