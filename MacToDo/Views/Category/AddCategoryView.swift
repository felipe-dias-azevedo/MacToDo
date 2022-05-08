//
//  AddCategoryView.swift
//  MacToDo
//
//  Created by felipe azevedo on 08/05/22.
//

import SwiftUI

struct AddCategoryView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var categoryName = ""
    
    var body: some View {
        Form {
            Section(header: Text("Category Fields")) {
                TextField("Name", text: $categoryName)
            }
            
            Section {
                Spacer()
                HStack(alignment: .bottom, spacing: 12) {
                    Spacer()
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel")
                    }
                    Button {
                        if categoryName.isEmpty {
                            return
                        }
                        
                        let newCategory = Category(context: viewContext)
                        newCategory.name = categoryName
                        
                        try! viewContext.save()
                        viewContext.refreshAllObjects()
                        
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Add")
                    }
                }
            }
        }
        .frame(width: 300, height: 200, alignment: .topLeading)
        .padding()
    }
}

struct AddCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddCategoryView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
