//
//  Persistence.swift
//  CCheck
//
//  Created by Kanawat Rungwattanachai on 20/7/2567 BE.
//

import CoreData

struct PersistenceController {
    //MARK: - 1.Persistent Controller
    static let shared = PersistenceController()

    //MARK:  - 2.Persistent Container
    let container: NSPersistentContainer

    //MARK: - 3.Initailization (load the persistent store)
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "CCheck")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    //MARK: - 4.Preview
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newItem = Item(context: viewContext)
            newItem.id = UUID()
            newItem.name = "Oak"
            newItem.category = "Food"
            newItem.priority = "Normal"
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
}
