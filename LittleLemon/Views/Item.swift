//
//  Item.swift
//  LittleLemon
//
//  Created by Nguyen Huu Hung on 8/9/25.
//

import SwiftUI
import CoreData

struct Item: View {
    
    @Binding var dish: Dish
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(dish.name ?? "")
                    .font(.custom("Karla-Bold", size: 18))
                    .foregroundStyle(.black)
                Text(dish.descriptionDish ?? "")
                    .font(.custom("Karla-Regular", size: 16))
                    .foregroundStyle(.primaryGreen)
                Text("$ \(dish.price ?? 0)")
                    .font(.custom("Karla-Medium", size: 16))
                    .foregroundStyle(.primaryGreen)
            }
            AsyncImage(url: URL(string: dish.image ?? "")) { image in
                image
                    .resizable()
                    .frame(width: 83, height: 83)
            } placeholder: {
                ProgressView()
            }
        }
    }
}

#Preview {
    Item(dish: .constant(Dish()))
}
