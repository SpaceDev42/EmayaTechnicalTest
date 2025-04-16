//
//  ProductsTarget.swift
//  EmayaApp
//
//  Created by Vladimir Guevara on 15/4/25.
//

import Foundation

enum ProductsTarget: EmayaServicesTargetType {
    case products
}

extension ProductsTarget {
    var method: RequestMethod { .get }

    var path: String { "/products" }

    var parameters: [String : Any]? { nil }
}
