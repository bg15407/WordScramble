//
//  ContentView.swift
//  Word Scramble
//
//  Created by Gayan Kalinga on 5/16/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        List{
            Section(header: Text("Start Static")){
                Text("Hello, world!")
                Text("Hello, world!")
                Text("Hello, world!")
            }
            
            Section(header: Text("Dynamic")){
                ForEach(0..<6){number in
                    Text("Dynamic \(number)")
                }
            }
            
            Section(header: Text("End Static")){
                Text("Hello, end of the world!")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
