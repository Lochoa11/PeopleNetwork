//
//  UserDetailView.swift
//  PeopleNetwork
//
//  Created by Lin Ochoa on 1/19/25.
//

import SwiftUI

struct UserDetailView: View {
    var user: User
    var body: some View {
        List {
            Text("\(user.name)'s details")
            HStack {
                Text("id:")
                    .bold()
                Text("\(user.id)")
            }
            HStack {
                Text("age:")
                    .bold()
                Text("\(String(user.age))")
            }
            HStack {
                Text("address:")
                    .bold()
                Text("\(user.address)")
            }
            HStack {
                Text("company:")
                    .bold()
                Text("\(user.company)")
            }
            Section("\(user.name)'s about:") {
                Text(user.about)
            }
            HStack {
                Text("Registered on:")
                Text(user.registered.formatted(date: .abbreviated, time: .shortened))
            }
            Section("\(user.name)'s tags:") {
                ForEach(user.tags, id: \.self) { tag in
                    Text("\(tag)")
                }
            }
            Section("This person knows:") {
                ForEach(user.friends) { friend in
                    Text(friend.name)
                }
            }
        }
        .listStyle(.grouped)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let friend = Friend(id: UUID(), name: "hello2")
    let formatter = ISO8601DateFormatter()
    let date = formatter.date(from: "2015-11-10T01:47:18-00:00") ?? .now
      let user = User(id: UUID(), isActive: true, name: "hello", age: 21, company: "hello", email: "hello@hello.com", address: "123 hello lane", about: "hello 123", registered: date, tags: ["hello", "world"], friends: [friend])
    UserDetailView(user: user)
}
