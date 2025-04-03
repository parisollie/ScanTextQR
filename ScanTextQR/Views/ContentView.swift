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
            //V-310,paso 1.0
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
