//
//  LandingView.swift
//  EnhancedTodoList
//
//  Created by Yuzhou Zhang on 2024-11-29.
//

import SwiftUI
 
struct LandingView: View {
    
    @State var selectedTab = 1
    
    var body: some View {
        TabView(selection: $selectedTab) {
            TodoListView()
                .tabItem {
                    Text("Tasks")
                    Image(systemName: "checklist")
                }
                .tag(1)
            
            StatisticsView()
                .tabItem {
                    Text("Stats")
                    Image(systemName: "chart.line.uptrend.xyaxis")
                }
                .tag(2)
        }
    }
    
    // Allow the selected tab to be passed in
    init(selectedTab: Int = 1) {
        _selectedTab = State(initialValue: selectedTab)
    }
}
 
#Preview {
    LandingView()
}
