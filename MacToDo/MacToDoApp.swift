//
//  MacToDoApp.swift
//  MacToDo
//
//  Created by felipe azevedo on 08/05/22.
//

import SwiftUI

@main
struct MacToDoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 320, idealWidth: 640, minHeight: 240, idealHeight: 480)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
