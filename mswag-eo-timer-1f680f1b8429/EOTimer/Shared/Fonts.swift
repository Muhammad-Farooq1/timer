//
//  Fonts.swift
//  EOTimer
//
//  Created by Maximilian Zimmermann on 24.01.23.
//

import SwiftUI

extension Font {
    
    /// Create a font with the large title text style.
    public static var largeTitle: Font {
        return Font.custom("AlbertSans-Medium", size: UIFont.preferredFont(forTextStyle: .largeTitle).pointSize)
    }

    public static var title: Font {
        return Font.custom("AlbertSans-Medium", size: UIFont.preferredFont(forTextStyle: .title1).pointSize)
    }

    public static var headline: Font {
        return Font.custom("AlbertSans-Medium", size: UIFont.preferredFont(forTextStyle: .headline).pointSize)
    }

    public static var subheadline: Font {
        return Font.custom("AlbertSans-Medium", size: UIFont.preferredFont(forTextStyle: .subheadline).pointSize)
    }

    public static var body: Font {
           return Font.custom("AlbertSans-Medium", size: UIFont.preferredFont(forTextStyle: .body).pointSize)
       }

    public static var callout: Font {
           return Font.custom("AlbertSans-Medium", size: UIFont.preferredFont(forTextStyle: .callout).pointSize)
       }

    public static var footnote: Font {
           return Font.custom("AlbertSans-Medium", size: UIFont.preferredFont(forTextStyle: .footnote).pointSize)
       }

    public static var caption: Font {
           return Font.custom("AlbertSans-Medium", size: UIFont.preferredFont(forTextStyle: .caption1).pointSize)
       }

    public static func system(size: CGFloat, weight: Font.Weight = .regular, design: Font.Design = .default) -> Font {
        var font = "AlbertSans-Medium"
        switch weight {
        case .bold: font = "AlbertSans-Bold"
        case .heavy: font = "AlbertSans-ExtraBold"
        case .light: font = "AlbertSans-Light"
        case .medium: font = "AlbertSans-Regular"
        case .semibold: font = "AlbertSans-SemiBold"
        case .thin: font = "AlbertSans-Light"
        case .ultraLight: font = "AlbertSans-Light"
        default: break
        }
        return Font.custom(font, size: size)
    }
}
