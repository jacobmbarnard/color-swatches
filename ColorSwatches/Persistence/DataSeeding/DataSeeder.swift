import CoreData
import OSLog

public class DataSeeder {
    
    static let logger: Logger = Logger(subsystem: "ColorSwatches", category: "DataSeeder")
    
    public static func seedDataIfNeeded() {
        let context = ContextManager.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<ColorSwatch> = ColorSwatch.fetchRequest()
        fetchRequest.resultType = .countResultType
        
        do {
            let count = try context.count(for: fetchRequest)
            if count == 0 {
                logger.info("Seeding initial swatches...")
                DataSeeder.seedSampleSwatches(in: context)
                ContextManager.saveContext()
                logger.info("Seeded initial swatches.")
            } else {
                logger.debug("Store already has \(count) swatches; skipping seeding.")
            }
        } catch {
            logger.error("Error checking swatch count: \(error)")
        }
    }
    
    public static func seedSampleSwatches(in context: NSManagedObjectContext) {
        let sampleSwatches: [(name: String, hex: String, rating: Int)] = [
            ("Red", "#FF0000", 5),
            ("Blue", "#0000FF", 2),
            ("Light Green", "#00FF00", 3),  // Note: Rating 1-10 for demo
            ("Violet", "#800080", 1),
            ("Medium Yellow", "#FFA500", 3),
            ("Forest", "#008000", 2),
            ("Pink", "#FF69B4", 1),
            ("Bright Yellow", "#FFFF00", 4),
            ("Brownish Red", "#A52A2A", 2),
            ("Purple", "#4B0082", 2),
            ("Yellow", "#FFD700", 2),
            ("Gray", "#696969", 1),
            ("Turquoise", "#00FFFF", 5),
            ("Muted Red", "#DC143C", 5),
            ("Muted Green", "#32CD32", 2)
        ]
        
        for swatchData in sampleSwatches {
            let swatch = ColorSwatch(context: context)
            swatch.swatchName = swatchData.name
            swatch.colorHex = swatchData.hex
            swatch.rating = Int16(swatchData.rating)
        }
    }

}
