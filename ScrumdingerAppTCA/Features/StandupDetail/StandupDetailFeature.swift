import ComposableArchitecture
import Foundation

struct StandupDetailFeature: Reducer {
    struct State: Equatable {
        @PresentationState var editStandup: StandupFormFeature.State?
        var standup: Standup
    }
    
    enum Action {
        case cancelEditStandupButtonTapped
        case deleteButtonTapped
        case deleteMeetings(atOffsets: IndexSet)
        case editButtonTapped
        case editStandup(PresentationAction<StandupFormFeature.Action>)
        case saveStandupButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .cancelEditStandupButtonTapped:
                state.editStandup
                return .none
            case .deleteButtonTapped:
                return .none
            case .deleteMeetings(atOffsets: let indices):
                state.standup.meetings.remove(atOffsets: indices)
                return .none
            case .editButtonTapped:
                state.editStandup = StandupFormFeature.State(standup: state.standup)
                return .none
            case .editStandup:
                return .none
            case .saveStandupButtonTapped:
                guard let standup = state.editStandup?.standup
                else { return .none }
                state.standup = standup
                state.editStandup = nil
                return .none
            }
        }
        .ifLet(\.$editStandup, action: /Action.editStandup) {
            StandupFormFeature()
        }
    }
}
