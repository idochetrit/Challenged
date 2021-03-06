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

  
  @IBOutlet weak var previewView: UIView!
  @IBOutlet var messageLabel:UILabel!
  @IBOutlet var topbar: UIView!
  
  //QR Scanner variables
  var captureSession: AVCaptureSession!
  var previewLayer: AVCaptureVideoPreviewLayer!
  
  override func viewDidLoad() {
      super.viewDidLoad()

    // Move the message label and top bar to the front
    view.bringSubview(toFront: topbar)
    view.bringSubview(toFront: messageLabel)
    
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
    previewView.layer.addSublayer(previewLayer)
    
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
    
//    dismiss(animated: true)
  }
  
  func found(code: String) {
    print("QR code:", code)
    let regex = "^start_game_(\\d+)"
    guard let matches = code.capturedGroups(withRegex: regex)
      else { print("challenge ID not found"); return }
    if (!matches.isEmpty) {
      let challengeID = Int(matches[0])!
      
      let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
      let viewController = storyboard.instantiateViewController(withIdentifier: "challengeInfo") as! ChallengeInfoViewController
      
      viewController.challengeInfo = ChallengeInfoStore.data[challengeID]
      viewController.hero.modalAnimationType = .zoom
      present(viewController, animated: true, completion: nil)
    }
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return .portrait
  }


  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
  
}
