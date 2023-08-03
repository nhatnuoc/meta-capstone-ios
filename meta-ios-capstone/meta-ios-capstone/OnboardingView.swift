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
let kIsLoggedIn = "kIsLoggedIn"

struct OnboardingView: View {
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var isLoggedIn = false
    
    var body: some View {
        NavigationView(content: {
            VStack {
                Text("First Name")
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                
                LabeledContent("Email") {
                    TextField("Email", text: $email, prompt: Text("Email"))
                }
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
                }

            }.onAppear(perform: {
                self.isLoggedIn = UserDefaults.standard.bool(forKey: kIsLoggedIn)
            })
        })
        .padding()
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}

struct InputTextForm: View {
    @State var text: String
    
    var body: some View {
        VStack {
            Text("Email")
            TextField("Email", text: $text, prompt: Text("Email"))
        }
    }
}
