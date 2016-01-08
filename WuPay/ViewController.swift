//
//  ViewController.swift
//  WuPay
//
//  Created by Yuehao Wu on 1/7/16.
//  Copyright © 2016 Yuehao Wu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var qrcode: UIImageView!
    
    var qrcodeImage: CIImage!
    
    @IBAction func generate(sender: AnyObject) {
        
        let text = "https://www.paypal.me/" + name.text! + "/" + amount.text!
        
        let data = text.dataUsingEncoding(NSISOLatin1StringEncoding, allowLossyConversion: false)
        
        let filter = CIFilter(name: "CIQRCodeGenerator")
        
        filter!.setValue(data, forKey: "inputMessage")
        filter!.setValue("Q", forKey: "inputCorrectionLevel")
        
        qrcodeImage = filter!.outputImage
        
        displayQRCodeImage()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func displayQRCodeImage() {
        let scaleX = qrcode.frame.size.width / qrcodeImage.extent.size.width
        let scaleY = qrcode.frame.size.height / qrcodeImage.extent.size.height
        
        let transformedImage = qrcodeImage.imageByApplyingTransform(CGAffineTransformMakeScale(scaleX, scaleY))
        
        qrcode.image = UIImage(CIImage: transformedImage)
    }

}

