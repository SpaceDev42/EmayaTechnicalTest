//
//  MainNavigationRoute.swift
//  EmayaApp
//
//  Created by Vladimir Guevara on 16/4/25.
//

import Foundation
import SwiftUI

// MARK: - Main Navigation Route
enum MainNavigationRoute: NavigationRoute {
    case productsList
}

extension MainNavigationRoute {
    var transition: NavigationTranisitionStyle { .push }

    var mode: UIUserInterfaceStyle { .light }

    var type: NavigationRouteType { .view }

    func getView(coordinator: CoordinatorType) -> (any View)? {
        switch self {
        case .productsList:
            return ProductsListView()
        }
    }
}
