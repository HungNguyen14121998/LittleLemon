//
//  UserProfile.swift
//  LittleLemon
//
//  Created by Nguyen Huu Hung on 8/3/25.
//

import SwiftUI

struct UserProfile: View {
    
    let firstName = UserDefaults.standard.string(forKey: kFirstName)
    let lastName = UserDefaults.standard.string(forKey: kLastName)
    let email = UserDefaults.standard.string(forKey: kEmail)
    
    @Environment(\.presentationMode) var presentation
    
    @State var isSelectedButton: Bool = false
    
    @State var isShowAlert: Bool = false
    
    var body: some View {
        VStack {
            // Header
            HStack(alignment: .center) {
                Image(.logo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 180, height: 40)
            }
            // Personal Information
            HStack {
                Text("PERSONAL INFORMATION")
                    .font(.custom("Karla-ExtraBold", size: 20))
                    .foregroundStyle(.black)
                Spacer()
            }
            .padding(.leading, 16)
            // Avatar
            HStack {
                Text("Avatar")
                    .font(.custom("Karla-Bold", size: 18))
                    .foregroundStyle(.primaryGreen)
                Spacer()
            }
            .padding(.leading, 16)
            
            HStack {
                Image(.profileImagePlaceholder)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(.trailing, 24)
                
                Button(action: {}, label: {
                    Text("Change")
                        .frame(width: 115, height: 40)
                        .foregroundStyle(.white)
                        .background(.primaryGreen)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                })
                .padding(.trailing, 24)
                
                Button(action: {}, label: {
                    Text("Remove")
                        .frame(width: 115, height: 40)
                        .foregroundStyle(.primaryGreen)
                        .background(.white)
                        .overlay(content: {
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(.primaryGreen, lineWidth: 1)
                        })
                })
                .padding(.trailing, 24)
            }
            .padding(.leading, 16)
            
            ScrollView {
                VStack(alignment: .leading) {
                    Text("First name")
                        .font(.custom("Karla-Bold", size: 18))
                        .foregroundStyle(.primaryGreen)
                    HStack {
                        Text(firstName ?? "")
                            .foregroundStyle(.primaryGreen)
                            .background(.white)
                            .padding(.leading, 12)
                        Spacer()
                    }
                    .frame(width: UIScreen.main.bounds.size.width - 32, height: 51)
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(.primaryGreen, lineWidth: 1)
                    })
                    .padding(.bottom, 12)
                    
                    Text("Last name")
                        .font(.custom("Karla-Bold", size: 18))
                        .foregroundStyle(.primaryGreen)
                    HStack {
                        Text(lastName ?? "")
                            .foregroundStyle(.primaryGreen)
                            .background(.white)
                            .padding(.leading, 12)
                        Spacer()
                    }
                    .frame(width: UIScreen.main.bounds.size.width - 32, height: 51)
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(.primaryGreen, lineWidth: 1)
                    })
                    .padding(.bottom, 12)
                    
                    Text("Email")
                        .font(.custom("Karla-Bold", size: 18))
                        .foregroundStyle(.primaryGreen)
                    HStack {
                        Text(email ?? "")
                            .foregroundStyle(.primaryGreen)
                            .background(.white)
                            .padding(.leading, 12)
                        Spacer()
                    }
                    .frame(width: UIScreen.main.bounds.size.width - 32, height: 51)
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(.primaryGreen, lineWidth: 1)
                    })
                    .padding(.bottom, 12)
                }
                .padding()
            }
            
            
            // Logout button
            ZStack {
                Button(action: {
                    isShowAlert = true
                }, label: {
                    Text("Log out")
                        .font(.custom("Karla-Bold", size: 20))
                        .foregroundStyle(isSelectedButton ? .primaryYellow : .primaryGreen)
                        .frame(width: UIScreen.main.bounds.size.width - 32, height: 50)
                        .background(isSelectedButton ? .primaryGreen : .primaryYellow)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                })
                .buttonStyle(.plain)
                .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity,
                                    pressing: { isPressing in
                    isSelectedButton = isPressing
                    if isPressing {
                        isSelectedButton = true
                    } else {
                        isSelectedButton = false
                    }
                }, perform: {
                    isSelectedButton = false
                })
            }
            .frame(height: 52)
            .padding(.bottom, 16)
        }.overlay(alignment: .topTrailing, content: {
            Image(.profileImagePlaceholder)
                .resizable()
                .frame(width: 40, height: 40)
                .padding(.trailing, 16)
        })
        .alert("Do you want to log out?",
               isPresented: $isShowAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Logout", role: .destructive) {
                UserDefaults.standard.setValue(false, forKey: kIsLoggedIn)
                self.presentation.wrappedValue.dismiss()
            }
        }
    }
}

#Preview {
    UserProfile()
}
