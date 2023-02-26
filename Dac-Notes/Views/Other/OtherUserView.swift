//
//  OtherUserView.swift
//  Dac-Notes
//
//  Created by Dac Vu on 23/02/2023.
//

import SwiftUI

struct OtherUserView: View {
    
    @StateObject private var viewModel = OtherUserViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if !viewModel.users.isEmpty {
                    List {
                        ForEach(viewModel.users) { user in
                            Section(user.name ?? "Unnamed") {
                                ForEach(user.noteArr) { note in
                                    NavigationLink(destination: NoteDetailView(note: note, isViewOnly: true)
                                        .navigationTitle("Detail Note")
                                        .navigationBarTitleDisplayMode(.inline)) {
                                            NoteRow(note: .constant(note))
                                    }
                                }
                                
                            }
                        }

                    }
                } else {
                    Spacer()
                    Text("Try adding an note!")
                        .italic()
                        .foregroundColor(.gray)
                    Spacer()
                }
            }
            .navigationTitle("Other Notes")
        }.onAppear {
            viewModel.userListentoRealtimeDatabase()
        }
        .onDisappear {
            viewModel.stopListening()
        }
    }
}

struct OtherUserView_Previews: PreviewProvider {
    static var previews: some View {
        OtherUserView()
    }
}
