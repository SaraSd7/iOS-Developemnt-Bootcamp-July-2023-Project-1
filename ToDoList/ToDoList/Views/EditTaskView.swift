//
//  EditTaskView.swift
//  ToDoList
//
//  Created by Sara Sd on 17/01/1445 AH.
//

import SwiftUI

struct EditTaskView: View {
    
    @State var title: String = ""
    @State var description: String = ""
    @State var priority: TaskPriority = .low
    @State var backlog: TaskBacklog = .backlog
    
    
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.dismiss) var dismiss
    var taskCoreData: TaskCoreData?
    init(taskCoreData: TaskCoreData?) {
        self.taskCoreData = taskCoreData
        _title = State(initialValue: taskCoreData?.title ?? "")
        _description = State(initialValue: taskCoreData?.discription ?? "")
        _priority = State(initialValue: TaskPriority(rawValue: taskCoreData?.priority ?? "") ?? .low)
        _backlog = State(initialValue: TaskBacklog(rawValue: taskCoreData?.backLog ?? "") ?? .backlog)
    }
    var body: some View {
        Form {
            Section {
                TextField("Add New Task", text: $title)
            } header: {
                Text("Title")
            }
            Section {
                TextField("Add New Description", text: $description)
            } header: {
                Text("Discription")
            }
            Section {
                Picker(selection: $priority) {
                    ForEach(TaskPriority.allCases,id: \.self) { priority in
                        Button {
                            self.priority = priority
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
                Picker(selection: $backlog) {
                    ForEach(TaskBacklog.allCases,id:  \.self) { backlog in
                        Button {
                            self.backlog = backlog
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
                if let updatedTaskCoreData = taskCoreData {
                    updatedTaskCoreData.title = title
                    updatedTaskCoreData.discription = description
                    updatedTaskCoreData.priority = priority.rawValue
                    updatedTaskCoreData.backLog = backlog.title
                    if backlog == .done {
                        viewContext.delete(updatedTaskCoreData)
                    }
                    do {
                        try viewContext.save()
                        dismiss.callAsFunction()
                    } catch {
                        
                    }
                }
                
            } label: {
                HStack{
                    Spacer()
                    Text("Update Task")
                    Spacer()
                }
                .foregroundColor(.white)
            }
            .buttonStyle(.borderless)
            .listRowBackground(Color.blue)
            
        }
        .navigationTitle("Update")
    }
}

struct EditTaskView_Previews: PreviewProvider {
    static var previews: some View {
        EditTaskView(taskCoreData: .init())
            .environment(\.managedObjectContext, CoreDataManager.shared.container.viewContext)
    }
}
