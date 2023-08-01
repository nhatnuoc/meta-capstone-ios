//
//  MenuView.swift
//  meta-ios-capstone
//
//  Created by Nguyễn Thanh Bình on 06/07/2023.
//

import SwiftUI

struct MenuView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        VStack {
            Text("the title of your application")
            Text("Restaurant location")
            Text(" short description of the whole application")
            FetchedObjects { (dishes: [Dish]) in
                List {
                    ForEach(dishes) { dish in
                        HStack {
                            Text("\(dish.title ?? ""): \(dish.price ?? "")")
                            AsyncImage(url: URL(string: dish.image ?? ""))
                                .frame(width: 60, height: 60)
                        }
                    }
                }
            }
        }.onAppear {
            self.getMenuData()
        }
    }
    
    func getMenuData() {
        let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let url = URL(string: urlString)!
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                return
            }
            print(String(data: data, encoding: .utf8))
            guard let menuList = try? JSONDecoder().decode(MenuList.self, from: data) else { return }
            PersistenceController.shared.clear()
            menuList.menu.forEach { menuItem in
                let dish = Dish()
                dish.image = menuItem.image
                dish.price = menuItem.price
                dish.title = menuItem.title
            }
            try? self.viewContext.save()
        }
        task.resume()
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
