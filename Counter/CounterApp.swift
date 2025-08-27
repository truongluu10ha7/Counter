//
//  CounterApp.swift
//  Counter
//
//  Created by Nguyen Truong Luu on 8/28/25.
//

import ComposableArchitecture
import SwiftUI

@main
struct CounterApp: App {
    static let store = Store(initialState: AppFeature.State()) {
        AppFeature()
            ._printChanges()
    }

    var body: some Scene {
        WindowGroup {
            AppView(store: CounterApp.store)
        }
    }
}
