//
//  HomeView.swift
//  meta-ios-capstone
//
//  Created by Nguyễn Thanh Bình on 06/07/2023.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            MenuView()
                .tabItem {
                    Label {
                        Text("Menu")
                    } icon: {
                        Image(systemName: "list.dash")
                    }

                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
