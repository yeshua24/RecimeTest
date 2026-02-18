//
//  RecimeTestApp.swift
//  RecimeTest
//
//  Created by Yeshua Lagac on 2/13/26.
//

import SwiftUI

@main
struct RecimeTestApp: App {
    private let service: RecipeService = RecipeService()

      var body: some Scene {
          WindowGroup {
              RecipeListView(
                  viewModel: RecipeListViewModel(service: service)
              )
          }
      }
}
