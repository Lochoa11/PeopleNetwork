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
                ForEach(users) { user in
                    NavigationLink(value: user) {
                        HStack {
                            Text(user.isActive ? "🟢" : "🔴")
                            Text(user.name)
                        }
                    }
                }
            }
            .navigationTitle("People Network")
            .onAppear() {
                Task {
                    await fetchData()
                }
            }
            .navigationDestination(for: User.self) { user in
                UserDetailView(user: user)
            }
        }
    }
    
    func fetchData() async {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            print("Before decodedResponse")
            let decodedResponse = try JSONDecoder().decode([User].self, from: data)
            users = decodedResponse
            print("End of do block")
        } catch {
            print(String(describing: error))
        }
    }
}

#Preview {
    ContentView()
}
