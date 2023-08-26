import ComposableArchitecture
import SwiftUI

struct StandupsListView: View {
    let store: StoreOf<StandupsListFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: \.standups) { viewStore in
            List {
                ForEach(viewStore.state) { standup in
                    CardView(standup: standup)
                        .listRowBackground(standup.theme.mainColor)
                }
            }
            .navigationTitle("Daily Standups")
            .toolbar {
                ToolbarItem {
                    Button("Add") {
                        viewStore.send(.addButtonTapped)
                    }
                }
            }
            .sheet(
                store: self.store.scope(
                    state: \.$addStandup,
                    action: { .addStandup($0) }
                )
            ) { store in
                NavigationStack {
                    StandupFormView(store: store)
                        .navigationTitle("New standup")
                        .toolbar {
                            ToolbarItem {
                                Button("Save") { viewStore.send(.saveStandupButtonTapped) }
                            }
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancel") { viewStore.send(.cancelStandupButtonTapped) }
                            }
                        }
                }
            }
        }
    }
}
