//
//  ContentView.swift
//  BioBlitz
//
//  Created by Ronak Pustack on 15/07/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var board = GameBoard()
    
    var body: some View {
        VStack {
            HStack {
                Text("GREEN: \(board.greenScore)")
                    .padding(.horizontal)
                    .foregroundColor(board.currentPlayer == .green ? .black : .white)
                    .background(Capsule().fill(.green).opacity(board.currentPlayer == .green ? 1 : 0))
                Spacer()
                Text("BIOBLITZ")
                Spacer()
                Text("RED: \(board.redScore)")
                    .padding(.horizontal)
                    .background(Capsule().fill(.red).opacity(board.currentPlayer == .red ? 1 : 0))
            }
            .font(.system(size: 36).weight(.black))
            .padding()
            
            ZStack {
                VStack {
                    ForEach(0..<11, id: \.self) { row in
                        HStack {
                            ForEach(0..<22, id: \.self) {col in
                                let bacteria = board.grid[row][col]

                                BacteriaView(bacteria: bacteria){
                                    board.rotate(bacteria: bacteria)
                                }
                            }
                        }
                    }
                }
                .padding()
                .fixedSize()
                .preferredColorScheme(.dark)

                if let winner = board.winner {
                    VStack {
                        Text("\(winner) wins").font(.largeTitle)
                        
                        Button(action: board.reset) {
                            Text("Play Again")
                                .padding()
                                .background(.blue)
                                .clipShape(Capsule())
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(40)
                    .background(.black.opacity(0.8))
                    .cornerRadius(25)
                    .transition(.scale)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
