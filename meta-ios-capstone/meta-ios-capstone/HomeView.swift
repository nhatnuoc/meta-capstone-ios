//
//  HomeView.swift
//  meta-ios-capstone
//
//  Created by Nguyễn Thanh Bình on 06/07/2023.
//

import SwiftUI

struct HomeView: View {
    let persistence = PersistenceController.shared
    
    var body: some View {
        TabView {
            MenuView()
                .tabItem {
                    Label {
                        Text("Menu")
                    } icon: {
                        Image(systemName: "list.dash")
                    }

                }.environment(\.managedObjectContext, persistence.container.viewContext)
            UserProfileView()
                .tabItem {
                    Label {
                        Text("Profile")
                    } icon: {
                        Image(systemName: "square.and.pencil")
                    }

                }
        }.navigationBarBackButtonHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
