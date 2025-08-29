//
//  AddContactFeature.swift
//  Counter
//
//  Created by Nhi Nguyen on 29/8/25.
//

import ComposableArchitecture
import Foundation
import SwiftUI

@Reducer
struct AddContactFeature {
    @ObservableState
    struct State: Equatable {
        var contact: Contact
    }

    enum Action {
        case cancelButtonTapped
        case delegate(Delegate)
        case saveButtonTapped
        case setName(String)
        enum Delegate {
            case saveContact(Contact)
        }
    }

    @Dependency(\.dismiss) var dismiss
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .cancelButtonTapped:
                return .run { _ in await self.dismiss() }

            case .delegate:
                return .none

            case .saveButtonTapped:
                return .run { [contact = state.contact] send in
                    await send(.delegate(.saveContact(contact)))
                    await self.dismiss()
                }

            case let .setName(name):
                state.contact.name = name
                return .none
            }
        }
    }
}

struct AddContactView: View {
    @Bindable var store: StoreOf<AddContactFeature>

    var body: some View {
        Form {
            TextField("Name", text: $store.contact.name.sending(\.setName))
            Button("Save") {
                store.send(.saveButtonTapped)
            }
        }
        .toolbar {
            ToolbarItem {
                Button("Cancel") {
                    store.send(.cancelButtonTapped)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddContactView(
            store: Store(
                initialState: AddContactFeature.State(
                    contact: Contact(
                        id: UUID(),
                        name: "Blob"
                    )
                )
            ) {
                AddContactFeature()
            }
        )
    }
}
