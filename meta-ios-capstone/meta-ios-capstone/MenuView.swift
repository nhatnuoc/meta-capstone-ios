//
//  MenuView.swift
//  meta-ios-capstone
//
//  Created by Nguyễn Thanh Bình on 06/07/2023.
//

import SwiftUI

struct MenuView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var searchText: String = ""
    @Binding var selectedTab: String
    @State var categories: [String] = []
    
    var body: some View {
        VStack {
            FetchedObjects(
                predicate: buildPredicate(),
                sortDescriptors: buildSortDescriptors(),
                content: { (dishes: [Dish]) in
                    List {
                        VStack(alignment: .leading) {
                            Text("Little Lemon")
                                .font(.system(size: 32, weight: .semibold))
                                .foregroundColor(.yellow)
                            HStack(alignment: .top) {
                                VStack(alignment: .leading) {
                                    Text("Chicago")
                                        .font(.system(size: 30, weight: .semibold))
                                        .foregroundColor(.white)
                                    Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                                        .font(.system(size: 22, weight: .semibold))
                                        .foregroundColor(.white)
                                }
                                Image("Hero_image")
                                    .resizable()
                                    .cornerRadius(12)
                                    .frame(width: 80, height: 80)
                                    
                            }
                            TextField("Search menu", text: $searchText)
                                .textFieldStyle(.roundedBorder)
//                                    .frame(height: 44)
                            ScrollView(.horizontal) {
                                ForEach(self.categories) { item in
                                    Text(item)
                                }
                            }
                        }.padding(12).background(.green)
                            .listRowInsets(EdgeInsets())
                        ForEach(dishes) { dish in
                            HStack(alignment: .top) {
                                VStack(alignment: .leading) {
                                    Text("\(dish.title ?? "")")
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                    Text(dish.description_ ?? "")
                                        .fontWeight(.medium)
                                        .foregroundColor(.gray)
                                    Text("\(dish.price ?? "0")$")
                                        .fontWeight(.semibold)
                                        .foregroundColor(.mint)
                                }
                                Spacer()
                                AsyncImage(url: URL(string: dish.image ?? "")) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }.frame(width: 60, height: 60)
                                    .cornerRadius(12)
                            }
                        }
                    }
                })
        }.toolbar {
            ToolbarItem(placement: .principal, content: {
                Image("logo")
            })
            ToolbarItem(placement: .navigationBarTrailing, content: {
                Button {
                    self.selectedTab = kTabUserProfile
                } label: {
                    Image("profile-image-placeholder")
                }
            })
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
            print("data: ", String(data: data, encoding: .utf8))
            PersistenceController.shared.clear()
            guard let menuList = try? JSONDecoder().decode(MenuList.self, from: data) else { return }
            menuList.menu.forEach { menuItem in
                let dish = Dish(context: self.viewContext)
                dish.image = menuItem.image
                dish.price = menuItem.price
                dish.title = menuItem.title
                dish.description_ = menuItem.description_
            }
            try? self.viewContext.save()
        }
        task.resume()
    }
    
    func buildPredicate() -> NSPredicate {
        if self.searchText.isEmpty {
            return NSPredicate(value: true)
        }
        return NSPredicate(format: "title CONTAINS[cd] %@", self.searchText)
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [
            NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare))
        ]
    }
}

//struct MenuView_Previews: PreviewProvider {
//    @State var selectedTab = kTabMenu
//
//    static var previews: some View {
//        MenuView(selectedTab: )
//    }
//}
