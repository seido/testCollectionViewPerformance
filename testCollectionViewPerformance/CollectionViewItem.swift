//
// Created by Naoyuki Seido on 2017/03/11.
// Copyright (c) 2017 Naoyuki Seido. All rights reserved.
//

import AppKit

class CollectionViewItem : NSCollectionViewItem {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
    }
    
    var imagePath : String? = nil {
        didSet {
            layerdImageView.imagePath = self.imagePath
        }
    }
    
    @IBOutlet weak var layerdImageView: LayerdImageView!
}
