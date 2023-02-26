//
//  UserModel.swift
//  Dac-Notes
//
//  Created by Dac Vu on 22/02/2023.
//

import Foundation
import SwiftUI

struct UserModel : Codable, Hashable, Identifiable {
    var id: String
    var name: String?
    var notes: [String: NoteModel]?
}

extension UserModel {
    var noteArr: [NoteModel] {
        guard let notes = notes else { return [] }
        return notes.map { $0.value }.sorted(by: { ($0.date ?? .now).compare($1.date ?? .now) == .orderedAscending })
    }
}
