//
//  Friend.swift
//  PeopleNetwork
//
//  Created by Lin Ochoa on 1/17/25.
//

import Foundation
import SwiftData

@Model
class Friend: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }

    let id: UUID
    var name: String
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
    }
}
