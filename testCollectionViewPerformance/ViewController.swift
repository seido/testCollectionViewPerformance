//
//  ViewController.swift
//  testCollectionViewPerformance
//
//  Created by Naoyuki Seido on 2017/03/11.
//  Copyright © 2017 Naoyuki Seido. All rights reserved.
//

import Cocoa

class ViewController: NSViewController,NSCollectionViewDataSource, NSCollectionViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    @IBOutlet weak var collectionView: MyCollectionView!

    
    var ensureVisibleTarget : IndexPath? = nil
    var preResizeScrollPoint : CGFloat = 0;
    @IBAction func changedSize(_ sender: NSSlider) {
        let l = self.collectionView.collectionViewLayout as! NSCollectionViewFlowLayout
        
        if(NSApplication.shared().currentEvent?.type == .leftMouseDown) {
            let pt = self.collectionView.enclosingScrollView?.convert(NSPoint(x: 1,y: 1), to: self.collectionView)
            preResizeScrollPoint = pt!.y / self.collectionView.bounds.height
            ensureVisibleTarget = self.collectionView.indexPathForItem(at: pt!)
        }
        
        self.collectionView.ignoreLayout = true
        l.itemSize = NSSize(width: CGFloat(sender.floatValue), height: CGFloat(sender.floatValue))
        self.collectionView.ignoreLayout = false
        
        let finished = NSApplication.shared().currentEvent?.type == .leftMouseUp
        
        if(finished) {
            self.collectionView.reloadData()
        }else {
            DispatchQueue.main.async {
                self.collectionView.needsLayout = true
                let sp = NSPoint(x: 1.0, y: self.preResizeScrollPoint*self.collectionView.bounds.height)
                self.collectionView.scroll(sp)
            }
        }
        
    }

    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2000
    }

    var dataList :Array<Dictionary<String, Any?>?> = Array<Dictionary<String, Any?>?>(repeating: nil, count: 2000)

    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {

        let item : CollectionViewItem? = collectionView.makeItem(withIdentifier: "CollectionViewItem", for: indexPath) as? CollectionViewItem
        var data = dataList[indexPath.item]

        if data == nil {
            let path = "~/testimage/"+String(indexPath.item)+".png"

            data = [
                "imageUrl" : NSString(string: path).expandingTildeInPath
            ]
            dataList[indexPath.item] = data;
        }

        if let i = data?["imageUrl"] as? String {
            item?.imagePath = i
        }

        return item!
    }


}

