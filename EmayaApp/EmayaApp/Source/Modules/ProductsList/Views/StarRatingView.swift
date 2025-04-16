//
//  StarRatingView.swift
//  EmayaApp
//
//  Created by Vladimir Guevara on 16/4/25.
//

import SwiftUI

struct StarRatingView: View {
    let rating: Double
    private let maxRating = 5

    var body: some View {
        HStack(spacing: 2) {
            ForEach(1...maxRating, id: \.self) { star in
                Image(systemName: star <= Int(rating.rounded()) ? "star.fill" : "star")
                    .foregroundColor(.yellow)
                    .font(.system(size: 12))
            }
        }
    }
}

#Preview {
    StarRatingView(rating: 2.2)
}
