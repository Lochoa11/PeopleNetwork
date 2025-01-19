//
//  Friend.swift
//  PeopleNetwork
//
//  Created by Lin Ochoa on 1/17/25.
//

import Foundation

struct Friend: Decodable, Identifiable, Hashable {
    let id: UUID
    var name: String
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}
