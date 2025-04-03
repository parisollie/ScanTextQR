//
//  Scanner.swift
//  ScanTextQR
//
//  Created by Paul Jaime Felix Flores on 30/07/24.
//

import Foundation
import SwiftUI
import VisionKit

//Paso 1.5, ponemos el Scanner
struct Scanner : UIViewControllerRepresentable {

    typealias UIViewControllerType = VNDocumentCameraViewController
    
    let completionHandler : ([String]?) -> Void
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(completion: completionHandler)
    }
    
    func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let viewController = VNDocumentCameraViewController()
        viewController.delegate = context.coordinator
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) {
        
    }
    
    //Paso 1.6, ponemos nuestro constructor
    init(completion: @escaping ([String]?) -> Void){
        completionHandler = completion
    }
    
    class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        let completionHandler : ([String]?) -> Void
        
        init(completion: @escaping ([String]?) -> Void){
            completionHandler = completion
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            let recognizer = TextRecognizer(cameraScan: scan)
            recognizer.recognizerText(competionHandler: completionHandler)
        }
        
        //Los métodos 
        func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
            completionHandler(nil)
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
            completionHandler(nil)
        }
        
    }
}

