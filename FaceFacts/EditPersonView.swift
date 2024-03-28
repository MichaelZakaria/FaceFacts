//
//  EditPersonView.swift
//  FaceFacts
//
//  Created by Marco Zakaria on 27/03/2024.
//

import PhotosUI
import SwiftUI
import SwiftData

struct EditPersonView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var person: Person
    @Binding var navigationPath: NavigationPath
    @State private var selectedItem: PhotosPickerItem?
    
    @Query(sort: [
        SortDescriptor(\Event.name),
        SortDescriptor(\Event.Location)
    ]) var events: [Event]
    
    var body: some View {
        Form {
            Section {
                if let imageData = person.photo, let
                    uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                }
                
                PhotosPicker(selection: $selectedItem, matching: .images) {
                    Label("Select a photo", systemImage: "person")
                }
            }
            
            Section {
                TextField("Name", text: $person.name)
                    .textContentType(.name)
                
                TextField("Email Address", text: $person.emailAddress)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
            }
            
            Section("Where did you meet them?") {
                Picker("Met at", selection: $person.metAt) {
                    Text("Unkown event")
                        .tag(Optional<Event>.none)
                    
                    if events.isEmpty == false {
                        Divider()
                        
                        ForEach (events) { event in
                            Text(event.name)
                                .tag(Optional(event))
                        }
                    }
                }
                    Button("Add a new event", action: addEvent)
            }
            
            Section("Notes") {
                TextField("Details about this person", text: $person.details, axis: .vertical)
            }
        }
        .navigationTitle("Edit Person")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: Event.self) { event in
                EditEventView(event: event)
        }
        .onChange(of: selectedItem, loadPhoto)
    }
    
    func addEvent() {
        let event = Event(name: "", Location: "")
        modelContext.insert(event)
        navigationPath.append(event)
    }
    
    func loadPhoto() {
        Task { @MainActor in
            person.photo = try await
            selectedItem?.loadTransferable(type: Data.self)
        }
    }
}
    
//#Preview {
//    EditPersonView()
//}
