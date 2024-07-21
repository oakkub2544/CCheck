//
//  AddListView.swift
//  CCheck
//
//  Created by Kanawat Rungwattanachai on 21/7/2567 BE.
//

import SwiftUI

struct AddListView: View {
    //MARK: - Properties
    @Environment(\.managedObjectContext) var context
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var name: String = ""
    @State private var category: String = ""
    @State private var priority: String = "Normal"
    
    let priorities = ["High","Normal","Low"]
    
    //Disable button when textfield is nil
    private var isButtonDisabled: Bool {
        name.isEmpty
    }
    
    //MARK: - Function
    //Add Item
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.name = name
            newItem.priority = priority
            newItem.category = category
            newItem.id = UUID()

            do {
                try viewContext.save()
                name = ""
                priority = "Normal"
                presentationMode.wrappedValue.dismiss()
            } catch {
                // Print detailed error information
                let nsError = error as NSError
                print("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    
    
    
    //MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    //Name
                    TextField("New List", text: $name)
                        .frame(width: 326,height: 40)
                    
                    //Category
                    TextField("Category (Optional)", text: $category)
                        .frame(width: 326,height: 40)
                    
                    //Priority
                    Picker("Priority", selection: $priority) {
                        ForEach(priorities, id: \.self) {
                            Text($0)
                        }
                    }
                    .frame(width: 326,height: 40)
                    .pickerStyle(SegmentedPickerStyle())
                    
                    //Save Button
                    HStack {
                        Spacer()
                        Button(action: {
                            addItem()
                        }) {
                            Text("Save")
                        }
                        .disabled(isButtonDisabled)
                        .padding()
                        .frame(width: 326, height: 56)
                        .fontWeight(.bold)
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .background(isButtonDisabled ? Color.gray : Color("ColorPrimary"))
                        .cornerRadius(8)
                        Spacer()
                    }//:HStack
                }//:Form
                Spacer()
            }//:VStack
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Add List")
                        .font(.title2)
                        .bold()
                }
            }
            //Close bottom sheet
            .navigationBarItems(trailing:
                                    Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }){
                Image(systemName: "xmark")
                    .foregroundColor(Color("ColorPrimary"))
            }
            )
        }//:Navigition
    }
}

#Preview {
    AddListView()
}
