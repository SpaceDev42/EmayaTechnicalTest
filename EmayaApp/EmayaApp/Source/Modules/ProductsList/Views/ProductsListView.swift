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
            productsList
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarColorScheme(.light, for: .navigationBar)
                .navigationTitle("Products")
                .navigationBarTitleDisplayMode(.automatic)
                .searchable(text: $viewModel.productSearch)
                .sheet(isPresented: $viewModel.isPresentingProductDetail) {
                    Color.blue.ignoresSafeArea()
                }
        }
    }

    // MARK: - Products List
    private var productsList: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.filteredProducts, id: \.id) { product in
                    ProductCardView(product: product)
                        .onTapGesture {
                            viewModel.isPresentingProductDetail = true
                        }
                }
            }
            .padding(.vertical)
        }
        .colorScheme(.light)
    }
}

#Preview {
    ProductsListView()
}
