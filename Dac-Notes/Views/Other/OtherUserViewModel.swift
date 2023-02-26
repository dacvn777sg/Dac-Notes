//
//  NoteDetailViewModel.swift
//  Dac-Notes
//
//  Created by Dac Vu on 26/02/2023.
//

import SwiftUI
import Combine
import FirebaseDatabase
import FirebaseSharedSwift

final class OtherUserViewModel: ObservableObject {
    @Published var users: [UserModel] = []
    private var userId = UserDefaults.standard.string(forKey: "USER_ID")
    
    private lazy var databasePath: DatabaseReference? = {
        let ref = Database.database().reference().child("users")
        return ref
    }()
    
    func userListentoRealtimeDatabase() {
        self.users = []
        guard let databasePath = databasePath else {
            return
        }
        
        databasePath
            .observe(.childAdded) { [weak self] snapshot,str  in
            guard
                let self = self,
                var json = snapshot.value as? [String: Any]
            else {
                return
            }
                json["id"] = snapshot.key
                do {
                    let user = try FirebaseDataDecoder().decode(UserModel.self, from: json)
                    if user.id != self.userId {
                        self.users.append(user)
                    }
                } catch {
                    print("an error occurred", error)
                }
            }
    }
    
    func stopListening() {
        databasePath?.child("users").removeAllObservers()
    }
}
