//
//  HeroSection.swift
//  LittleLemon
//
//  Created by Nguyen Huu Hung on 8/9/25.
//

import SwiftUI

struct HeroSection: View {
    
    @Binding var textSearch: String
    @Binding var isEnableSearch: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .leading) {
                Text("Little Lemon")
                    .font(.custom("MarkaziText-Medium", size: 64))
                    .foregroundStyle(.primaryYellow)
                Text("Chicago")
                    .font(.custom("MarkaziText-Regular", size: 40))
                    .foregroundStyle(.white)
                    .padding(.top, 64)
            }
            
            Spacer(minLength: 0)
            
            HStack {
                Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                    .font(.custom("Karla-Medium", size: 18))
                    .foregroundStyle(.white)
                Image(.pasta)
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 26))
                    .frame(width: 140, height: 140)
            }
            Spacer(minLength: 0)
            
            if isEnableSearch {
                TextField("Search food name", text: $textSearch)
                .padding()
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 20)
        .background(.primaryGreen)
    }
}

#Preview {
    HeroSection(textSearch: .constant(""), isEnableSearch: .constant(true))
        .frame(height: 368)
}
