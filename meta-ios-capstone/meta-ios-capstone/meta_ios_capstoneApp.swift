//
//  meta_ios_capstoneApp.swift
//  meta-ios-capstone
//
//  Created by Nguyễn Thanh Bình on 05/07/2023.
//

import SwiftUI

@main
struct meta_ios_capstoneApp: App {
    var body: some Scene {
        WindowGroup {
            
        }
    }
}

struct MainView: View {
    var body: some View {
        OnboardingView()
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
