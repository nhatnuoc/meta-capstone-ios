//
//  UserProfileView.swift
//  meta-ios-capstone
//
//  Created by Nguyễn Thanh Bình on 28/07/2023.
//

import SwiftUI

struct UserProfileView: View {
    @State var firstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
    @State var lastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
    @State var email = UserDefaults.standard.string(forKey: kEmail) ?? ""
    @State var phoneNumber = UserDefaults.standard.string(forKey: kPhoneNumber) ?? ""
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack {
            Text("Personal information")
            Image("profile-image-placeholder")
            InputTextForm(text: $firstName, textLabel: "First Name")
            InputTextForm(text: $lastName, textLabel: "Last Name")
            InputTextForm(text: $email, textLabel: "Email")
            InputTextForm(text: $phoneNumber, textLabel: "Phone Number")
            Button {
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                self.presentation.wrappedValue.dismiss()
            } label: {
                Text("Log out")
            }
            Spacer()
        }.toolbar {
            ToolbarItem(placement: .principal, content: {
                Image("logo")
            })
            ToolbarItem(placement: .navigationBarTrailing, content: {
                Image("profile-image-placeholder")
            })
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
