//
//  MyProfileView.swift
//  MeetLog
//
//  Created by 武林慎太郎 on 2024/02/21.
//

import SwiftUI
import CodeScanner
import SwiftData
import CoreImage.CIFilterBuiltins

struct MyProfileView: View {
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    @AppStorage("name") private var name = "Anonymous"
    @AppStorage("emailAddress") private var emailAddress = "you@yoursite.com"
    @AppStorage("phoneNumber") private var phoneNumber = "000-0000-0000"
    @AppStorage("note") private var note = "this is note"
    @State private var qrCode = UIImage()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        Spacer()
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                        Spacer()
                    }
                    TextField("Name", text: $name)
                        .textContentType(.name)
                    TextField("Email Address", text: $emailAddress)
                        .textContentType(.emailAddress)
                    TextField("Phone Number", text: $phoneNumber)
                        .textContentType(.telephoneNumber)
                }
                
                Section(header: Text("Note")) {
                    TextField("Enter your note here", text: $note)
                }
                
                Section(header: Text("Your QRCode here")) {
                    HStack {
                        Spacer()
                        Image(uiImage: qrCode)
                            .interpolation(.none)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                        Spacer()
                    }
                }
            }
            .onAppear(perform: updateCode)
            .onChange(of: name, updateCode)
            .onChange(of: emailAddress, updateCode)
            .onChange(of: phoneNumber, updateCode)
            .onChange(of: note, updateCode)
            .navigationBarTitle("Profile")
        }
    }
    func updateCode() {
        qrCode = generateQRCode(from: "\(name)\n\(emailAddress)\n\(phoneNumber)\n\(note)")
    }
    
    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)

        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

#Preview {
    MyProfileView()
}
