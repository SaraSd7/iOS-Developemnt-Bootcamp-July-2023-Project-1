//
//  DataViewModel.swift
//  ToDoList
//
//  Created by Sara Sd on 19/01/1445 AH.
//

import Foundation
import SwiftUI

class DataViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var selectedBackLog: String = ""
    @AppStorage("isDark") var isDark: Bool = false
    
    
    func showPriority(_ priority: String) -> Color {
        switch priority {
        case "low":
            return .gray
        case "medium":
            return .yellow
        case "high":
            return .red
        default:
            return .clear
        }
    }
}


