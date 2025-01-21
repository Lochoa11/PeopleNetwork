//
//  ContentView.swift
//  PeopleNetwork
//
//  Created by Lin Ochoa on 1/17/25.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query(sort: \User.name) private var users: [User]
    
    @State private var usersString: String = ""
    
    var body: some View {
        NavigationStack {
            List(users){ user in
                NavigationLink(value: user) {
                    HStack {
                        Text(user.isActive ? "🟢" : "🔴")
                        Text(user.name)
                    }
                }
            }
            .navigationTitle("People Network")
            .task {
                await fetchData()
            }
            .navigationDestination(for: User.self) { user in
                UserDetailView(user: user)
            }
        }
    }
    
    func fetchData() async {
        guard users.isEmpty else {
            return
        }
        do {
            print("Fetching data")
            let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "GET"
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let temp = try decoder.decode([User].self, from: data)
            let insertContext = ModelContext(modelContext.container)
            
            for user in temp {
                insertContext.insert(user)
            }
            
            try insertContext.save()
        } catch {
            print(String(describing: error))
        }
    }
}

#Preview {
    ContentView()
}
