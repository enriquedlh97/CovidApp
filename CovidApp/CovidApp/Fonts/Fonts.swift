//
//  Fonts.swift
//  CovidApp
//
//  Created by Enrique Diaz de Leon Hicks on 3/28/21.
//

import Foundation
import SwiftUI

extension Font {
    public static func Roboto(size: CGFloat) -> Font {
        return Font.custom("Roboto-Regular", size: size)
    }
    public static func RobotoBold(size: CGFloat) -> Font {
        return Font.custom("Roboto-Bold", size: size)
    }
    public static func RobotoItalic(size: CGFloat) -> Font {
        return Font.custom("Roboto-Italic", size: size)
    }
}
