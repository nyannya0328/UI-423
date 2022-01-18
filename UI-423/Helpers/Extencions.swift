//
//  Extencions.swift
//  UI-423
//
//  Created by nyannyan0328 on 2022/01/18.
//

import SwiftUI

extension View{
    
    func lLeading()->some View{
        
        self
            .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .leading)
    }
    
    func getSafeArea()->UIEdgeInsets{
        
        
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{return .zero}
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else{return .zero}
        
        
        return safeArea
        
    }
    
  
    
}
