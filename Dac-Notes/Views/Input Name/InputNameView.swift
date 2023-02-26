//
//  InputNameView.swift
//  Dac-Notes
//
//  Created by Dac Vu on 23/02/2023.
//

import SwiftUI

struct InputNameView: View {
    @State private var isUsernameFocused: Bool = false
    @State private var inputName: String = ""
    
    @Environment(\.presentationMode) var presentationMode
    let onUserInput: (_ name: String) -> Void
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                Spacer().frame(width: 16)
                Text("Input name:")
                    .foregroundColor(isUsernameFocused ? .red : .accentColor)
                TextField(
                    "Input name",
                    text: $inputName
                )
                .onSubmit {
                    validate(name: inputName)
                }
                .padding()
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .textFieldStyle(.roundedBorder)
                Spacer().frame(width: 16)
            }
            Button(action: {
                validate(name: inputName)
            }) {
                Text("Confirm")
                    .padding()
            }
            .background(Capsule().stroke(lineWidth: 2).foregroundColor(.accentColor))
            Spacer()
        }
    }
    
    func validate(name: String) {
        if !name.isEmpty {
            // GO TO HOME
            //            appRouter.state = .tabbar
            onUserInput(inputName)
            presentationMode.wrappedValue.dismiss()
        } else {
            isUsernameFocused = true
        }
    }
}

struct InputNameView_Previews: PreviewProvider {
    static var previews: some View {
        InputNameView(onUserInput: {_ in})
    }
}
