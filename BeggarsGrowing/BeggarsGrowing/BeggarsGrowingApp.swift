//
//  BeggarsGrowingApp.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/20/24.
//

import SwiftUI
import SwiftData

@main
struct BeggarsGrowingApp: App {
    var modelContainer: ModelContainer = {
        let schema = Schema([Recipe.self, Refrigerator.self, History.self, Beggars.self, FilterRecipe.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    @StateObject var cookViewModel = CookViewModel()
    @StateObject var recipeViewModel = RecipeViewModel()
    @StateObject var mainViewModel = MainViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(cookViewModel)
                .environmentObject(recipeViewModel)
                .environmentObject(mainViewModel)
                .modelContainer(modelContainer)
        }
    }
}
