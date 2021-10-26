//
//  RootNavView.swift
//  Freelance Logger
//
//  Created by Jaron Lowe on 10/25/21.
//

import SwiftUI

struct RootNavView: View {
    var body: some View {
        ZStack {
            TabView {
                NavigationView {
                    ProjectListView()
                }
                .tabItem {
                    Label("Projects", systemImage: "list.bullet.rectangle")
                }
                NavigationView {
                    CalculatorView()
                }
                .tabItem {
                    Label("Calculator", systemImage: "chart.xyaxis.line")
                }
            }
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.appPurple)
    }
}
