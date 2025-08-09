//
//  ContentView.swift
//  LittleLemon
//
//  Created by Nguyen Huu Hung on 8/3/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    var body: some View {
        Onboarding()
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
