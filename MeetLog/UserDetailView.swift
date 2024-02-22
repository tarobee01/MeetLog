//
//  UserDetailView.swift
//  MeetLog
//
//  Created by 武林慎太郎 on 2024/02/22.
//

import SwiftUI

struct UserDetailView: View {
    typealias editUserType = (User) -> Void
    let editUser: editUserType
    
    func letsEditUser(newUser: User) {
        editUser(newUser)
    }
    @Environment(\.presentationMode) var presentationMode
    @State private var name: String
    @State private var emailAddress: String
    @State private var phoneNumber: String
    @State private var note: String
    @State private var isContacted: Bool
    
    init(user: User, editUserInfo: @escaping editUserType) {
        self.editUser = editUserInfo
        self._name = State(initialValue: user.name)
        self._emailAddress = State(initialValue: user.emailAddress)
        self._phoneNumber = State(initialValue: user.phoneNumber)
        self._note = State(initialValue: user.note)
        self._isContacted = State(initialValue: user.isContacted)
    }

    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section(header: Text("profile")) {
                        TextField("Name", text: $name)
                            .textContentType(.name)
                        TextField("Email Address", text: $emailAddress)
                            .textContentType(.emailAddress)
                        TextField("Phone Number", text: $phoneNumber)
                            .textContentType(.telephoneNumber)
                        
                    }
                    Section(header: Text("isContacted")) {
                        Toggle(isOn: $isContacted) {
                            Text("Is Contacted: \(isContacted ? "Yes" : "No")")
                        }
                    }
                    
                    Section(header: Text("Note")) {
                        TextField("Enter your note here", text: $note)
                    }
                    Section {
                        HStack {
                            Spacer()
                            Button(action: {
                                let newUser = User(name: name, emailAddress: emailAddress, phoneNumber: phoneNumber, note: note, isContacted: isContacted)
                                letsEditUser(newUser: newUser)
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Text("Done")
                                    .padding(10)
                                    .foregroundColor(.white)
                                    .background(Color.blue)
                                    .cornerRadius(8)
                            }
                        }
                    }
                }
            }
            .navigationTitle("User detail")
        }
    }
}

#Preview {
    UserDetailView(user: User(name: "taro", emailAddress: "taro@icloud.com", phoneNumber: "08080808", note: "idk", isContacted: false), editUserInfo: {_ in})
}
