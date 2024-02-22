//
//  ProspectView.swift
//  MeetLog
//
//  Created by 武林慎太郎 on 2024/02/21.
//

import SwiftUI
import SwiftData
import CodeScanner

struct UserListView: View {
    @Query private var users: [User]
    @Environment(\.modelContext) var modelContext
    @State private var selectedUsers = Set<User>()
    @Environment(\.editMode) var editMode
    @State private var isShowingScanner = false
    var filter: FilterState
    
    enum FilterState {
        case none, contacted, nocontacted
    }
    
    var body: some View {
        NavigationStack {
            List(users, selection: $selectedUsers) { user in
                NavigationLink(destination: UserDetailView(user: user, editUserInfo: { newUser in
                    user.name = newUser.name
                    user.emailAddress = newUser.emailAddress
                    user.phoneNumber = newUser.phoneNumber
                    user.note = newUser.note
                    user.isContacted = newUser.isContacted
                })) {
                    VStack(alignment: .leading) {
                        Text(user.name)
                        Text(user.emailAddress)
                        Text(user.phoneNumber)
                    }
                }
                .swipeActions {
                    if user.isContacted {
                        Button("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark") {
                            user.isContacted.toggle()
                        }
                        .tint(.blue)
                    } else {
                        Button("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark") {
                            user.isContacted.toggle()
                        }
                        .tint(.green)
                    }
                }
                .tag(user)
            }
            .navigationTitle("UserList")
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\npaul@hackingwithswift.com", completion: handleScan)
            }
            .toolbar {
                ToolbarItem {
                    Button("Scan", systemImage: "qrcode.viewfinder") {
                        isShowingScanner = true
                    }
                }
                ToolbarItem {
                    if editMode?.wrappedValue == .inactive {
                        Button(action: {
                            let user = User(name: "taro", emailAddress: "taro@icloud.com", phoneNumber: "00-000-0000-0000", note: "this is taro", isContacted: false)
                            modelContext.insert(user)
                        }, label: {
                            Label("Add User", systemImage: "person.crop.circle")
                        })
                    } else {
                        EmptyView()
                    }
                }
                ToolbarItem {
                    EditButton()
                }
                ToolbarItem {
                    if selectedUsers.isEmpty == false {
                        Button("delete") {
                            for user in selectedUsers {
                                modelContext.delete(user)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError> ) {
        isShowingScanner = false
        // more code to come
         switch result {
         case .success(let result):
             let details = result.string.components(separatedBy: "\n")
             guard details.count == 4 else {
                 print("Debug: result details are not 4 count")
                 return
             }

             let user = User(name: details[0], emailAddress: details[1], phoneNumber: details[2], note: details[3], isContacted: false)

             modelContext.insert(user)
         case .failure(let error):
             print("Scanning failed: \(error.localizedDescription)")
         }
    }

    init(filter: FilterState) {
        self.filter = filter

        if filter != .none {
            let showContactedOnly = filter == .contacted

            _users = Query(filter: #Predicate {
                $0.isContacted == showContactedOnly
            }, sort: [SortDescriptor(\User.name)])
        }
    }
}

#Preview {
    UserListView(filter: .none)
}
