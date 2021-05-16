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
            Text("Hello, world!")
            Text("Hello, world!")
            Text("Hello, world!")
            
            ForEach(0..<6){number in
                Text("Dynamic \(number)")
            }
            
            Text("Hello, end of the world!")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
