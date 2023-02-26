//
//  NoteDetailView.swift
//  Dac-Notes
//
//  Created by Dac Vu on 22/02/2023.
//

import SwiftUI

struct NoteDetailView: View {
    @State var note: NoteModel
    @Environment(\.presentationMode) private var presentationMode
    
    var isViewOnly: Bool = false
    var onNoteAdded: ((_ title: String, _ desc: String) -> Void)? = nil
    
    var body: some View {
            Form {
                Section {
                    TextField("Edit me!", text: $note.title)
                        .textSelection(.enabled)
                        .onTapGesture {
                            note.title = ""
                        }
        
                    ZStack {
                        TextEditor(text: $note.desc)
                            .textSelection(.enabled)
                            .frame(height: 200)
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Text("\(note.desc.count)/120")
                                    .foregroundColor(.gray)
                                    .padding()
                            }
                        }
                    }
                    if !isViewOnly {
                        HStack {
                            Spacer()
                            Button("Add") {
                                onNoteAdded?(note.title, note.desc)
                                presentationMode.wrappedValue.dismiss()
                            }
                            Spacer()
                        }
                    }
                }
            }.disabled(isViewOnly)
    }
}

struct NoteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        NoteDetailView(note: NoteModel(title: "Test", description: "Test Description"))
    }
}
