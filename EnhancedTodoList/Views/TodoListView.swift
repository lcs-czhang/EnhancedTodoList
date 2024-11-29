//
//  TodoListView.swift
//  EnhancedTodoList
//
//  Created by Yuzhou Zhang on 2024-11-29.
//

import SwiftUI

struct TodoListView: View {
    
    // MARK: Stored properties
    // The item currently being created
    @State private var newItemDetails = ""
    @State private var searchText = ""
    // Our list of items to complete
    @State private var items: [TodoItem] = []
    
    // MARK: Computed properties
    var filteredItems: [TodoItem] {
        if searchText.isEmpty {
            return items
        } else {
            return items.filter { item in
                item.details.lowercased().contains(searchText.lowercased())
            }
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    
                    TextField("Enter a to-do item", text: $newItemDetails)
                    
                    Button("Add") {
                        addItem()
                    }
                    
                }
                .padding(20)
                
                if items.isEmpty {
                    
                    ContentUnavailableView(label: {
                        Label(
                            "Nothing to do",
                            systemImage: "powersleep"
                        )
                        .foregroundStyle(.green)
                    }, description: {
                        Text("To-do items will appear here once you add some.")
                    })
                    
                } else {
                    
                    List{
                        ForEach(filteredItems) { currentItem in
                            Label {
                                Text(currentItem.details)
                            } icon: {
                                Image(systemName: currentItem.isCompleted ? "checkmark.circle" : "circle")
                                    .onTapGesture {
                                        toggle(item: currentItem)
                                    }
                                
                            }
                            .swipeActions {
                                Button(
                                    "Delete",
                                    role: .destructive,
                                    action: {
                                    }
                                )
                            }
                        }
                    }
                    
                }
            }
            .navigationTitle("Tasks")
        }
        .onAppear {
            // Populate with example data
            if items.isEmpty {
                items.append(contentsOf: exampleData)
            }
        }
        .searchable(text: $searchText)
    }
    // MARK: Functions
    func addItem() {
        let newToDoItem = TodoItem(details: newItemDetails)
        items.insert(newToDoItem, at: 0)
        newItemDetails = ""
    }
    func toggle(item: TodoItem) {
        if item.isCompleted {
            item.completedOn = nil
            item.isCompleted = false
        } else {
            item.completedOn = Date()
            item.isCompleted = true
        }
        
    }
    
    
    
}


#Preview {
    LandingView()
}
