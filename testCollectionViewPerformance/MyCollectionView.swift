//
// Created by Naoyuki Seido on 2017/03/12.
// Copyright (c) 2017 Naoyuki Seido. All rights reserved.
//

import AppKit

class MyCollectionView : NSCollectionView {

    var ignoreLayout : Bool = false
    
    override var needsLayout: Bool {
        get {
            return super.needsLayout
        }
        set(value) {
            if !ignoreLayout {
                super.needsLayout = value
            }
        }
    }

}
