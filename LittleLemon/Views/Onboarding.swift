//
//  Onboarding.swift
//  LittleLemon
//
//  Created by Nguyen Huu Hung on 8/3/25.
//

import SwiftUI

let kFirstName = "first name key"
let kLastName  = "last name key"
let kEmail     = "email key"

let kIsLoggedIn = "kIsLoggedIn"

struct Onboarding: View {
    
    @State var isLoggedIn: Bool = false
    
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    
    @State var isShowError: Bool = false
    @State var textError: String = ""
    
    @State var isSelectedButton: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                    EmptyView()
                }
                // Header
                HStack {
                    Image(.logo)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 180, height: 40)
                }
                // Hero Section
                HeroSection(textSearch: .constant(""), isEnableSearch: .constant(false))
                    .frame(width: UIScreen.main.bounds.size.width + 32, height: 295)
                ScrollView {
                    // Form
                    VStack(alignment: .leading) {   
                        HStack {
                            Text("USER INFORMATION")
                                .font(.custom("Karla-ExtraBold", size: 20))
                                .foregroundStyle(.black)
                            Spacer()
                        }
                        .padding(.bottom, 12)
                        
                        Text("First name")
                            .font(.custom("Karla-Bold", size: 18))
                            .foregroundStyle(.primaryGreen)
                        TextField(kFirstName, text: $firstName)
                            .padding()
                            .background(.highlightGray)
                            .overlay(content: {
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(.primaryGreen, lineWidth: 1)
                            })
                        
                        Text("Last name")
                            .font(.custom("Karla-Bold", size: 18))
                            .foregroundStyle(.primaryGreen)
                        TextField(kLastName, text: $lastName)
                            .padding()
                            .background(.highlightGray)
                            .overlay(content: {
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(.primaryGreen, lineWidth: 1)
                            })
                        
                        Text("Email")
                            .font(.custom("Karla-Bold", size: 18))
                        TextField(kEmail, text: $email)
                            .padding()
                            .background(.highlightGray)
                            .overlay(content: {
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(.primaryGreen, lineWidth: 1)
                            })
                    }
                    .padding()
                }
                
                // Register button
                ZStack {
                    Button(action: {
                        
                        if firstName.isEmpty || firstName.count < 3 {
                            textError = "Firstname invalid"
                            isShowError = true
                            return
                        }
                        
                        if lastName.isEmpty || lastName.count < 3 {
                            textError = "Lastname invalid"
                            isShowError = true
                            return
                        }
                        
                        if email.isEmpty || !isValid(email: email) {
                            textError = "Email invalid"
                            isShowError = true
                            return
                        }
                        
                        UserDefaults.standard.setValue(firstName, forKey: kFirstName)
                        UserDefaults.standard.setValue(lastName, forKey: kLastName)
                        UserDefaults.standard.setValue(email, forKey: kEmail)
                        UserDefaults.standard.setValue(true, forKey: kIsLoggedIn)
                        isLoggedIn = true
                        
                    }, label: {
                        Text("Next")
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
                
            }
            .alert(textError,
                   isPresented: $isShowError) {
                Button("OK", role: .cancel) { }
            }
            .onAppear {
                if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                    isLoggedIn = true
                }
            }
        }
    }
    
    func isValid(email:String) -> Bool {
        guard !email.isEmpty else { return false }
        let emailValidationRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"
        let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)
        return emailValidationPredicate.evaluate(with: email)
    }
}

#Preview {
    Onboarding()
}
