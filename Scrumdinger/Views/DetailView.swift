//
//  DetailView.swift
//  Scrumdinger
//
//  Created by Zoe on 2023/8/31.
//

import SwiftUI

struct DetailView: View {
    let scrum: DailyScrum
    @State private var isPresentEditView = false
    var body: some View {
        List {
            Section(header: Text("Meeting Info")) {
                NavigationLink(destination: MeetingView()) {
                    Label("Start Meeting", systemImage: "timer")
                        .font(.headline)
                    .foregroundColor(.accentColor)
                }
                
                HStack {
                    Label("Length", systemImage: "clock")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                }.accessibilityElement(children: .combine)
                
                HStack {
                    Label("Theme", systemImage: "paintpalette")
                    Spacer()
                    Text(scrum.theme.name)
                        .padding(4)
                        .foregroundColor(scrum.theme.accentColor)
                        .background(scrum.theme.mainColor)
                        .cornerRadius(4)
                }.accessibilityElement(children: .combine)
            }
            
            Section(header: Text("Attendees")) {
                
                ForEach(scrum.attendees) { attendee in
                    Label(attendee.name, systemImage: "person")
                    
                }
                
            }
        }
        .navigationTitle(scrum.title)
        .sheet(isPresented: $isPresentEditView) {
            NavigationStack {
                DetailEditView()
                    .navigationTitle(scrum.title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentEditView = false
                            }
                        }
                        
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentEditView = false
                            }
                        }
                    }
            }
        }
        .toolbar{
            Button("Edit") {
                isPresentEditView = true
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailView(scrum: DailyScrum.sampleData[0])
        }
    }
}
