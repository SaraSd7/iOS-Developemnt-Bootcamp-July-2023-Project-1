//
//  ContentView.swift
//  ToDoList
//
//  Created by Sara Sd on 17/01/1445 AH.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var dataViewModel = DataViewModel()
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(sortDescriptors: [], animation: .default) var myCoreDataTasks: FetchedResults <TaskCoreData>
    
    func filterTasksBasedOn(_ title: String) -> [TaskCoreData] {
        if dataViewModel.searchText.isEmpty {
            return myCoreDataTasks.shuffled()
        } else {
            return myCoreDataTasks.filter { taskCoreData in
                (taskCoreData.title ?? "").lowercased().contains(title.lowercased())
            }
        }
    }
    var body: some View {
        NavigationStack {
            List{
                ForEach(dataViewModel.selectedBackLog.isEmpty ? filterTasksBasedOn(dataViewModel.searchText) : filterTasksBasedOn(dataViewModel.searchText).filter{$0.backLog ?? "" == dataViewModel.selectedBackLog}, id: \.id) { task in
                    NavigationLink {
                        EditTaskView(taskCoreData: task)
                    } label: {
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text(task.title ?? "")
                                Spacer()
                                Text(task.priority ?? "")
                                dataViewModel.showPriority(task.priority ?? "")
                                    .frame(width: 20, height: 20, alignment: .center)
                                    .clipShape(Circle())
                            }
                            Text(task.backLog ?? "")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        }
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button {
                            viewContext.delete(task)
                            do{
                                try viewContext.save()
                            } catch {
                                
                            }
                        } label: {
                            Image(systemName: "trash")
                        }
                        .tint(.red)
                    }
                }
            }
            .navigationTitle("To Do List")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dataViewModel.isDark.toggle()
                    } label: {
                        Image(systemName: dataViewModel.isDark ? "sun.min" : "moon")
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Menu {
                            
                            Button {
                                dataViewModel.selectedBackLog = ""
                            } label: {
                                Text("Show All")
                            }
                            Button {
                                dataViewModel.selectedBackLog = TaskBacklog.backlog.title
                            } label: {
                                Text("BackLog")
                            }
                            Button {
                                dataViewModel.selectedBackLog = TaskBacklog.todo.title
                            } label: {
                                Text("Todo")
                            }
                            Button {
                                dataViewModel.selectedBackLog = TaskBacklog.inProgress.title
                            } label: {
                                Text("InProgress")
                            }
                            Button {
                                dataViewModel.selectedBackLog = TaskBacklog.done.title
                            } label: {
                                Text("Done")
                            }
                            
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease.circle")
                        }
                        
                        NavigationLink {
                            AddTaskView()
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
        }
        .searchable(text: $dataViewModel.searchText)
        .environment(\.colorScheme, dataViewModel.isDark ? .dark : .light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, CoreDataManager.shared.container.viewContext)
    }
}
