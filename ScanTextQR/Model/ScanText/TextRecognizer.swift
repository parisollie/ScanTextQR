//
//  TextRecognizer.swift
//  ScanTextQR
//
//  Created by Paul Jaime Felix Flores on 30/07/24.
//

//Vid 311 ,
import Foundation
import Vision
import VisionKit

class TextRecognizer {
    
    let cameraScan : VNDocumentCameraScan
    //Vid 311 ,creamos nuestro constructor
    init(cameraScan : VNDocumentCameraScan){
        self.cameraScan = cameraScan
    }
    
    //Vid 311 ,competionHandler: @escaping ([String], retornamos una imagen
    func recognizerText(competionHandler: @escaping ([String]) -> Void ){
        
        DispatchQueue.main.async {
            //pageCount), cuentame el numero de paginas
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
