//
//  AddTaskView.swift
//  ToDoList
//
//  Created by Sara Sd on 17/01/1445 AH.
//

import SwiftUI

struct AddTaskView: View {
    
    @State var newTask: Task = .init(title: "", description: "", priority: .low, backLog: .backlog)
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Form {
            Section {
                TextField("Add New Task", text: $newTask.title)
            } header: {
                Text("Title")
            }
            Section {
                TextField("Add New Description", text: $newTask.description)
            } header: {
                Text("Discription")
            }
            Section {
                Picker(selection: $newTask.priority) {
                    ForEach(TaskPriority.allCases,id: \.self) { priority in
                        Button {
                            newTask.priority = priority
                        } label: {
                            Text(priority.rawValue)
                        }
                    }
                } label: {
                    Text("Selected Priority:")
                }
                
            } header: {
                Text("Priority")
            }
            
            Section {
                Picker(selection: $newTask.backLog) {
                    ForEach(TaskBacklog.allCases,id:  \.self) { backlog in
                        Button {
                            newTask.backLog = backlog
                        } label: {
                            Text(backlog.title)
                        }
                    }
                } label: {
                    Text("Selected Status:")
                }
            } header: {
                Text("status")
            }
            Button {
                let task = TaskCoreData(context: viewContext)
                task.title = newTask.title
                task.discription = newTask.description
                task.priority = newTask.priority.rawValue
                task.backLog = newTask.backLog.title
                do {
                    try viewContext.save()
                    dismiss.callAsFunction()
                } catch {
                    
                }
            } label: {
                HStack{
                    Spacer()
                    Text("Add Task")
                    Spacer()
                }
                .foregroundColor(.white)
            }
            .buttonStyle(.borderless)
            .listRowBackground(Color.blue)
            
        }
        .navigationTitle("Add New Task")
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            AddTaskView()
        }
    }
}
