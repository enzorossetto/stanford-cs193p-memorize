//
//  ContentView.swift
//  Memorize
//
//  Created by Enzo Rossetto on 12/10/23.
//

import SwiftUI

enum EmojiTheme {
    case helloween, vehicles, countries
}

struct ContentView: View {
    @State var emojis: [String] = []
    @State var themeColor = Color.blue
    
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            ScrollView {
                cards
            }
            Spacer()
            cardCountAdjusters
        }
        .padding()
    }
    
    var cardWidth: CGFloat {
        if emojis.count <= 12 {
            550 / CGFloat(emojis.count)
        } else if  emojis.count <= 24 {
            1200 / CGFloat(emojis.count)
        } else {
            1800 / CGFloat(emojis.count)
        }
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: cardWidth))]) {
            ForEach(0..<emojis.count, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(themeColor)
    }
    
    var cardCountAdjusters: some View {
        HStack(alignment: .center, spacing: CGFloat(35)) {
            countries
            helloween
            vehicles
        }
        
    }
    
    func setGameTheme(_ theme: EmojiTheme) {
        switch theme {
        case .countries:
            emojis = ["🇧🇷", "🇨🇦", "🇫🇷", "🇱🇷", "🇪🇸", "🇦🇫", "🇦🇽", "🇦🇱", "🇩🇿", "🇦🇸", "🇦🇷", "🇯🇵"]
            themeColor = Color.blue
        case .helloween:
            emojis = ["👻", "🎃", "🕷️", "😈", "👽", "👹", "🕸️", "☠️", "🍭", "🧙‍♀️", "🧛‍♂️", "🧟‍♂️"]
            themeColor = Color.orange
        case .vehicles:
            emojis = ["🚗", "🚌", "🏎️", "🛵", "🚜", "🚂", "🚁", "✈️", "🚀", "⛵️", "🛺", "🚑"]
            themeColor = Color.red
        }
        
        emojis = Array(emojis[0..<Int.random(in: (3..<emojis.count))])
        emojis += emojis
        emojis.shuffle()
    }
    
    func cardThemeSelector(theme: EmojiTheme, symbol: String, description: String) -> some View {
        Button(action: {
            setGameTheme(theme)
        }, label: {
            VStack {
                Image(systemName: symbol)
                    .imageScale(.medium)
                    .font(.largeTitle)
                Text(description).font(.footnote)
            }
        })
    }
    
    var countries: some View {
        cardThemeSelector(theme: .countries, symbol: "globe", description: "Countries")
    }
    
    var helloween: some View {
        cardThemeSelector(theme: .helloween, symbol: "moon", description: "Helloween")
    }
    
    var vehicles: some View {
        cardThemeSelector(theme: .vehicles, symbol: "car", description: "Vehicles")
    }
}


struct CardView: View {
    let content: String
    @State var isFaceUp = false
    
    var body: some View {
        ZStack  {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
