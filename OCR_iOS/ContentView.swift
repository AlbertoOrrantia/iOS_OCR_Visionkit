//
//  ContentView.swift
//  OCR_iOS
//
//  Created by Alberto Orrantia on 05/01/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var scanProvider = ScanProvider()
    
    var body: some View {
        ScanView(scanProvider: scanProvider)
            .sheet(isPresented: $scanProvider.showSheet) {
                VStack(alignment: .leading) {
                    Text(scanProvider.text)
                        .font(.system(.body, design: .rounded))
                        .padding(.top, 20)
                        .padding(.horizontal, 20)
                    Spacer()
                }
                .presentationDragIndicator(.visible)
                .presentationDetents([.medium, .large])
            }
    }
}

#Preview {
    ContentView()
}
