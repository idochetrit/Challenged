//
//  QRScannerController.swift
//  QRCodeReader
//
//  Created by Simon Ng on 13/10/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit
import AVFoundation

class QRScannerController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

  
  @IBOutlet var messageLabel:UILabel!
  @IBOutlet var topbar: UIView!
  
  //QR Scanner variables
  var captureSession: AVCaptureSession!
  var previewLayer: AVCaptureVideoPreviewLayer!
  
  override func viewDidLoad() {
      super.viewDidLoad()

    // Move the message label and top bar to the front
    view.bringSubview(toFront: messageLabel)
    view.bringSubview(toFront: topbar)
    
    captureSession = AVCaptureSession()
    
    guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
    let videoInput: AVCaptureDeviceInput
    
    do {
      videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
    } catch {
      return
    }
    
    if (captureSession.canAddInput(videoInput)) {
      captureSession.addInput(videoInput)
    } else {
      failed()
      return
    }
    
    let metadataOutput = AVCaptureMetadataOutput()
    
    if (captureSession.canAddOutput(metadataOutput)) {
      captureSession.addOutput(metadataOutput)
      
      metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
      metadataOutput.metadataObjectTypes = [.qr]
    } else {
      failed()
      return
    }
    
    previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    previewLayer.frame = view.layer.bounds
    previewLayer.videoGravity = .resizeAspectFill
    view.layer.addSublayer(previewLayer)
    
    captureSession.startRunning()
  }
  
  func failed() {
    let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac, animated: true)
    captureSession = nil
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    if (captureSession?.isRunning == false) {
      captureSession.startRunning()
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    if (captureSession?.isRunning == true) {
      captureSession.stopRunning()
    }
  }
  
  func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
    captureSession.stopRunning()
    
    if let metadataObject = metadataObjects.first {
      guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
      guard let stringValue = readableObject.stringValue else { return }
      AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
      found(code: stringValue)
    }
    
    dismiss(animated: true)
  }
  
  func found(code: String) {
    print(code)
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return .portrait
  }
  
    

    //Get the back camera
//    let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualCamera], mediaType: AVMediaType.video, position: .back)
//
//    guard let captureDevice = deviceDiscoverySession.devices.first else {
//      print("Failed to get the camera device")
//      return
//    }
//
//    do {
//      // Get an instance of the AVCaptureDeviceInput class using the previous device object.
//      let input = try AVCaptureDeviceInput(device: captureDevice)
//
//      // Set the input device on the capture session.
//      captureSession?.addInput(input)
//
//      // Initialize a AVCaptureMetadataOutput object
//      // and set it as the output device to the capture session.
//      let captureMetadataOutput = AVCaptureMetadataOutput()
//      captureSession?.addOutput(captureMetadataOutput)
//
//      // Set delegate and use the default dispatch queue to execute the call back
//      captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
//      captureMetadataOutput.metadataObjectTypes = [.qr]
//
//      // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
//      videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
//      videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
//      videoPreviewLayer?.frame = view.layer.bounds
//      view.layer.addSublayer(videoPreviewLayer!)
//
//      //Start capture
//      captureSession?.startRunning()
//
//    } catch {
//      // If any error occurs, simply print it out and don't continue any more.
//      print(error)
//      return
//    }
    


  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
  
}
