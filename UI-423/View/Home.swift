//
//  Home.swift
//  UI-423
//
//  Created by nyannyan0328 on 2022/01/18.
//

import SwiftUI

struct Home: View {
    @StateObject var model = TaskViewModel()
    @Namespace var animaiton
    
    @Environment(\.managedObjectContext) var context
    
    @Environment(\.editMode) var editButton
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            Section {
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    
                    
                    HStack{
                        
                        ForEach(model.currentWeek,id:\.self){day in
                            
                            
                            VStack(spacing:15){
                                
                                Text(model.exeTractDate(date: day, formatted: "dd"))
                                    .font(.system(size: 13, weight: .semibold))
                                
                                Text(model.exeTractDate(date: day, formatted: "EEE"))
                                    .font(.system(size: 13, weight: .semibold))
                                
                                
                                Capsule()
                                    .fill(.white)
                                    .frame(width: 10, height: 10)
                                    .opacity(model.isToday(date: day) ? 1 : 0)
                                
                                
                                
                            }
                           
                            .foregroundStyle(model.isToday(date: day) ? .primary : .tertiary)
                            .foregroundColor(model.isToday(date: day) ? .white : .black)
                            .frame(width: 38, height: 100)
                            .background(
                            
                            
                                ZStack{
                                    
                                    if model.isToday(date: day){
                                        
                                        Capsule()
                                            .fill(.black)
                                            .matchedGeometryEffect(id: "TAB", in: animaiton)
                                        
                                        
                                    }
                                    
                                    
                                    
                                    
                                }
                            
                            )
                            .contentShape(Capsule())
                            .onTapGesture {
                                
                                withAnimation{
                                    
                                    
                                    model.currentDay = day
                                }
                                
                            }
                            
                            
                            
                        }
                        
                        
                        
                    }
                    .padding(.horizontal)
                    
                    
                    
                    
                }
                
                
                TaskView()
                
                
                
            } header: {
                
                
                HeaderView()
                
                
            }

            
        }
        .overlay(
        
            Button(action: {
                withAnimation{
                    
                    
                    model.addNewTask.toggle()
                }
            }, label: {
                
                Image(systemName: "plus")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(20)
                    .background(Color.black,in: Circle())
                
                
                
            })
                .padding(.trailing,10)
            
            ,alignment: .bottomTrailing
        
        )
        .sheet(isPresented: $model.addNewTask) {
            
            
            model.editeTask = nil
            
            
        } content: {
                
            AddNewTaskView()
                .environmentObject(model)
            
            
        }

    }
    
    func TaskCardView(task : Task)->some View{
        
        HStack(alignment: editButton?.wrappedValue == .active ? .center : .top, spacing: 10){
            
            
            if editButton?.wrappedValue == .active{
                
                
                
                VStack(spacing:20){
                    
                    if task.taskDate?.compare(Date()) == .orderedDescending || Calendar.current.isDateInToday(task.taskDate ?? Date()){
                        
                        
                        Button {
                            
                            
                            withAnimation{
                                
                                model.editeTask = task
                                model.addNewTask.toggle()
                                
                                
                            }
                            
                            
                            
                        } label: {
                            
                            
                            Image(systemName: "pencil.circle.fill")
                                .font(.title3)
                                .foregroundColor(.white)
                                .padding(3)
                                .background(Color.black,in: Circle())
                            
                            
                            
                        }
                        
                        Button {
                            
                            withAnimation{
                                
                                
                                context.delete(task)
                                try? context.save()
                            }
                            
                          
                            
                            
                            
                        } label: {
                            
                            
                            Image(systemName: "minus.circle.fill")
                                .font(.title3)
                                .foregroundColor(.white)
                                .padding(3)
                                .background(Color.red,in: Circle())
                            
                        }
                        
                        
                        
                    }
                    
                    
                  
                    
                    
                    
                }

                
                
            }
            
            else{
                
                
                VStack{
                    
                    Circle()
                        .fill(model.iscurrentHour(date: task.taskDate ?? Date()) ? (task.isCompleted ? .green : .black) : .clear)
                        .frame(width: 15, height: 15)
                        .background(
                        
                        Circle()
                            .stroke(.black,lineWidth: 1)
                            .padding(-3)
                            .scaleEffect(model.iscurrentHour(date: task.taskDate ?? Date()) ? 0.7 : 1)
                        
                        
                        
                        
                        
                        )
                    
                  Rectangle()
                        .fill(model.iscurrentHour(date: task.taskDate ?? Date()) ? .green : .black)
                        .frame(width: 3)
                }
                
            }
            
          
          
            
            
            
            VStack{
                
                
                HStack(alignment: .top, spacing: 10) {
                    
                    
                    VStack(alignment: .leading, spacing: 13) {
                        
                        Text(task.taskTitle ?? "")
                            .font(.title.weight(.light))
                        
                        Text(task.taskDescription ?? "")
                            .font(.title.weight(.light))
                            .foregroundColor(.gray)
                        
                        
                    }
                    .lLeading()
                    
                    
                    Text(task.taskDate?.formatted(date: .abbreviated, time: .omitted) ?? "")
                        .font(.caption.weight(.semibold))
                    
                    
                    
                }
                
                
                if model.iscurrentHour(date: task.taskDate ?? Date()){
                    
                    
                    HStack(spacing:10){
                        
                        if !task.isCompleted{
                            
                            
                            Button {
                                
                                task.isCompleted = true
                                
                                try? context.save()
                                
                            } label: {
                                
                                
                                Image(systemName: "checkmark")
                                    .font(.title)
                                   
                                    .padding()
                                    .background(Color.gray,in:RoundedRectangle(cornerRadius: 10))
                                
                                
                                
                            }
                            

                            
                            
                            
                        }
                        
                        
                        Text(task.isCompleted ? "Marked as Completed" : "Mark Task as Completed")
                            .font(.system(size: task.isCompleted ? 15 : 17, weight: .light))
                            .foregroundColor(task.isCompleted ?  .gray : .white)
                            .lLeading()
                           
                       
                        
                        
                        
                        
                        
                    }
                    
                }
                
                
                
            }
            .foregroundColor(model.iscurrentHour(date: task.taskDate ?? Date()) ? .white : .black)
            .padding(model.iscurrentHour(date: task.taskDate ?? Date()) ? 15 : 0)
            .padding(.bottom, model.iscurrentHour(date: task.taskDate ?? Date()) ? 10 : 0)
            .lLeading()
            .background(
            
                Color.black.cornerRadius(25)
                    .opacity(model.iscurrentHour(date: task.taskDate ?? Date()) ? 1 : 0)
            
            
            )
            
            
            
        }
        
        
    }
    
    
    func TaskView()->some View{
        
        DaynamiFiletedView(dateFilterd: model.currentDay) { (object : Task) in
            
            TaskCardView(task: object)
            
            
        }
        .padding()
        .padding(.top,10)
        
        
    }
    
    func HeaderView()->some View{
        
        
        HStack{
            
            VStack(alignment: .leading, spacing: 13) {
                
                
                Text(Date().formatted(date: .abbreviated, time: .omitted))
                    .font(.title3.weight(.light))
                    
                Text("Today")
                    .font(.title3.weight(.light))
                    
                
            }
            .lLeading()
            
            
        EditButton()
            
            
            
        }
        .padding()
        .padding(.top)
        .background(Color.white)
        
        
        
        
    }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
