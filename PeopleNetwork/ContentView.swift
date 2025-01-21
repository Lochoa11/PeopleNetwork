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
    
    @Query private var users: [User]
    
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
                    if !users.isEmpty {
                        return
                    } else {
                        await fetchData()
                    }
                }
            }
            .navigationDestination(for: User.self) { user in
                UserDetailView(user: user)
            }
        }
    }
    
    func fetchData() async {
//        guard users.isEmpty else {
//            return
//        }
        print("Fetching data")
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let temp: [User] = try decoder.decode([User].self, from: data)
            for user in temp {
                modelContext.insert(user)
            }
        } catch {
            print(String(describing: error))
        }
    }
}

#Preview {
    ContentView()
}
