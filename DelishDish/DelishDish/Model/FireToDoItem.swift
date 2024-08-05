//
//  FireToDoItem.swift
//  DelishDish
//
//  Created by Volkan Yücel on 19.07.24.
//

import Foundation
import FirebaseFirestoreSwift


struct FireToDoItem: Codable, Identifiable {
    var title: String
    var description: String
    var isCompleted: Bool
    let userId: String
    var sharedWith: [String] = []
    
    @DocumentID var id: String?
}
