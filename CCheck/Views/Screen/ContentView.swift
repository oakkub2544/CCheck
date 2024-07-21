//
//  ContentView.swift
//  CCheck
//
//  Created by Kanawat Rungwattanachai on 20/7/2567 BE.
//

import SwiftUI
import CoreData

struct ContentView: View {
    //MARK: - Property
    @State private var showingAddListView: Bool = false
    @State private var showingSettingView: Bool = false
    @State private var animatingButton: Bool = false
    @Environment(\.managedObjectContext) private var viewContext
    
    // Fetching data
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.name, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    //MARK: - Functions
    // Delete
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    // Color for priority
    private func colorize(priority: String) -> Color {
        switch priority {
        case "High":
            return .pink
        case "Normal":
            return .green
        case "Low":
            return .blue
        default:
            return .gray
        }
    }
    
    //MARK: - Body
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach(items, id: \.self) { item in
                        HStack {
                            Circle()
                                .frame(width: 12, height: 12, alignment: .center)
                                .foregroundColor(self.colorize(priority: item.priority ?? "Normal"))
                            // Don't have Category
                            if item.category != nil && item.category != "" {
                                VStack(alignment: .leading) {
                                    Text(item.name ?? "")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                    
                                    Text(item.category ?? "")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                        .padding(.leading,0)
                                }
                                .padding(.leading, 8)
                            } else {
                                Text(item.name ?? "")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .frame(height: 40)
                                    .padding(.leading, 8)
                            }
                            Spacer()
                            
                            Text(item.priority ?? "Unknown")
                                .font(.footnote)
                                .foregroundColor(Color(UIColor.systemGray2))
                                .padding(3)
                                .frame(minWidth: 62)
                                .overlay(
                                    Capsule().stroke(Color(UIColor.systemGray2), lineWidth: 0.75)
                                )
                                
                        }
                    }
                    .onDelete(perform: deleteItems)
                } //: List
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("CCheck")
                            .font(.title2)
                            .bold()
                    }
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                            .padding(.leading, 8)
                            .foregroundColor(Color("ColorPrimary"))
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            self.showingSettingView.toggle()
                        }) {
                            Image(systemName: "gearshape.fill")
                                .font(.system(size: 16))
                                .padding(.trailing, 8)
                                .foregroundColor(Color("ColorPrimary"))
                        }
                    }
                }
                .navigationDestination(isPresented: $showingSettingView) {
                    SettingView()
                        .navigationBarBackButtonHidden(true)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button(action: {
                                    showingSettingView = false
                            }) {
                                HStack {
                                    Image(systemName: "chevron.backward")
                                        .foregroundColor(Color("ColorPrimary"))
                                    Text("Back")
                                        .foregroundColor(Color("ColorPrimary"))
                                }
                            }
                        }
                    }
                }

                //MARK: - No one List
                if items.count == 0 {
                    NoOneListView()
                }
                // Add Button
                Button(action: {
                    self.showingAddListView.toggle()
                }) {
                    AddButtonView()
                } //: BUTTON
                .accentColor(Color("ColorPrimary"))
                .onAppear(perform: {
                    self.animatingButton.toggle()
                })
                .sheet(isPresented: $showingAddListView) {
                    AddListView()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .padding(.bottom, 16)
                .padding(.trailing, 16)
            } //: ZStack
        } //: NavigationStack
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
