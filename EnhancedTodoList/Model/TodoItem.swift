//
//  TodoItem.swift
//  EnhancedTodoList
//
//  Created by Yuzhou Zhang on 2024-11-29.
//

import Foundation
import SwiftData
 
@Model
class TodoItem: Identifiable {
    
    let id = UUID()
    var details: String
    let createdOn: Date
    var isCompleted: Bool
    var completedOn: Date?
    
    init(
        details: String,
        createdOn: Date = Date(),
        isCompleted: Bool = false,
        completedOn: Date? = nil
    ) {
        self.details = details
        self.createdOn = createdOn
        self.isCompleted = isCompleted
        self.completedOn = completedOn
    }
 
}
 
extension TodoItem {
    
    @MainActor
    static var preview: ModelContainer {
        
        let container = try! ModelContainer(
            for: TodoItem.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        
        // Add mock data
        container.mainContext.insert(
            TodoItem(details: "Go for a walk", isCompleted: false)
        )
        container.mainContext.insert(
            TodoItem(details: "Have a nap", isCompleted: true)
        )
        container.mainContext.insert(
            TodoItem(details: "Call mom", isCompleted: false)
        )
 
        return container
    }
}

