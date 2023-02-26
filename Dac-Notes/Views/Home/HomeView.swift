//
//  HomeView.swift
//  Dac-Notes
//
//  Created by Dac Vu on 22/02/2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    @FocusState private var focusName: Bool
    @State private var activeSheet: ActiveSheet?
    @State private var showingAlert: Bool = false
    @State private var alertMessage: String = ""
    
    private enum ActiveSheet: Identifiable {
        case addNote, inputName
        
        var id: Int {
            hashValue
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    if !viewModel.userId.isEmpty, !viewModel.notes.isEmpty {
                        userHeader
                        ForEach(viewModel.notes) { note in
                            NavigationLink(destination: NoteDetailView(note: note, isViewOnly: true)
                                .navigationTitle("Detail Note")
                                .navigationBarTitleDisplayMode(.inline)) {
                                    NoteRow(note: .constant(note))
                            }
                        }
                    } else {
                        userHeader
                        VStack() {
                            Spacer()
                            Text("Try adding an note!")
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .italic()
                                .foregroundColor(.gray)
                            
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("Dac Notes")
            .sheet(item: $activeSheet) { item in
                switch item {
                case .addNote:
                    NavigationView {
                        NoteDetailView(note: NoteModel()) { title,desc in
                            guard !viewModel.userId.isEmpty else { return }
                            viewModel.insertNote(userId: viewModel.userId, note: NoteModel(title: title, description: desc, date: .now), completion: { err in
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    alertMessage = "New note has been created"
                                    showingAlert.toggle()
                                }
                            })
                        }
                        .navigationTitle("New Note")
                        .navigationBarTitleDisplayMode(.inline)
                    }
                case .inputName:
                    NavigationView {
                        InputNameView(onUserInput: { name in
                            guard !viewModel.userId.isEmpty else { return }
                            viewModel.updateUserName(viewModel.userId, userName: name, completion: { err in
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    if let err = err {
                                        alertMessage = err.message
                                    } else {
                                        alertMessage = "Your note has been named to \(viewModel.name)"
                                    }
                                    showingAlert.toggle()
                                }
                            })
                        })
                            .navigationTitle("Input your name")
                    }
                }

            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(alertMessage))
            }
            .overlay(alignment: .bottom) {
                VStack {
                    Button(action: {
                        activeSheet = .addNote
                    }) {
                        HStack{
                            Image(systemName: "plus")
                            Text("New Note")
                        }.padding()
                    }
                    .background(RoundedRectangle(cornerRadius: 30)
                    .opacity(0.5))
                    
                    Spacer().frame(height: 8)
                }
            }
            
        }.onAppear {
            if viewModel.userId.isEmpty {
                activeSheet = .inputName
            }
            viewModel.notesListentoRealtimeDatabase()
        }
        .onDisappear {
            viewModel.stopListening()
        }
    }
    
    @ViewBuilder
    var userHeader: some View {
        Section {
            HStack(spacing: 8){
                ImageOnCircle(icon: "pikachu", radius: 20, circleColor: Color(.lightGray))
                
                VStack(spacing: .zero) {
                    HStack() {
                        TextField("Input", text: $viewModel.name)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: true, vertical: false)
                            .font(.system(size: 20, weight: .bold))
                            .textSelection(.enabled)
                            .focused($focusName)
                            .onSubmit {
                                viewModel.updateUserName(viewModel.userId, userName: viewModel.name, completion: {_ in
                                    
                                     alertMessage = "Your note has been renamed to \(viewModel.name)"
                                    showingAlert.toggle()
                                })
                            }
                            .submitLabel(.done)
                        Button {
                            focusName.toggle()
                            viewModel.updateUserName(viewModel.userId, userName: viewModel.name, completion: {_ in
                                
                                 alertMessage = "Your note has been renamed to \(viewModel.name)"
                                showingAlert.toggle()
                            })
                        } label: {
                            Label("", systemImage: "pencil.line")
                        }
                        Spacer()
                    }
                    
                    HStack {
                        Circle()
                            .foregroundColor(.green)
                            .frame(width: 12, height: 12)
                        Text("Playing game")
                            .font(.system(size: 14))
                            .foregroundColor(Color(.lightGray))
                        Spacer()
                    }
                }
            }
            .padding()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

