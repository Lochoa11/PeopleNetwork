//
//  ContentView.swift
//  PeopleNetwork
//
//  Created by Lin Ochoa on 1/17/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var users: [User] = [User]()
    @State private var usersString: String = ""
    
    var body: some View {
        NavigationStack {
            List{
                //            Text(usersString)
                ForEach(users) { user in
                    Text(user.id)
                    Text(user.isActive ? "I'm active" : "I'm not active")
                    Text(user.name)
                }
                ////                Text(String(user.age))
                ////                Text(user.about)
                ////                Text(user.registered)
                //            }
            }
            .onAppear() {
                Task {
                    await fetchData()
                }
            }
        }
    }
    
//    init(users: [User]) {
//        self.users = users
//    }
    
    func fetchData() async {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            print("Before decodedResponse")
//            print(String(data: data, encoding: .utf8))
            let decodedResponse = try JSONDecoder().decode([User].self, from: data)
//            print(decodedResponse[0])
            users = decodedResponse
            usersString = users.map { user in
                user.name
            }.joined(separator: ",")
            print(usersString)
//            print(users)
            print("End of do block")
        } catch {
//            print("Failed to GET data: \(error.localizedDescription)")
            print(String(describing: error))
        }
    }
}

#Preview {
//    let friend = Friend(id: "321", name: "hello2")
//    let user = User(id: "123", isActive: true, name: "hello", age: 21, company: "hello", email: "hello@hello.com", address: "123 hello lane", about: "hello 123", registered: "2015-11-10T01:47:18-00:00", tags: ["hello", "world"], friends: [friend])
    ContentView()
}
