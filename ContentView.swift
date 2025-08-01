import SwiftUI

struct ContentView: View {
   @StateObject private var vm=ColorViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Color: \(hexColor)").font(.title)

            RoundedRectangle(cornerRadius: 15)
                .fill(bgColor)
                .frame(height: 200)

            Button("Generate Color") {
                let randomHex = String(format: "#%06X", Int.random(in: 0...0xFFFFFF))
                hexColor = randomHex
                bgColor = Color(hex: randomHex)
                UserDefaults.standard.set(hexColor, forKey: "lastColor")
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.dropFirst()
        var int: UInt64 = 0
        Scanner(string: String(hex)).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xFF) / 255
        let g = Double((int >> 8) & 0xFF) / 255
        let b = Double(int & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }
}
