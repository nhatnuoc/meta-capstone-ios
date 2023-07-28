//
//  UserProfileView.swift
//  meta-ios-capstone
//
//  Created by Nguyễn Thanh Bình on 28/07/2023.
//

import SwiftUI

struct UserProfileView: View {
    let firstName = UserDefaults.standard.string(forKey: kFirstName)
    let lastName = UserDefaults.standard.string(forKey: kLastName)
    let email = UserDefaults.standard.string(forKey: kEmail)
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack {
            Text("Personal information")
            Image("profile-image-placeholder")
            Text(firstName ?? "")
            Text(lastName ?? "")
            Text(email ?? "")
            Button {
                
            } label: {
                Text("Log out")
            }

        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
