//
//  UserDetailView.swift
//  MeetLog
//
//  Created by 武林慎太郎 on 2024/02/22.
//

import SwiftUI

struct UserDetailView: View {
    typealias EditUserType = (User) -> Void
    let editUser: EditUserType
    
    @Environment(\.presentationMode) var presentationMode
    @State private var name: String
    @State private var emailAddress: String
    @State private var phoneNumber: String
    @State private var note: String
    @State private var isContacted: Bool
    
    init(user: User, editUserInfo: @escaping EditUserType) {
        self.editUser = editUserInfo
        self._name = State(initialValue: user.name)
        self._emailAddress = State(initialValue: user.emailAddress)
        self._phoneNumber = State(initialValue: user.phoneNumber)
        self._note = State(initialValue: user.note)
        self._isContacted = State(initialValue: user.isContacted)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Profile")) {
                    TextField("Name", text: $name)
                        .textContentType(.name)
                    TextField("Email Address", text: $emailAddress)
                        .textContentType(.emailAddress)
                    TextField("Phone Number", text: $phoneNumber)
                        .textContentType(.telephoneNumber)
                }
                
                Section(header: Text("Is Contacted")) {
                    Toggle(isOn: $isContacted) {
                        Text("Is Contacted: \(isContacted ? "Yes" : "No")")
                    }
                }
                
                Section(header: Text("Note")) {
                    TextField("Enter your note here", text: $note)
                }
            }
            .navigationTitle("User Detail")
            .navigationBarItems(trailing:
                Button(action: {
                    let newUser = User(name: name, emailAddress: emailAddress, phoneNumber: phoneNumber, note: note, isContacted: isContacted)
                    editUser(newUser)
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Done")
                }
            )
        }
    }
}

#Preview {
    UserDetailView(user: User(name: "taro", emailAddress: "taro@icloud.com", phoneNumber: "08080808", note: "idk", isContacted: false), editUserInfo: {_ in})
}
