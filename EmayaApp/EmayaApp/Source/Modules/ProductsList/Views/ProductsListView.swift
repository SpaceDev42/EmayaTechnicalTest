//
//  ProductsListView.swift
//  EmayaApp
//
//  Created by Vladimir Guevara on 15/4/25.
//

import SwiftUI

struct ProductsListView: View {
    @StateObject private var viewModel = ProductListViewModel(dependencies: ProductsListViewModelDependencies())
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Spacer()
                    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                    Spacer()
                }
            }
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.mint, for: .navigationBar)
            .navigationTitle("Products")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $viewModel.productSearch)
        }
    }
}

#Preview {
    ProductsListView()
}
