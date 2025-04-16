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
            VStack {
                categoriesMenu
                productsList
            }
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.light, for: .navigationBar)
            .navigationTitle("Products")
            .navigationBarTitleDisplayMode(.automatic)
            .searchable(text: $viewModel.productSearch)
            .sheet(isPresented: $viewModel.isPresentingProductDetail) {
                ProductDetailView(product: $viewModel.selectedProduct)
            }
        }
    }

    // MARK: - Category Picker
    private var categoriesMenu: some View {
        Menu {
            ForEach(Category.allCases, id: \.rawValue) { category in
                Button(category.rawValue) { viewModel.selectCategory(category) }
            }
        } label: {
            HStack {
                Text(viewModel.selectedCategory?.rawValue ?? "Categories")
                    .foregroundColor(.primary)

                Spacer()

                Image(systemName: "chevron.down")
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)
            .frame(height: 44)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.5))
                    .background(Color(.systemBackground))
            )
            .padding([.top, .horizontal])
        }
    }

    // MARK: - Products List
    private var productsList: some View {
        ScrollView {
            LazyVStack {
                ForEach($viewModel.filteredProducts, id: \.id) { product in
                    ProductCardView(product: product)
                        .onTapGesture {
                            viewModel.presentProduct(product.wrappedValue)
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
