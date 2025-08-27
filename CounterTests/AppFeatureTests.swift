//
//  AppFeatureTests.swift
//  CounterTests
//
//  Created by Nguyen Truong Luu on 8/28/25.
//

import ComposableArchitecture
import Testing

@testable import Counter

@MainActor
struct AppFeatureTests {
    @Test
    func incrementInFirstTab() async {
        let store = TestStore(initialState: AppFeature.State()) {
            AppFeature()
        }

        await store.send(\.tab1.incrementButtonTapped) {
            $0.tab1.count = 1
        }
    }
}
