//
// Created by Naoyuki Seido on 2017/03/11.
// Copyright (c) 2017 Naoyuki Seido. All rights reserved.
//

import AppKit
import QuartzCore

class LayerdImageView : NSView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    var imageLayer : CALayer? = nil;
    
    override func layout() {
        super.layout()
        
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        self.imageLayer?.frame = (self.layer?.bounds)!
        CATransaction.commit()
    }
    
    func reseizeImage(path:String, width:Int, height:Int) -> CGImage? {
        
        let s = self.window?.screen ?? NSScreen.main()
        let f = s?.backingScaleFactor ?? CGFloat(1.0)
        
        let w = Int(CGFloat(width)*f)
        let h = Int(CGFloat(height)*f)
        
        let url = NSURL(fileURLWithPath: path)
        let org = CGImageSourceCreateWithURL(url, nil);
        
        let thumb = CGImageSourceCreateThumbnailAtIndex(org!, 0, NSDictionary(dictionary:[
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceCreateThumbnailFromImageIfAbsent: true,
            kCGImageSourceThumbnailMaxPixelSize: NSNumber(value: Swift.max(w,h))
            ]))
        return thumb

//        let nsImage = NSImage(byReferencingFile: path)
//        var r = NSRect(x: 0, y: 0, width: w, height: h)
//        let image : CGImage? = nsImage?.cgImage(forProposedRect: &r, context: nil, hints: nil)
//
//        
//        if let image = image {
//            let cx = CGContext(data: nil, width: w, height: h, bitsPerComponent: 8, bytesPerRow: 0, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue)
//            
//            if(cx == nil) {
//                Swift.print("Err")
//            }
//            
//            cx?.draw(image, in: CGRect(x: 0, y: 0, width: w, height: h))
//            let result = cx?.makeImage()
//            return result
//        }
//        return nil
    }

    var imagePath : String? {
        didSet {
            weak var ws = self;
            if(oldValue != self.imagePath) {
                self.layer?.sublayers?.removeAll()
            }
            let w = self.bounds.width
            let h = self.bounds.height
            let path = self.imagePath
            let l = CALayer();
            DispatchQueue(label: "LayerdImageView.image", attributes: DispatchQueue.Attributes.concurrent).async {
                if let wself = ws {
                    let image = wself.reseizeImage(path: path!, width: Int(w), height: Int(h))
                    if(wself.imagePath == path) {
                        DispatchQueue.main.async {
                            if let wself = ws {
                                if(wself.imagePath == path) {
                                    l.contents = image;
                                    l.contentsGravity = kCAGravityResizeAspect
                                    wself.imageLayer = l
                                    
                                    wself.layer?.sublayers?.removeAll()
                                    l.frame = (wself.layer?.bounds)!
                                    wself.layer?.addSublayer(l)
                                    
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
