//
//  PeopleNetworkApp.swift
//  PeopleNetwork
//
//  Created by Lin Ochoa on 1/17/25.
//

import SwiftData
import SwiftUI

@main
struct PeopleNetworkApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
