//
//  QRView.swift
//  ScanTextQR
//
//  Created by Paul Jaime Felix Flores on 30/07/24.
// actualizado


import SwiftUI
import CodeScanner

//V-315,paso 1.8
struct QRView: View {
    
    @State private var showScanner = false
    //Guardamos nuestro texto ya escaneado
    @State private var qrtext = "Escanear qr"
    
    //Función que nos pide la libreria.
    func scan(result: Result<ScanResult, ScanError>){
        showScanner = false
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "")
            qrtext = details[0]
        case .failure(let error):
            print("Fallo el escaneo", error.localizedDescription)
        }
    }
    
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                // Botón estilizado para escanear
                Button(action: { showScanner = true }) {
                    Label("Escanear QR", systemImage: "qrcode.viewfinder")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(radius: 2)
                }
                .padding(.horizontal, 40)
                
                // Muestra el texto escaneado con estilo
                if !qrtext.isEmpty {
                    VStack {
                        Text("Código escaneado:")
                            .font(.headline)
                            .foregroundColor(.gray)
                        
                        Text(qrtext)
                            .font(.body)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .padding(.horizontal, 20)
                } else {
                    Text("Aún no hay código escaneado")
                        .foregroundColor(.gray)
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Escanear QR")
            .sheet(isPresented: $showScanner) {
                //aqui ponemos el codigo qr, podemos poner varios
                CodeScannerView(codeTypes: [.qr], completion: scan)
            }
        }
    }
    
}


#Preview{
    ContentView()
}
