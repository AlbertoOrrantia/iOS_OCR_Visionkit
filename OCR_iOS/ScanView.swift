//
//  ScanView.swift
//  OCR_iOS
//
//  Created by Alberto Orrantia on 05/01/24.
//

import SwiftUI
import VisionKit

struct ScanView: UIViewControllerRepresentable {
    @ObservedObject var scanProvider: ScanProvider
    func makeUIViewController(context: Context) -> DataScannerViewController {
        //Here we can change the accuracy in reltion to speed
        let dataScannerViewController = DataScannerViewController(recognizedDataTypes: [.text()], qualityLevel: .balanced, isHighlightingEnabled: true)
        dataScannerViewController.delegate = scanProvider
        try? dataScannerViewController.startScanning()
        return dataScannerViewController
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

final class ScanProvider: NSObject, DataScannerViewControllerDelegate, ObservableObject {
    @Published var text: String = ""
    @Published var error: DataScannerViewController.ScanningUnavailable?
    @Published var showSheet:Bool = false
    
    func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
        switch item {
        case .text(let recognizedText):
            self.text = recognizedText.transcript
            self.showSheet.toggle()
            print(recognizedText)
        case .barcode(_):
            break
        @unknown default:
            break
        }
    }
    
    func dataScanner(_ dataScanner: DataScannerViewController, 
                     becameUnavailableWithError error: DataScannerViewController.ScanningUnavailable) {
        self.error = error
        print (error)
    }
}
