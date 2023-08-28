//
//  ContentView.swift
//  meta-ios-capstone
//
//  Created by Nguyễn Thanh Bình on 05/07/2023.
//

import SwiftUI

let kFirstName = "kFirstName"
let kLastName = "kLastName"
let kEmail = "kEmail"
let kPhoneNumber = "kPhoneNumber"
let kIsLoggedIn = "kIsLoggedIn"

struct OnboardingView: View {
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var isLoggedIn = false
    
    var body: some View {
        NavigationView(content: {
            VStack {
                VStack(alignment: .leading) {
                    Text("Little Lemon")
                        .font(.system(size: 32, weight: .semibold))
                        .foregroundColor(.yellow)
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Chicago")
                                .font(.system(size: 30, weight: .semibold))
                                .foregroundColor(.white)
                            Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                                .font(.system(size: 22, weight: .semibold))
                                .foregroundColor(.white)
                        }
                        Image("Hero_image")
                            .resizable()
                            .cornerRadius(12)
                            
                    }
                }.padding(12).background(.green)
                InputTextForm(text: $firstName, textLabel: "First Name")
                    .padding(.vertical)
                InputTextForm(text: $lastName, textLabel: "Last Name")
                    .padding(.vertical)
                InputTextForm(text: $email, textLabel: "Email")
                    .padding(.vertical)
                NavigationLink(isActive: $isLoggedIn) {
                    HomeView()
                } label: {
                    EmptyView()
                }

                Button {
                    if firstName.isEmpty {
                        return
                    }
                    if lastName.isEmpty {
                        return
                    }
                    if email.isEmpty {
                        return
                    }
                    UserDefaults.standard.set(firstName, forKey: kFirstName)
                    UserDefaults.standard.set(lastName, forKey: kLastName)
                    UserDefaults.standard.set(email, forKey: kEmail)
                    UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                    isLoggedIn = true
                } label: {
                    Text("Register")
                }.padding(.vertical)
                Spacer()
            }.onAppear(perform: {
                self.isLoggedIn = UserDefaults.standard.bool(forKey: kIsLoggedIn)
            })
            .toolbar {
                ToolbarItem(placement: .principal, content: {
                    Image("logo")
                })
            }
        })
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}

struct InputTextForm: View {
    @Binding var text: String
    var textLabel: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(self.textLabel)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
            TextField(self.textLabel, text: $text, prompt: Text(self.textLabel))
                .textFieldStyle(.roundedBorder)
        }.padding(.horizontal)
    }
}
