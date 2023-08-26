import ComposableArchitecture
import SwiftUI

@main
struct ScrumdingerAppTCA: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                StandupListView(
                    store: Store(
                        initialState: StandupsListFeature.State(standups: [.mock])
                    ) {
                        StandupsListFeature()
                    }
                )
            }
        }
    }
}
