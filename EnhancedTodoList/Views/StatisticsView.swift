//
//  StatisticsView.swift
//  EnhancedTodoList
//
//  Created by Yuzhou Zhang on 2024-11-29.
//

import Charts
import SwiftData
import SwiftUI

struct StatisticsView: View {
    
    // MARK: Stored properties
    
    // Access the app data store
    @Environment(\.modelContext) private var modelContext
 
    // To hold stats about how many items have been completed or not
    @State private var completedItemsCount = 0
    @State private var incompleteItemsCount = 0
 
    // MARK: Computed properties
    var body: some View {
        NavigationStack {
            Group {
                if completedItemsCount + incompleteItemsCount == 0 {
                    ContentUnavailableView(label: {
                        Label("No stats available", systemImage: "chart.pie.fill")
                            .foregroundStyle(.green)
                    }, description: {
                        Text("Statistics will appear once you have made and tracked some data.")
                    })
                } else {
                    VStack {
                        
                        HStack {
                            Text("Completion status")
                                .bold()
                            Spacer()
                        }
                        
                        Chart {
                            
                            if completedItemsCount > 0 {
                                SectorMark(
                                    angle: .value("Items Completed", completedItemsCount),
                                    innerRadius: .ratio(0.65),
                                    angularInset: 2.0
                                )
                                .foregroundStyle(.green)
                                .annotation(position: .overlay) {
                                    Text("\(completedItemsCount)")
                                        .foregroundStyle(.white)
                                }
                            }
                            
                            if incompleteItemsCount > 0 {
                                
                                SectorMark(
                                    angle: .value("Items Not Completed", incompleteItemsCount),
                                    innerRadius: .ratio(0.65),
                                    angularInset: 2.0
                                )
                                .foregroundStyle(.orange)
                                .annotation(position: .overlay) {
                                    Text("\(incompleteItemsCount)")
                                        .foregroundStyle(.white)
                                }
                            }
                        }
                        .chartBackground { proxy in
                            Text("📝")
                                .font(.system(size: 60))
                        }
                        .padding()
                        
                        HStack {
                            
                            Spacer()
                            
                            Circle()
                                .frame(width: 10)
                                .foregroundStyle(.orange)
                            
                            Text("No")
                                .font(.caption)
 
                            Spacer()
                            
                            Circle()
                                .frame(width: 10)
                                .foregroundStyle(.green)
                            
                            Text("Yes")
                                .font(.caption)
                            
                            Spacer()
                        }
                        
                        Rectangle()
                            .foregroundStyle(.clear)
                            .frame(height: 50)
                        
                    }
                    .padding()
                }
            }
            .navigationTitle("Statistics")
        }
        .task {
            
            // How many completed items? (Defaults to zero if no items found at all.)
            let completedItemsPredicate = #Predicate<TodoItem> { item in
                item.isCompleted == true
            }
            let completedItemsDescriptor = FetchDescriptor<TodoItem>(predicate: completedItemsPredicate)
            completedItemsCount = (try? modelContext.fetchCount(completedItemsDescriptor)) ?? 0
            
            // How many incomplete items? (Defaults to zero if no items found at all.)
            let incompleteItemsPredicate = #Predicate<TodoItem> { item in
                item.isCompleted == false
            }
            let incompleteItemsDescriptor = FetchDescriptor<TodoItem>(predicate: incompleteItemsPredicate)
            incompleteItemsCount = (try? modelContext.fetchCount(incompleteItemsDescriptor)) ?? 0
 
        }
 
 
    }
}


#Preview {
    StatisticsView()
        .modelContainer(TodoItem.preview)
}
