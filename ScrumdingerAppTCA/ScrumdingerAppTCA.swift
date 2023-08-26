import ComposableArchitecture
import SwiftUI

@main
struct ScrumdingerAppTCA: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                StandupsListView(
                    store: Store(
                        initialState: StandupsListFeature.State(
                            addStandup: StandupFormFeature.State(
                                focus: .attendee(Standup.mock.attendees[0].id),
                                standup: .mock
                            )
                        )
                    ) {
                        StandupsListFeature()
                            ._printChanges()
                    }
                )
            }
        }
    }
}
