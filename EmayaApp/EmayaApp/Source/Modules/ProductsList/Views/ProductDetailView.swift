//
//  ProductDetailView.swift
//  EmayaApp
//
//  Created by Vladimir Guevara on 16/4/25.
//

import SwiftUI

struct ProductDetailView: View {
    @Binding var product: Product

     var body: some View {
         ScrollView {
             productImage
             productInformation
         }
         .ignoresSafeArea(edges: .top)
         .navigationTitle(product.title)
         .navigationBarTitleDisplayMode(.inline)
     }

    // MARK: - Product image
    private var productImage: some View {
        ZStack(alignment: .top) {
            AsyncImage(url: URL(string: product.image)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                case .failure(_):
                    Image(systemName: "exclamationmark.triangle")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.red)
                @unknown default:
                    EmptyView()
                }
            }
            .frame(height: 300)
            .clipped()

            favoriteProductButton
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }

    // MARK: - Favorite Product button
    private var favoriteProductButton: some View {
        Button {
            product.isFavorite.toggle()
        } label: {
            Image(systemName: product.isFavorite ? "heart.fill" : "heart")
                .font(.system(size: 25))
                .foregroundColor(.red)
                .padding(8)
                .background(Color.black.opacity(0.1))
                .clipShape(Circle())
        }
        .padding(.top, 16)
        .padding(.trailing, 16)
    }

    // MARK: - Product Information
    private var productInformation: some View {
        VStack(alignment: .leading, spacing: 16) {

            Text(product.category.rawValue.uppercased())
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(.secondary)
                .padding(.top, 8)

            Text(product.title)
                .font(.title2)
                .fontWeight(.bold)
                .fixedSize(horizontal: false, vertical: true)

            HStack(spacing: 4) {
                StarRatingView(rating: product.rating.rate)
                    .font(.system(size: 14))

                Text(String(format: "%.1f", product.rating.rate))
                    .font(.subheadline)
                    .foregroundColor(.primary)

                Text("\(product.rating.count) reviews")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            if product.rating.count > 200 {
                Text("Likely to sell out")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.red)
            }

            Text(String(format: "$%.2f", product.price))
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.blue)

            Text(product.description)
                .font(.body)
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)

            Spacer()
        }
        .padding(.horizontal)
    }
}

#Preview {
    let product = Product(
        id: 1,
        title: "Samsung 49-Inch CHG90 144Hz Curved Gaming Monitor (LC49HG90DMNXZA) – Super Ultrawide Screen QLED",
        price: 999.99,
        description: "49 INCH SUPER ULTRAWIDE 32:9 CURVED GAMING MONITOR with dual 27 inch screen side by side QUANTUM DOT (QLED) TECHNOLOGY, HDR support and factory calibration provides stunningly realistic and accurate color and contrast 144HZ HIGH REFRESH RATE and 1ms ultra fast response time work to eliminate motion blur, ghosting, and reduce input lag",
        category: .electronics,
        image: "https://fakestoreapi.com/img/81Zt42ioCgL._AC_SX679_.jpg",
        rating: .init(rate: 2.2, count: 140)
    )

    ProductDetailView(product: .constant(product))
}
