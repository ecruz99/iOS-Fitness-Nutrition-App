//
//  TabContainer.swift
//  Fitness-Nutriton-App
//
//  Created by Nicki Lee on 3/29/23.
//

import Foundation
import SwiftUI

struct TabContainer: View {
    @EnvironmentObject var dataStore: DataStore
  
    var body: some View {
        TabView{
            NavigationView {
                MainFitness()
            }
            .tabItem { Label("Fitness", systemImage: "figure.run") }
            NavigationView {
                NutritionPage(user: Binding.constant(dataStore.userList[0]))
            }
            .tabItem { Label("Nutrition", systemImage: "fork.knife") }
        }
    }
}

struct TabContainer_Previews: PreviewProvider {
  static var previews: some View {
      TabContainer().environmentObject(DataStore())
  }
}
