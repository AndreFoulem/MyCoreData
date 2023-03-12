//
//  ContentView.swift
//  MyCoreData
//
//  Created by AndreMacBook on 2023-03-11.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext


    var body: some View {
       Text("asdf")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
