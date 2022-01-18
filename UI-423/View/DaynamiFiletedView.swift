//
//  DaynamiFiletedView.swift
//  UI-423
//
//  Created by nyannyan0328 on 2022/01/18.
//

import SwiftUI
import CoreData

struct DaynamiFiletedView<Content : View,T>: View where T : NSManagedObject {
    
    @FetchRequest var request : FetchedResults<T>
    
    
    let content : (T) -> Content
    
    init(dateFilterd : Date,@ViewBuilder content : @escaping(T) -> Content) {
        
        
        let calender = Calendar.current
        let today = calender.startOfDay(for: dateFilterd)
        
        let tomorrow = calender.date(byAdding: .day, value: 1, to: today)!
        
        
        let fileterKey = "taskDate"
        
        
        let predicate = NSPredicate(format: "\(fileterKey) >= %@ AND \(fileterKey) < %@", argumentArray: [today,tomorrow])
        
        
        
        
        _request = FetchRequest(entity: T.entity(), sortDescriptors: [.init(keyPath: \Task.taskDate, ascending: false)], predicate: predicate)
        
        self.content = content
        
    }
    
    
    var body: some View {
        Group{
            
            
            if request.isEmpty{
                
                
                Text("No Task")
                    .font(.largeTitle.bold())
                    .offset(y: 100)
            }
            
            else{
                
                
                ForEach(request,id:\.objectID){object in
                    
                    
                    content(object)
                }
            }
        }
    }
}


