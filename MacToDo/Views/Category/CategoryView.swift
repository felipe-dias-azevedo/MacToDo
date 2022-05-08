//
//  CategoryView.swift
//  MacToDo
//
//  Created by felipe azevedo on 08/05/22.
//

import SwiftUI

struct CategoryView: View {
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(sortDescriptors: [])
    private var categories: FetchedResults<Category>
    
    @State private var showAddNewCategory = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(categories) { category in
                    NavigationLink {
                        ItemView(parentCategory: category)
                    } label: {
                        Text(category.name!)
                    }
                    
                }
                .onDelete(perform: { offsets in
                    withAnimation {
                        offsets.map { categories[$0] }.forEach(viewContext.delete)

                        try! viewContext.save()
                    }
                })
            }
            .navigationTitle("Categories")
            .toolbar {
                ToolbarItemGroup(placement: .automatic) {
                    Button {
                        showAddNewCategory = true
                    } label: {
                        Label("Add Category", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddNewCategory) {
                AddCategoryView()
            }
        }
        .navigationViewStyle(.columns)
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
