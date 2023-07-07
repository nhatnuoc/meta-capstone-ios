//
//  ContentView.swift
//  meta-ios-capstone
//
//  Created by Nguyễn Thanh Bình on 05/07/2023.
//

import SwiftUI

struct OnboardingView: View {
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var isLoggedIn = false
    let kFirstName = "kFirstName"
    let kLastName = "kLastName"
    let kEmail = "kEmail"
    
    var body: some View {
        NavigationView(content: {
            VStack {
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                TextField("Email", text: $email)
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
                } label: {
                    Text("Register")
                }

            }
        })
        .padding()
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
