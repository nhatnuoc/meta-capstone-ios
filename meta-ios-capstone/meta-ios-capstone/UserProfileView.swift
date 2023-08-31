//
//  UserProfileView.swift
//  meta-ios-capstone
//
//  Created by Nguyễn Thanh Bình on 28/07/2023.
//

import SwiftUI
import PhotosUI

extension ToggleStyle where Self == CheckBoxToggleStyle {

    static var checkBox: CheckBoxToggleStyle {
        return CheckBoxToggleStyle()
    }
}

let colorPrimary = Color("color_primary")
let colorSecondary = Color("color_secondary")

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
                    .foregroundColor(configuration.isOn ? colorPrimary : .secondary)
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
    @State var avatar: Data?
    @State var avatarSelectedItem: PhotosPickerItem?
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var viewContext
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Personal information")
                HStack {
                    AvatarView(avatar: self.$avatar)
//                        .resizable()
                        .frame(width: 80, height: 80)
                        .padding(.horizontal)
                        .clipShape(Circle())
                    Button("Remove", action: {
                        self.avatar = nil
                        self.avatarSelectedItem = nil
                    })
                    .border(.background, width: 1)
                    .buttonBorderShape(.roundedRectangle(radius: 10))
                    .padding()
                    .foregroundColor(.init("color_primary"))
                    .background(.white)
                    .cornerRadius(10)
                    .fontWeight(.bold)
                    .overlay(
                            RoundedRectangle(cornerRadius: 10).stroke(colorPrimary, lineWidth: 2)
                        )
                    PhotosPicker(selection: $avatarSelectedItem, matching: .images) {
                        Text("Change")
                            .padding()
                            .background(colorPrimary)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .foregroundColor(.white)
                    }.onChange(of: self.avatarSelectedItem) { newValue in
                        newValue?.loadTransferable(type: Data.self, completionHandler: { result in
                            self.avatar = try? result.get()
                        })
                    }
                }
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
                }.padding(.vertical)
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
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(colorPrimary)
                    .background(colorSecondary)
                    .cornerRadius(10)
                    .fontWeight(.bold)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(colorPrimary)
                    }
                    HStack(alignment: .center) {
                        Button {
                            self.setupInitialData()
                        } label: {
                            Text("Discard changes")
                        }
                        .border(.background, width: 1)
                        .buttonBorderShape(.roundedRectangle(radius: 10))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.init("color_primary"))
                        .background(.white)
                        .cornerRadius(10)
                        .fontWeight(.bold)
                        .overlay(
                                RoundedRectangle(cornerRadius: 10).stroke(colorPrimary, lineWidth: 2)
                            )
                        
                        Button {
//                            UserDefaults.standard.set(self.firstName, forKey: kFirstName)
//                            UserDefaults.standard.set(self.lastName, forKey: kLastName)
//                            UserDefaults.standard.set(self.email, forKey: kEmail)
//                            UserDefaults.standard.set(self.phoneNumber, forKey: kPhoneNumber)
                            UserDefaults.standard.set(self.orderStatuses, forKey: kOrderStatuses)
                            UserDefaults.standard.set(self.passwordChanged, forKey: kPasswordChanged)
                            UserDefaults.standard.set(self.specialOffers, forKey: kSpecialOffers)
                            UserDefaults.standard.set(self.newsletter, forKey: kNewsletter)
//                            UserDefaults.standard.set(self.avatar, forKey: kAvatar)
                            let user = try? self.viewContext.fetch(UserProfile.fetchRequest()).first
                            user?.firstName = self.firstName
                            user?.lastName = self.lastName
                            user?.email = self.email
                            user?.phoneNumber = self.phoneNumber
                            user?.avatar = self.avatar
                            self.presentation.wrappedValue.dismiss()
                        } label: {
                            Text("Save changes")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(colorPrimary)
                        .cornerRadius(10)
                        .fontWeight(.bold)
                    }
                    .padding(.vertical)
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
            .padding()
        }
    }
    
    func setupInitialData() {
//        self.firstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
//        self.lastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
//        self.email = UserDefaults.standard.string(forKey: kEmail) ?? ""
//        self.phoneNumber = UserDefaults.standard.string(forKey: kPhoneNumber) ?? ""
//        self.orderStatuses = UserDefaults.standard.bool(forKey: kOrderStatuses)
//        self.passwordChanged = UserDefaults.standard.bool(forKey: kPasswordChanged)
//        self.specialOffers = UserDefaults.standard.bool(forKey: kSpecialOffers)
//        self.newsletter = UserDefaults.standard.bool(forKey: kNewsletter)
//        self.avatar = UserDefaults.standard.data(forKey: kAvatar)
        let user = try? self.viewContext.fetch(UserProfile.fetchRequest()).first
        self.firstName = user?.firstName ?? ""
        self.lastName = user?.lastName ?? ""
        self.email = user?.email ?? ""
        self.phoneNumber = user?.phoneNumber ?? ""
        self.avatar = user?.avatar
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

struct AvatarView: View {
    @Binding var avatar: Data?
    
    var body: some View {
//        (
//            self.avatar != nil ? Image(uiImage: UIImage(data: self.avatar!)!) : Image("profile-image-placeholder")
//        )
//        .resizable()
//        .onAppear {
//            self.avatar = UserDefaults.standard.data(forKey: kAvatar)
//        }
        FetchedObjects { (users: [UserProfile]) in
            if let dt = self.avatar {
                Image(uiImage: UIImage(data: dt)!)
                    .resizable()
            } else if let dt = users.first?.avatar {
                Image(uiImage: UIImage(data: dt)!)
                    .resizable()
            } else {
                Image("profile-image-placeholder")
                    .resizable()
            }
//            (
                
//                users.first?.avatar != nil ? Image(uiImage: UIImage(data: (users.first?.avatar)!)!) : Image("profile-image-placeholder")
//            )
            
        }
    }
}
