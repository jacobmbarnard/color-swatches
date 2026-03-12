import CoreData
import UIKit

class ColorSwatchViewModel {
    private let context: NSManagedObjectContext
    private var swatches: [ColorSwatch] = []
    
    init(context: NSManagedObjectContext) {
        self.context = context
        fetchSwatches()
    }
    
    func fetchSwatches() {
        let request: NSFetchRequest<ColorSwatch> = ColorSwatch.fetchRequest()
        do {
            swatches = try context.fetch(request)
            print("Fetched \(swatches.count) swatches of type \(type(of: swatches.first))")  // Debug: Check types
        } catch {
            print("Error fetching swatches: \(error)")
        }
    }
    
    func addSwatch(swatchName: String, colorHex: String, userRating: Int) {
        if let entity = NSEntityDescription.entity(forEntityName: "ColorSwatches", in: context) {
            print("Entity found: \(entity)")
        } else {
            print("Entity 'ColorSwatches' NOT found in model!")
        }
        
        let newSwatch = ColorSwatch(context: context)
        newSwatch.swatchName = swatchName
        newSwatch.colorHex = colorHex
        newSwatch.rating = Int16(userRating)  // Convert Int to Int64 for Core Data Integer attribute
        saveContext()
        fetchSwatches()
    }
    
    func getSwatches() -> [ColorSwatch] {
        return swatches
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}
