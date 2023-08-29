//
//  UserProfileView.swift
//  meta-ios-capstone
//
//  Created by Nguyễn Thanh Bình on 28/07/2023.
//

import SwiftUI

extension ToggleStyle where Self == CheckBoxToggleStyle {

    static var checkBox: CheckBoxToggleStyle {
        return CheckBoxToggleStyle()
    }
}

// Custom Toggle Style
struct CheckBoxToggleStyle: ToggleStyle {

    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            Label {
                configuration.label
            } icon: {
                Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                    .foregroundColor(configuration.isOn ? .accentColor : .secondary)
                    .accessibility(label: Text(configuration.isOn ? "Checked" : "Unchecked"))
                    .imageScale(.large)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct UserProfileView: View {
    @State var firstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
    @State var lastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
    @State var email = UserDefaults.standard.string(forKey: kEmail) ?? ""
    @State var phoneNumber = UserDefaults.standard.string(forKey: kPhoneNumber) ?? ""
    @State var orderStatuses: Bool = UserDefaults.standard.bool(forKey: kOrderStatuses)
    @State var passwordChanged = UserDefaults.standard.bool(forKey: kPasswordChanged)
    @State var specialOffers = UserDefaults.standard.bool(forKey: kSpecialOffers)
    @State var newsletter = UserDefaults.standard.bool(forKey: kNewsletter)
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Personal information")
            Image("profile-image-placeholder")
            InputTextForm(text: self.$firstName, textLabel: "First Name")
            InputTextForm(text: self.$lastName, textLabel: "Last Name")
            InputTextForm(text: self.$email, textLabel: "Email")
            InputTextForm(text: self.$phoneNumber, textLabel: "Phone Number")
            VStack(alignment: .leading) {
                Toggle("Order statuses", isOn: self.$orderStatuses)
                    .toggleStyle(.checkBox)
                Toggle("Password changes", isOn: self.$passwordChanged)
                    .toggleStyle(.checkBox)
                Toggle("Special offers", isOn: self.$specialOffers)
                    .toggleStyle(.checkBox)
                Toggle("Newsletter", isOn: self.$newsletter)
                    .toggleStyle(.checkBox)
            }
            VStack(alignment: .center) {
                Button {
                    UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                    UserDefaults.standard.set(nil, forKey: kFirstName)
                    UserDefaults.standard.set(nil, forKey: kLastName)
                    UserDefaults.standard.set(nil, forKey: kEmail)
                    UserDefaults.standard.set(nil, forKey: kPhoneNumber)
                    UserDefaults.standard.set(false, forKey: kOrderStatuses)
                    UserDefaults.standard.set(false, forKey: kPasswordChanged)
                    UserDefaults.standard.set(false, forKey: kSpecialOffers)
                    UserDefaults.standard.set(false, forKey: kNewsletter)
                    self.presentation.wrappedValue.dismiss()
                } label: {
                    Text("Log out")
                }
                .padding()
                .foregroundColor(Color("color_green"))
                .background(.yellow)
                .cornerRadius(10)
                .fontWeight(.bold)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("color_green"))
                }
                HStack(alignment: .center) {
                    Button {
                        self.setupInitialData()
                    } label: {
                        Text("Discard changes")
                    }
                    .border(.background, width: 1)
                    .buttonBorderShape(.roundedRectangle(radius: 10))
                    
                    .padding()
                    .foregroundColor(.init("color_green"))
                    .background(.white)
                    .cornerRadius(10)
                    .fontWeight(.bold)
                    .overlay(
                            RoundedRectangle(cornerRadius: 10).stroke(Color("color_green"), lineWidth: 2)
                        )
                    
                    Button {
                        UserDefaults.standard.set(self.firstName, forKey: kFirstName)
                        UserDefaults.standard.set(self.lastName, forKey: kLastName)
                        UserDefaults.standard.set(self.email, forKey: kEmail)
                        UserDefaults.standard.set(self.phoneNumber, forKey: kPhoneNumber)
                        UserDefaults.standard.set(self.orderStatuses, forKey: kOrderStatuses)
                        UserDefaults.standard.set(self.passwordChanged, forKey: kPasswordChanged)
                        UserDefaults.standard.set(self.specialOffers, forKey: kSpecialOffers)
                        UserDefaults.standard.set(self.newsletter, forKey: kNewsletter)
                        self.presentation.wrappedValue.dismiss()
                    } label: {
                        Text("Save changes")
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color("color_green"))
                    .cornerRadius(10)
                    .fontWeight(.bold)
                }
            }
            Spacer()
        }.toolbar {
            ToolbarItem(placement: .principal, content: {
                Image("logo")
            })
            ToolbarItem(placement: .navigationBarTrailing, content: {
                Image("profile-image-placeholder")
            })
        }.onAppear(perform: {
            self.setupInitialData()
        })
//        .fixedSize(horizontal: true, vertical: false)
        .frame(maxWidth: .infinity)
    }
    
    func setupInitialData() {
        self.firstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
        self.lastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
        self.email = UserDefaults.standard.string(forKey: kEmail) ?? ""
        self.phoneNumber = UserDefaults.standard.string(forKey: kPhoneNumber) ?? ""
        self.orderStatuses = UserDefaults.standard.bool(forKey: kOrderStatuses)
        self.passwordChanged = UserDefaults.standard.bool(forKey: kPasswordChanged)
        self.specialOffers = UserDefaults.standard.bool(forKey: kSpecialOffers)
        self.newsletter = UserDefaults.standard.bool(forKey: kNewsletter)
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
