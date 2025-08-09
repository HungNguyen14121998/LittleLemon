//
//  LittleLemonApp.swift
//  LittleLemon
//
//  Created by Nguyen Huu Hung on 8/3/25.
//

import SwiftUI

@main
struct LittleLemonApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
