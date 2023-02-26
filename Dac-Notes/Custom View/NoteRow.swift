//
//  NoteRow.swift
//  Dac-Notes
//
//  Created by Dac Vu on 26/02/2023.
//

import SwiftUI

struct NoteRow: View {
    @Binding var note: NoteModel
    var body: some View {
        HStack {
            note.randomAvatar
            VStack(alignment: .leading) {
                Text(note.title).font(.system(size: 16, weight: .bold))
                    .lineLimit(2)
                
                Text(note.dateString).font(.system(size: 12)).foregroundColor(Color(.lightGray))
            }
        }
    }
}

struct NoteRow_Previews: PreviewProvider {
    static var previews: some View {
        NoteRow(note: .constant(NoteModel()))
    }
}
