//
//  NavigationRoute.swift
//  EmayaApp
//
//  Created by Vladimir Guevara on 15/4/25.
//

import Foundation
import SwiftUI

// MARK: - NavigationRouter Protocol
protocol NavigationRoute {
    /// A route's transition style. Note: If the route's type is "coordinator", this property will be replaced by the coordinator's starting route's transition style.
    var transition: NavigationTranisitionStyle { get }
    /// A route's interface style.
    var mode: UIUserInterfaceStyle { get }
    /// A route's type. Possible values: view (presents a view withing the same coordinator) or coordinator (pushes a coordinator's starting route into the navigation stack).
    var type: NavigationRouteType { get }
    /// A route's coordinator. This property should be nil if the route's type is "view".
    var coordinator: CoordinatorType? { get }
    /// A route's view. This property should be nil if the route's type is "coordinator".
    func getView(coordinator: CoordinatorType) -> (any View)?
}

extension NavigationRoute {
    var coordinator: CoordinatorType? { nil }
}

// MARK: - NavigationRouteType Enum
enum NavigationRouteType {
    case view
    case coordinator
}

// MARK: - Navigation Transition Style
enum NavigationTranisitionStyle {
    case push
    case presentModal
    case fullScreen
}
