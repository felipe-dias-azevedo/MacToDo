//
//  AddItemView.swift
//  MacToDo
//
//  Created by felipe azevedo on 08/05/22.
//

import SwiftUI

struct AddItemView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [])
    private var categories: FetchedResults<Category>
    
    @State private var itemName = ""
    @State private var itemWhen = Date()
    @State private var categoryIndex = 0
    
    let parentCategory: Category?
    
    var body: some View {
        Form {
            Section(header: Text("Item Fields")) {
                TextField("Value", text: $itemName)
                DatePicker("When", selection: $itemWhen)
                if parentCategory == nil {
                    Picker("Category", selection: $categoryIndex) {
                        ForEach((0..<categories.count), id: \.self) { index in
                            Text(categories[index].name!)
                                .tag(index)
                        }
                    }
                    .pickerStyle(.menu)
                }
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
                        if itemName.isEmpty {
                            return
                        }
                        
                        let newItem = Item(context: viewContext)
                        newItem.value = itemName
                        newItem.when = itemWhen
                        if parentCategory == nil {
                            newItem.category = categories[categoryIndex]
                        } else {
                            newItem.category = categories[categories.firstIndex(of: parentCategory!)!]
                        }
                        
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

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView(parentCategory: nil)
    }
}
