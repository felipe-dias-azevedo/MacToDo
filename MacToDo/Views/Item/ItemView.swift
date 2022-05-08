//
//  ItemView.swift
//  MacToDo
//
//  Created by felipe azevedo on 08/05/22.
//

import SwiftUI

struct ItemView: View {
    
    @Environment(\.managedObjectContext) private var viewContext

    @State private var items: [Item]
    @State private var textSearch = ""
    @State private var showAddNewItem = false
    
    let parentCategory: Category
    
    init(parentCategory: Category) {
        self.parentCategory = parentCategory
        self.items = []
    }
    
    private var searchResults: [Item] {
        if textSearch.isEmpty {
            return items.sorted(by: { $0.value! > $1.value! })
        } else {
            return items.filter { $0.value!.contains(textSearch) }.sorted(by: { $0.value! > $1.value! })
        }
    }
    
    func updateItems() {
        let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        fr.predicate = NSPredicate(format: "category.name == %@", parentCategory.name!)
        items.append(contentsOf: (try! viewContext.fetch(fr) as! [Item]).filter({ !items.map({ $0.value! }).contains($0.value!) }))
    }
    
    var body: some View {
        VStack {
            if items.isEmpty {
                VStack {
                    Text("You have no Items...")
                    Button {
                        showAddNewItem = true
                    } label: {
                        Text("Add a New One!")
                    }
                }
            } else {
                List(searchResults) { item in
                    HStack {
                        Text(item.value!)
                            .fontWeight(.medium)
                        
                        Text(DateHelper.toString(item.when!))
                            .font(.subheadline)
                    }
                }
            }
        }
        .navigationTitle("Items in \(parentCategory.name!)")
        .searchable(text: $textSearch)
        .toolbar {
            ToolbarItemGroup(placement: .automatic) {
                Button {
                    showAddNewItem = true
                } label: {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $showAddNewItem, onDismiss: {
            updateItems()
        }) {
            AddItemView(parentCategory: parentCategory)
        }
        .onAppear {
            updateItems()
        }
    }
}

//struct ItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemView()
//    }
//}
