//
//  ContentView.swift
//  Word Scramble
//
//  Created by Gayan Kalinga on 5/16/21.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var newWord = ""
    @State private var rootWord = ""
    @State private var score = 0
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationView{
            VStack{
                TextField("Enter the word", text: $newWord, onCommit: addNewWord)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    
                
                List(usedWords, id: \.self){ word in
                    Image(systemName: "\(word.count).circle")
                    Text(word)
                }
                
              
                Text("Your score is \(score)")
             
            }
            .navigationBarTitle(rootWord)
            .navigationBarItems(leading: Button("Start"){
                startGame()
            })
            .alert(isPresented: $showingError) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
            .onAppear(perform: startGame)
        }
    }
    
    func addNewWord(){
        //Lowercase & trim
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        //Exit if answer is empty
        guard answer.count > 0 else {
            score -= 1
            return
        }
        
        //Extra Validation
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            score -= 1
            return
        }

        guard isPossible(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            score -= 1
            return
        }

        guard isReal(word: answer) else {
            wordError(title: "Word not possible", message: "That isn't a real word.")
            score -= 1
            return
        }
        
        usedWords.insert(answer, at: 0)
        score += 1
        newWord = ""
    }
    
    func startGame(){
        if let fileURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWord = try? String(contentsOf: fileURL){
                let allWords = startWord.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "tree"
                return
            }
        }
        
        fatalError("cannot load the file")
    }
    
    //Same as Original word
    func isOriginal(word: String) -> Bool{
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool{
        var tempWord = rootWord
        for letter in word{
            if let pos = tempWord.firstIndex(of: letter){
                tempWord.remove(at: pos)
            }else {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool{
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        if word.count < 4 {
            return false
        }else if word == rootWord {
            return false
        }
        print(range)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
