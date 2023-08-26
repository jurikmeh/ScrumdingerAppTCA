import Foundation

struct Meeting: Identifiable, Equatable, Codable {
    let id: UUID
    let date: Date
    let transcript: String
}
