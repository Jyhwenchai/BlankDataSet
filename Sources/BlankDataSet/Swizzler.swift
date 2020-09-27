//
//  Swizzler.swift
//  BlankKit
//
//  Created by 蔡志文 on 2020/8/26.
//

import Foundation

struct Swizzler {
    
    static func swizzleMethods(for sourceClass: AnyClass?, originalSelector: Selector, swizzledSelector: Selector) {
        guard let originalMethod = class_getInstanceMethod(sourceClass, originalSelector),
            let swizzledMethod = class_getInstanceMethod(sourceClass, swizzledSelector) else {
            fatalError("Didn't find selector to swizzle")
        }
        
        let didAddMethod = class_addMethod(sourceClass, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
        
        if didAddMethod {
            class_replaceMethod(sourceClass.self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    }
}
