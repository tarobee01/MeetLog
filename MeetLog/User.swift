//
//  User.swift
//  MeetLog
//
//  Created by 武林慎太郎 on 2024/02/21.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class User: Identifiable {
    var id: UUID
    var name: String
    var emailAddress: String
    var phoneNumber: String
    var note: String
    var isContacted: Bool
    init(name: String, emailAddress: String, phoneNumber: String, note: String, isContacted: Bool) {
        self.id = UUID()
        self.name = name
        self.emailAddress = emailAddress
        self.phoneNumber = phoneNumber
        self.note = note
        self.isContacted = isContacted
    }
}
