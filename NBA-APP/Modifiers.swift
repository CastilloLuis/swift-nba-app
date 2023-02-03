//
//  Modifiers.swift
//  NBA-APP
//
//  Created by Luis Castillo on 2/3/23.
//

import Foundation
import SwiftUI

struct CustomFrameModifier: ViewModifier {
    var open : Bool
    var width: CGFloat
    var height: CGFloat
    
    @ViewBuilder func body(content: Content) -> some View {
        if open {
            content.frame(maxWidth: width, maxHeight: height)
        } else {
            content.frame(width: width, height: height)
        }
    }
}
