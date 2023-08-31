//
//  HomeView.swift
//  meta-ios-capstone
//
//  Created by Nguyễn Thanh Bình on 06/07/2023.
//

import SwiftUI

let kTabMenu = "kTabMenu"
let kTabUserProfile = "kTabUserProfile"

struct HomeView: View {
    let persistence = PersistenceController.shared
    @State var selectedTab = kTabMenu
    
    var body: some View {
        TabView(selection: self.$selectedTab) {
            NavigationStack(root: {
                MenuView(selectedTab: self.$selectedTab)
            })
                .tabItem {
                    Label {
                        Text("Menu")
                    } icon: {
                        Image(systemName: "list.dash")
                    }

                }.environment(\.managedObjectContext, persistence.container.viewContext)
                .tag(kTabMenu)
            NavigationStack(root: {
                UserProfileView()
                    .environment(\.managedObjectContext, persistence.container.viewContext)
            })
                .tabItem {
                    Label {
                        Text("Profile")
                    } icon: {
                        Image(systemName: "square.and.pencil")
                    }

                }.tag(kTabUserProfile)
        }.navigationBarBackButtonHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
