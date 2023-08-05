//
//  CoreDataManager.swift
//  ToDoList
//
//  Created by Sara Sd on 17/01/1445 AH.
//

import Foundation
import CoreData

struct CoreDataManager {
    static let shared = CoreDataManager()
    let container: NSPersistentContainer
    
    init() {
        
        self.container = NSPersistentContainer(name: "Task")
        container.loadPersistentStores { storeDescription, error in
            
        }
    }
}
