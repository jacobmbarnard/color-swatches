import CoreData

class ContextManager {
    fileprivate static var xcdatamodeldName: String = "ColorSwatches"
    
    public static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: xcdatamodeldName)
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    public static func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
