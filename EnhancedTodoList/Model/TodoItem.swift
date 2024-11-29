//
//  TodoItem.swift
//  EnhancedTodoList
//
//  Created by Yuzhou Zhang on 2024-11-29.
//

import Observation
import Foundation
 
@Observable
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
 
let exampleData = [
    
    TodoItem(details: "Go for a walk"),
    TodoItem(details: "Study for Physics"),
    TodoItem(details: "Call mom"),
    
]
