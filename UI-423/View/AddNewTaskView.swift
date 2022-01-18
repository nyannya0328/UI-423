//
//  AddNewTaskView.swift
//  UI-423
//
//  Created by nyannyan0328 on 2022/01/18.
//

import SwiftUI
import CoreData

struct AddNewTaskView: View {
    
    @Environment(\.dismiss) var dissmiss
    
    @Environment(\.managedObjectContext) var context
    
    
    @State var taskTilte : String = ""
    @State var taskDescription : String = ""
    @State var taskDate : Date = Date()
    
    @EnvironmentObject var model : TaskViewModel
    var body: some View {
        NavigationView{
            
            
            List{
                
                
                Section {
                    
                    
                    TextField("Go to Work", text: $taskTilte)
                    
                } header: {
                    
                    Text("Add New Title")
                    
                }
                
                Section {
                    
                    
                    TextField("Nothing", text: $taskDescription)
                    
                } header: {
                    
                    Text("DESCRIPTION")
                    
                }
                
                
                if model.editeTask == nil{
                    
                    
                    
                    Section {
                        
                        
                     DatePicker("", selection: $taskDate)
                            .datePickerStyle(.graphical)
                            .labelsHidden()
                        
                        
                    } header: {
                        
                        Text("Choose Day")
                        
                    }

                    
                    
                    
                }


                
                
            }
            .listStyle(.insetGrouped)
            .navigationTitle("New Task")
            .interactiveDismissDisabled()
            .toolbar {
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    Button {
                        
                        
                        if let task = model.editeTask{
                            
                            
                            task.taskTitle = taskTilte
                            task.taskDescription = taskDescription
                            
                        }
                        
                        else{
                          
                            
                            let task = Task(context: context)
                            
                            task.taskTitle = taskTilte
                            task.taskDescription = taskDescription
                            task.taskDate = taskDate
                            
                            
                            
                            
                            
                        }
                        
                        try? context.save()
                        dissmiss()
                        
                        
                    } label: {
                        
                        
                        Text("Save")
                            .fontWeight(.black)
                            .foregroundColor(.black)
                            .padding(10)
                            .background(
                            
                                Capsule()
                                    .stroke(.blue,lineWidth: 2)
                                    
                                
                            
                            )
                    }
                    
                }
                
                
                ToolbarItem(placement: .navigationBarLeading) {
                    
                    Button {
                        
                        
                        dissmiss()
                        
                        
                    } label: {
                        
                        
                        Text("Cancel")
                            .fontWeight(.black)
                            .foregroundColor(.black)
                            .padding(10)
                            .background(
                            
                                Capsule()
                                    .stroke(.red,lineWidth: 2)
                                    
                                
                            
                            )
                    }
                    

                    
                    
                }
            }
            .onAppear {
                
                if let task = model.editeTask{
                    
                    
                    taskTilte = task.taskTitle ?? ""
                    taskDescription = task.taskDescription ?? ""
                    
                }
                
            }
            
            
            
        }
    }
}

struct Add_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

