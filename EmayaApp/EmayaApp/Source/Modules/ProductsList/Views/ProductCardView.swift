//
//  ProductCardView.swift
//  EmayaApp
//
//  Created by Vladimir Guevara on 16/4/25.
//

import SwiftUI

struct ProductCardView: View {
    @State var product: Product

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            productImage

            VStack(alignment: .leading, spacing: 4) {
                productName
                ratingAndPrice
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        )
        .padding(.horizontal)
    }

    // MARK: - Product Image
    private var productImage: some View {
        AsyncImage(url: URL(string: product.image)) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFill()
            } else if phase.error != nil {
                Image(systemName: "exclamationmark.triangle")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.red)
            } else {
                ProgressView()
            }
        }
        .frame(width: 69, height: 80)
        .clipped()
        .cornerRadius(8)
    }

    // MARK: - Product Name
    private var productName: some View {
        HStack(alignment: .top) {
            Text(product.title)
                .font(.headline)
                .lineLimit(2)

            Spacer()

            Button(action: {
                product.isFavorite.toggle()
            }) {
                Image(systemName: product.isFavorite ? "heart.fill" : "heart")
                    .foregroundColor(.red)
            }
        }
    }

    // MARK: - Rating And Price
    private var ratingAndPrice: some View {
        VStack(alignment: .leading, spacing: 4) {
            StarRatingView(rating: product.rating.rate)
            Text(String(format: "$%.2f", product.price))
                .font(.title3)
                .fontWeight(.semibold)
        }
        .padding(.top, 4)
    }

    /// Según la categoría, podrías retornar un icono diferente.
    private func iconForCategory(_ category: Category) -> String {
        switch category {
        case .mensClothing:
            return "tshirt"
        case .womensClothing:
            return "figure.dress.line.vertical.figure"
        case .jewelery:
            return "heart.circle"
        case .electronics:
            return "ipad"
        }
    }
}

#Preview {
    ProductCardView(product: .init(
        id: 1,
        title: "Samsung 49-Inch CHG90 144Hz Curved Gaming Monitor (LC49HG90DMNXZA) – Super Ultrawide Screen QLED",
        price: 999.99,
        description: "49 INCH SUPER ULTRAWIDE 32:9 CURVED GAMING MONITOR with dual 27 inch screen side by side QUANTUM DOT (QLED) TECHNOLOGY, HDR support and factory calibration provides stunningly realistic and accurate color and contrast 144HZ HIGH REFRESH RATE and 1ms ultra fast response time work to eliminate motion blur, ghosting, and reduce input lag",
        category: .electronics,
        image: "https://fakestoreapi.com/img/81Zt42ioCgL._AC_SX679_.jpg",
        rating: .init(rate: 2.2, count: 140))
    )
}
