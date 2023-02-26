//
//  HomeViewModel.swift
//  Dac-Notes
//
//  Created by Dac Vu on 22/02/2023.
//

import SwiftUI
import Combine

import Foundation
import FirebaseDatabase
import FirebaseSharedSwift

final class HomeViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var notes: [NoteModel] = []
    @Published var userId = UserDefaults.standard.string(forKey: "USER_ID") ?? ""
    
    private lazy var databasePath: DatabaseReference? = {
        let ref = Database.database().reference().child("users")
        return ref
    }()
    
    func notesListentoRealtimeDatabase() {
        guard let databasePath = databasePath else {
            return
        }
        if userId.isEmpty {
            userId = UUID().uuidString
            UserDefaults.standard.set(userId, forKey: "USER_ID")
        }
        
        let refName = databasePath.child("\(userId)/name")
        refName.observe(.value) { [weak self] snapShot in
            guard let `self` = self, let nameValue = snapShot.value as? String else {
                return
            }
            self.name = nameValue
        }
        
        self.notes = []
        let refNote = databasePath.child(userId).child("notes")
        refNote.observe(.childAdded) { [weak self] snapshot,str  in
            guard let `self` = self, var json = snapshot.value as? [String: Any] else {
                return
            }
            json["id"] = snapshot.key
            do {
                let note = try FirebaseDataDecoder().decode(NoteModel.self, from: json)
                self.notes.append(note)
            } catch {
                print("an error occurred", error)
            }
        }
    }
    
    func insertNote(userId: String, note: NoteModel, completion: ((AppError?)->Void)?) {
        guard let databasePath = databasePath, !userId.isEmpty else {
            completion?(.configError)
            return
        }
        
        do {
            let json = try FirebaseDataEncoder().encode(note)
            databasePath.child(userId).child("notes").child(note.id).setValue(json)
            completion?(nil)
        } catch {
            completion?(.parseError(error))
            print("an error occurred", error)
        }
    }
    
    func updateUserName(_ userId: String, userName: String, completion: ((AppError?)->Void)?) {
        guard let databasePath = databasePath, !userId.isEmpty else {
            completion?(.configError)
            return
        }
        
        databasePath.child(userId).updateChildValues(["name": userName]) { err, ref in
            if let err = err {
                print("an error occurred", err)
                completion?(.parseError(err))
                return
            }
            self.name = userName
            UserDefaults.standard.set(userId, forKey: "USER_ID")
            print("Successful!!!")
            completion?(nil)
        }
    }
    
    func stopListening() {
        databasePath?.child(userId).child("notes").removeAllObservers()
        databasePath?.child("\(userId)/name").removeAllObservers()
//        databasePath?.removeAllObservers()
    }
}
