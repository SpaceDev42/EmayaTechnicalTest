//
//  MainCoordinator.swift
//  EmayaApp
//
//  Created by Vladimir Guevara on 16/4/25.
//

import Foundation
import SwiftUI

// MARK: Main Coordinator Type
protocol MainCoordinatorType: CoordinatorType {
    func presentProductsList()
}

// MARK: - App Main Coordinator
class MainCoordinator: ObservableObject, MainCoordinatorType {
    
    var navigationController: UINavigationController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        presentProductsList()
    }

    func presentProductsList() {
        show(route: .productsList)
    }

    // MARK: - Convenience Show Method
    private func show(route: MainNavigationRoute) {
        show(route: route, animated: true)
    }
}
