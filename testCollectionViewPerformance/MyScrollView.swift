//
// Created by Naoyuki Seido on 2017/03/12.
// Copyright (c) 2017 Naoyuki Seido. All rights reserved.
//

import AppKit


class MyScrollView : NSScrollView {

    override class func contentSize(forFrameSize fSize: NSSize, horizontalScrollerClass: AnyClass?, verticalScrollerClass: AnyClass?, borderType type: NSBorderType, controlSize: NSControlSize, scrollerStyle: NSScrollerStyle) -> NSSize {
        return super.contentSize(forFrameSize: fSize, horizontalScrollerClass: horizontalScrollerClass, verticalScrollerClass: verticalScrollerClass, borderType: type, controlSize: controlSize, scrollerStyle: scrollerStyle)
    }
    
    var ignoreScroll : Bool = false
    

    override func reflectScrolledClipView(_ cView: NSClipView) {
        if !ignoreScroll {
            super.reflectScrolledClipView(cView)
        }
    }

}
