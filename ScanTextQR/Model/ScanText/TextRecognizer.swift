//
//  TextRecognizer.swift
//  ScanTextQR
//
//  Created by Paul Jaime Felix Flores on 30/07/24.
//


import Foundation
import Vision
import VisionKit

//V-311,paso 1.1
class TextRecognizer {
    
    let cameraScan : VNDocumentCameraScan
    
    //Paso 1.2 ,creamos nuestro constructor
    init(cameraScan : VNDocumentCameraScan){
        self.cameraScan = cameraScan
    }
    
    //Paso 1.3, retornamos una imagen
    func recognizerText(competionHandler: @escaping ([String]) -> Void ){
        
        DispatchQueue.main.async {
            //cuentame el número de páginas
            let image = (0..<self.cameraScan.pageCount).compactMap({
                self.cameraScan.imageOfPage(at:$0).cgImage
            })
            
            
            let imageRequest = image.map({
                //VNRecognizeTextRequest(),reconocimiento de texto
                (image: $0, request: VNRecognizeTextRequest())
            })
            
            //Nos retorna el string de nuestro resultado
            let textPage = imageRequest.map{ image, request -> String in
                let handler = VNImageRequestHandler(cgImage: image, options: [:])
                
                do{
                    try handler.perform([request])
                    guard let observations = request.results else { return "" }
                    //que me obtenga el primer resultado 
                    return observations.compactMap({$0.topCandidates(1).first?.string}).joined(separator: "\n")
                    
                }catch let error as NSError {
                    print("Error al reconocer texto", error.localizedDescription)
                    return ""
                }
            }
            competionHandler(textPage)
        }
    }
}
