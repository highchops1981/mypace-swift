//
//  Camera.swift
//  silentcamera+firestorage+offline
//
//  Created by keisuke ishikura on 2017/12/08.
//

import Foundation
import UIKit
import AVFoundation
import Photos

class Camera: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    static let sharedCamera = Camera()
    
    let captureSession = AVCaptureSession()
    let videoDevice = AVCaptureDevice.defaultDevice(withDeviceType: .builtInWideAngleCamera, mediaType: AVMediaTypeVideo, position: .front)
    let fileOutput = AVCaptureMovieFileOutput()
    let captureOutput = AVCaptureVideoDataOutput()
    var isRecording = false
    var numOfCapture = 0
    
    override private init() {
        
        super.init()
        
        do {
            
            let videoInput = try AVCaptureDeviceInput(device: self.videoDevice) as AVCaptureDeviceInput
            self.captureSession.addInput(videoInput)
            self.captureSession.addOutput(self.captureOutput)
            let connection = self.captureOutput.connection(withMediaType: AVMediaTypeVideo)
            connection?.videoOrientation = .landscapeRight
            self.captureSession.sessionPreset = AVCaptureSessionPreset640x480
            //AVCaptureSessionPresetPhoto
            //写真用の最大解像度, ビデオ出力ではサポートされない
            //AVCaptureSessionPresetHigh
            //最高の録画品質
            //AVCaptureSessionPresetMedium
            //WiFi共有用
            //AVCaptureSessionPresetLow
            //3G共有
            //AVCaptureSessionPreset352x288
            //CIF
            //AVCaptureSessionPreset640x480
            //VGA
            //AVCaptureSessionPreset1280x720
            //HD, 720p
            //AVCaptureSessionPresetiFrame960x540
            //960×540のiFrame H.264ビデオ
            //AVCaptureSessionPresetiFrame1280x720
            
            // ピクセルフォーマットを 32bit BGR + A とする
            self.captureOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as AnyHashable : Int(kCVPixelFormatType_32BGRA)]
            
            // フレームをキャプチャするためのサブスレッド用のシリアルキューを用意
            self.captureOutput.setSampleBufferDelegate(self as AVCaptureVideoDataOutputSampleBufferDelegate, queue: DispatchQueue.main)
            
            self.captureOutput.alwaysDiscardsLateVideoFrames = true
            
        }
        catch{
        }
        
    }
    
    func shot() {
        
        if !self.isRecording {
            
            self.captureSession.startRunning()
            self.isRecording = true
            
        }
        
    }
    
    func stop() {
        
        if self.isRecording {
            
            self.captureSession.stopRunning()
            self.isRecording = false
            
        }
        
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {
        
        guard let image:UIImage = self.captureImage(sampleBuffer: sampleBuffer) else {
            return
        }
        
        if self.numOfCapture == 30 {
            
            self.stop()
        
            let domain = "firestorage bucket path"
            let name = String(Util.getUnixByMs()) + ".jpg"
            let customMetadata = [
                "custommetadata":"",
            ]
            
            UploadInCarImage.sharedUploadInCarImage.storeInCarImageData(
                inCarImageData: InCarImageData(domain: domain, imageName: name, image: image, customMetadata:customMetadata as! [String : String])
                
            )
            
            UploadInCarImage.sharedUploadInCarImage.put()
                
            
            self.numOfCapture = 0
            
        }
        
        self.numOfCapture = self.numOfCapture + 1
        
    }
    
    func captureImage(sampleBuffer:CMSampleBuffer) -> UIImage?{
        
        guard let imageBuffer:CVImageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return nil
        }
        
        CVPixelBufferLockBaseAddress(imageBuffer, CVPixelBufferLockFlags(rawValue: 0))
        
        guard let baseAddress:UnsafeMutableRawPointer = CVPixelBufferGetBaseAddressOfPlane(imageBuffer, 0) else {
            return nil
        }
        
        let bytesPerRow:Int = CVPixelBufferGetBytesPerRow(imageBuffer)
        let width:Int = CVPixelBufferGetWidth(imageBuffer)
        let height:Int = CVPixelBufferGetHeight(imageBuffer)
        
        let colorSpace:CGColorSpace = CGColorSpaceCreateDeviceRGB()
        
        guard let newContext:CGContext = CGContext(data: baseAddress, width: width, height: height, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: colorSpace,  bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue|CGBitmapInfo.byteOrder32Little.rawValue) else {
            return nil
        }
        
        guard let imageRef:CGImage = newContext.makeImage() else {
            return nil
        }
        
        let resultImage = UIImage(cgImage: imageRef, scale: 1.0, orientation: UIImageOrientation.up)
        
        return resultImage
    }
    
}
