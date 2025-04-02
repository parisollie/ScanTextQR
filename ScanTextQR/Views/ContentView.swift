//
//  ContentView.swift
//  ScanTextQR
//
//  Created by Paul Jaime Felix Flores on 29/07/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            //Vid 310 
            ScannerView().tabItem{
                Label("Scan Text", systemImage: "doc.text.viewfinder")
            }
            QRView().tabItem{
                Label("QR Code", systemImage: "qrcode.viewfinder")
            }
        }
    }
}

#Preview{
    ContentView()
}
