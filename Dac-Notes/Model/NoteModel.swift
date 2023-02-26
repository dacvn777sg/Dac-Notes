//
//  NoteModel.swift
//  Dac-Notes
//
//  Created by Dac Vu on 22/02/2023.
//

import Foundation
import SwiftUI
import FirebaseDatabase

struct NoteModel : Codable, Hashable, Identifiable {
    var id: String
    var title: String
    var desc: String
    var date: Date?
    
    init(id: String = UUID().uuidString, title: String = "", description: String = "", date: Date? = nil) {
        self.id = id
        self.title = title
        self.desc = description
        self.date = date
    }
}

extension NoteModel {
    var dateString: String {
        guard let _date = date else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: _date)
    }
    
    var randomAvatar: ImageOnCircle {
        ImageOnCircle(icon: "imgNote", radius: 20, circleColor: Color(.white))
    }
}
