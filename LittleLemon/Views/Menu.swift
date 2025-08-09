//
//  Menu.swift
//  LittleLemon
//
//  Created by Nguyen Huu Hung on 8/3/25.
//

import SwiftUI
import CoreData

struct Menu: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var menuItems: [MenuItem] = []
    
    var categories: [String] = ["Starters", "Mains", "Desserts", "Drinks"]
    
    @State var searchText: String = ""
    @State var isStartsEnbale: Bool = false
    @State var isDessertsEnable: Bool = false
    @State var isMainsEnable: Bool = false
    @State var isDrinksEnable: Bool = false
    @State var categorySelected: String = ""
    
    var body: some View {
        VStack {
            // Header
            HStack(alignment: .center) {
                Image(.logo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.size.width, height: 40)
            }
            // Hero Section
            HeroSection(textSearch: $searchText, isEnableSearch: .constant(true))
                .frame(width: 393, height: 364)
                .padding(.bottom, 23)
            
            // Order categories
            HStack {
                Text("ORDER FOR DELIVERY!")
                    .font(.custom("Karla-ExtraBold", size: 20))
                    .foregroundStyle(.black)
                Spacer()
            }
            .padding(.leading, 16)
            
            ScrollView(.horizontal) {
                LazyHStack(content: {
                    ForEach(categories, id: \.self)  { category in
                        
                        Button(action: {
                            if category == categorySelected {
                                categorySelected = ""
                            } else {
                                categorySelected = category
                            }
                            onTapCategory(text: category)
                        }, label: {
                            Text(category)
                                .frame(width: 80,height: 39)
                                .font(.custom("Karla-ExtraBold", size: 16))
                                .foregroundStyle(categorySelected == category ? .primaryYellow : .primaryGreen)
                                .background(categorySelected == category ? .primaryGreen : .highlightGray)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                        })
                        .padding(.leading, 10)
                    }
                })
            }
            .frame(height: 40)
            .scrollIndicators(.hidden)
            
            FetchedObjects(predicate: filter(), sortDescriptors: sort()) { (dishes: [Dish]) in
                List(dishes, id: \.self) { dish in
                    Item(dish: .constant(dish))
                }
                .listStyle(.plain)
            }
        }
        .overlay(alignment: .topTrailing, content: {
            Image(.profileImagePlaceholder)
                .resizable()
                .frame(width: 40, height: 40)
                .padding(.trailing, 16)
        })
        .task {
            await getMenuData(context: viewContext)
        }
    }
    
    func getMenuData(context: NSManagedObjectContext) async {
        let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")!
        let urlSession = URLSession.shared
        
        do {
            let (data, _) = try await urlSession.data(from: url)
            let fullMenu = try JSONDecoder().decode(JSONMenu.self, from: data)
            menuItems = fullMenu.menuItems
            
            // populate Core Data
            Dish.deleteAll(context)
            Dish.createDishesFrom(menuItems: menuItems, context)
            
        }
        catch let error {
            print(error.localizedDescription)
        }
    }
    
    func filter() -> NSCompoundPredicate {
        let searchText = searchText == "" ? NSPredicate(value: true) : NSPredicate(format: "name CONTAINS[cd] %@", searchText)
        let searchStarters = isStartsEnbale ? NSPredicate(format: "category == %@", "starters") : NSPredicate(value: true)
        let searchMains = isMainsEnable ? NSPredicate(format: "category == %@", "mains") : NSPredicate(value: true)
        let searchDesserts = isDessertsEnable ? NSPredicate(format: "category == %@", "desserts") : NSPredicate(value: true)
        let searchDrinks = isDrinksEnable ? NSPredicate(format: "category == %@", "drinks") : NSPredicate(value: true)
        
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [searchText, searchStarters , searchMains, searchDesserts, searchDrinks])
        return compoundPredicate
    }
    
    func sort() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "name",
                                 ascending: true,
                                  selector:
                                     #selector(NSString.localizedCaseInsensitiveCompare))]
    }
    
    func onTapCategory(text: String) {
        switch text {
        case "Starters":
            isStartsEnbale.toggle()
            isMainsEnable = false
            isDessertsEnable = false
            isDrinksEnable = false
        case "Mains":
            isMainsEnable.toggle()
            isStartsEnbale = false
            isDessertsEnable = false
            isDrinksEnable = false
        case "Desserts":
            isDessertsEnable.toggle()
            isStartsEnbale = false
            isMainsEnable = false
            isDrinksEnable = false
        case "Drinks":
            isDrinksEnable.toggle()
            isStartsEnbale = false
            isMainsEnable = false
            isDessertsEnable = false
        default:
            break
        }
    }
}

#Preview {
    Menu()
}
