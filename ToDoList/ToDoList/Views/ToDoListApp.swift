//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Sara Sd on 17/01/1445 AH.
//

import SwiftUI

@main
struct ToDoListApp: App {
    let coreDataManager = CoreDataManager.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, coreDataManager.container.viewContext)
        }
    }
}
