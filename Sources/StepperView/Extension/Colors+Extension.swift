//
//  Colors+Extension.swift
//  StepperView
//
//  Created by Venkatnarayansetty, Badarinath on 4/8/20.
//

import Foundation
import SwiftUI

/// Color palette helper accessing colors and it's variations.
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public enum Colors {
    /// red and it's associated variations
    case red(RedSubType)
    /// green and it's associated variations
    case green(GreenSubType)
    /// blue and it's associated variations
    case blue(BlueSubType)
    /// gray and it's associated variations
    case gray(GraySubType)
    /// teal color
    case teal
    /// lavender color
    case lavendar
    /// orange color
    case orange
    /// black color
    case black
    /// yellow and it's associated variations
    case yellow(YellowSubType)
    /// cyan color
    case cyan
    /// ploar color
    case polar
    
    /// Color palette for all gray variations
    public enum GraySubType {
        /// dark gray
        case dark
        /// darker gray
        case darker
        /// medium gray
        case medium
        /// dim gray
        case dim
        /// light gray
        case light
        /// lighter gray
        case lighter
        /// lightest gray
        case lightest
        /// silver version of gray
        case silver
        /// medium silver
        case mediumSilver
        /// dark silver
        case darkSilver
        /// pale gray
        case pale
        /// battleShip gray
        case battleShip
        /// slate gray
        case slate
        /// charcoal gray
        case charcoal
        /// bright gray
        case bright
        /// pale sky gray
        case paleSky
        /// iron gray
        case iron
        /// cod gray
        case cod
    }
    
    /// Color palette for all green variations
    public enum GreenSubType {
        /// normal green
        case normal
        /// dark green
        case dark
        /// light green
        case light
        /// lighter green
        case lighter
        /// medium green
        case medium
        /// fair green
        case fair
        /// kiwi green
        case kiwi
        /// dark lime green
        case darkLime
        /// kermit green
        case kermit
        /// teal green
        case teal
        /// light teal green
        case lightTeal
        /// lighter teal green
        case lighterTeal
        /// regular green
        case regular
    }
    
    /// Color palette for all blue variations
    public enum BlueSubType {
        /// sky blue
        case sky
        /// light sky blue
        case lightSky
        /// tiffany blue
        case tiffany
        /// aqua blue
        case aqua
        /// aqua marine blue
        case aquaMarine
        /// turquoise blue
        case turquoise
        /// teal blue
        case teal
        /// sea blue
        case sea
        /// bright blue
        case bright
    }
    
    /// Color palette for all yellow variations
    public enum YellowSubType {
        /// regular yellow
        case regular
        /// sunflower yellow
        case sunFlower
    }
    
    /// Color palette for all red variations
    public enum RedSubType {
        /// normal red
        case normal
        /// light red
        case light
    }
}

/// Vvsualize Color palette for each color and it's sub type variation
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
extension Colors {
    /// alias to `Color`
    public typealias RawValue = Color
    
    /// returns the desired color based on the switch case matching criteria
    public var rawValue: RawValue {
        switch self {
        case .red(let variation):
            switch variation {
            case .normal: return Color(#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1))
            case .light: return Color(#colorLiteral(red: 0.9490196078, green: 0.3490196078, blue: 0.3176470588, alpha: 1))
            }
        case .gray(let variation):
            switch variation {
            case .dark: return Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1))
            case .darker: return Color(#colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1))
            case .medium: return Color(#colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1))
            case .dim: return Color(#colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1))
            case .light: return Color(#colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1))
            case .lighter: return Color(#colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1))
            case .lightest: return Color(#colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1))
            case .silver: return Color(#colorLiteral(red: 0.9058823529, green: 0.9058823529, blue: 0.9058823529, alpha: 1))
            case .mediumSilver: return Color(#colorLiteral(red: 0.6980392157, green: 0.6980392157, blue: 0.6980392157, alpha: 1))
            case .bright: return Color(#colorLiteral(red: 0.2274509804, green: 0.2470588235, blue: 0.2784313725, alpha: 1))
            case .paleSky: return Color(#colorLiteral(red: 0.4235294118, green: 0.4588235294, blue: 0.5098039216, alpha: 1))
            case .pale: return Color(#colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9725490196, alpha: 1))
            case .battleShip: return Color(#colorLiteral(red: 0.4235294118, green: 0.4588235294, blue: 0.5098039216, alpha: 1))
            case .darkSilver: return Color(#colorLiteral(red: 0.5529411765, green: 0.5647058824, blue: 0.5882352941, alpha: 1))
            case .slate: return Color(#colorLiteral(red: 0.4196078431, green: 0.4235294118, blue: 0.4470588235, alpha: 1))
            case .charcoal: return Color(#colorLiteral(red: 0.2235294118, green: 0.2274509804, blue: 0.2392156863, alpha: 1))
            case .iron: return Color(#colorLiteral(red: 0.831372549, green: 0.8392156863, blue: 0.8588235294, alpha: 1))
            case .cod: return Color(#colorLiteral(red: 0.06666666667, green: 0.06666666667, blue: 0.06666666667, alpha: 1))
            }
        case .green(let variation):
            switch variation {
            case .normal: return Color(#colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1))
            case .light: return Color(#colorLiteral(red: 0.9019607843, green: 0.9764705882, blue: 0.9450980392, alpha: 1))
            case .dark: return Color(#colorLiteral(red: 0.1803921569, green: 0.6078431373, blue: 0.2784313725, alpha: 1))
            case .lighter: return Color(#colorLiteral(red: 0.3254901961, green: 0.7137254902, blue: 0.2784313725, alpha: 1))
            case .medium: return Color(#colorLiteral(red: 0.5137254902, green: 0.7647058824, blue: 0.2549019608, alpha: 1))
            case .fair: return Color(#colorLiteral(red: 0.6745098039, green: 0.8156862745, blue: 0.2352941176, alpha: 1))
            case .kiwi: return Color(#colorLiteral(red: 0.662745098, green: 0.9098039216, blue: 0.2196078431, alpha: 1))
            case .darkLime: return Color(#colorLiteral(red: 0.4980392157, green: 0.8156862745, blue: 0, alpha: 1))
            case .kermit: return Color(#colorLiteral(red: 0.3254901961, green: 0.7176470588, blue: 0, alpha: 1))
            case .teal: return Color(#colorLiteral(red: 0.03921568627, green: 0.7803921569, blue: 0.4588235294, alpha: 1))
            case .lightTeal: return Color(#colorLiteral(red: 0, green: 0.7843137255, blue: 0.4392156863, alpha: 1))
            case .lighterTeal: return Color(#colorLiteral(red: 0.1058823529, green: 0.8039215686, blue: 0.6117647059, alpha: 1))
            case .regular: return Color(#colorLiteral(red: 0.06274509804, green: 0.5019607843, blue: 0, alpha: 1))
            }
        case .blue(let variation):
            switch variation {
            case .sky: return Color(#colorLiteral(red: 0.2705882353, green: 0.7921568627, blue: 0.9019607843, alpha: 1))
            case .lightSky: return Color(#colorLiteral(red: 0.6097495719, green: 0.7882352941, blue: 0.8980392157, alpha: 1))
            case .tiffany: return Color(#colorLiteral(red: 0.4784313725, green: 0.8470588235, blue: 0.9294117647, alpha: 1))
            case .aqua: return Color(#colorLiteral(red: 0.1176470588, green: 0.8274509804, blue: 0.831372549, alpha: 1))
            case .aquaMarine: return Color(#colorLiteral(red: 0.2470588235, green: 0.9254901961, blue: 0.8470588235, alpha: 1))
            case .turquoise: return Color(#colorLiteral(red: 0.02352941176, green: 0.7137254902, blue: 0.7882352941, alpha: 1))
            case .teal: return Color(#colorLiteral(red: 0, green: 0.6470588235, blue: 0.6392156863, alpha: 1))
            case .sea: return Color(#colorLiteral(red: 0, green: 0.8274509804, blue: 0.9490196078, alpha: 1))
            case .bright: return Color(#colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1))
            }
        case .yellow(let variation):
            switch variation {
            case .regular:return Color(#colorLiteral(red: 1, green: 0.8117647059, blue: 0.2509803922, alpha: 1))
            case .sunFlower: return Color(#colorLiteral(red: 1, green: 0.862745098, blue: 0, alpha: 1))
            }
        case .teal: return Color(#colorLiteral(red: 0.02352941176, green: 0.7137254902, blue: 0.7882352941, alpha: 1))
        case .lavendar: return Color(#colorLiteral(red: 0.7098039216, green: 0.5960784314, blue: 0.9215686275, alpha: 1))
        case .orange: return Color(#colorLiteral(red: 1, green: 0.6705882353, blue: 0.2509803922, alpha: 1))
        case .black: return Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        case .cyan: return Color(#colorLiteral(red: 0.02745098039, green: 0.768627451, blue: 0.8509803922, alpha: 1))
        case .polar: return Color(#colorLiteral(red: 0.9490196078, green: 0.9843137255, blue: 0.9882352941, alpha: 1))
        }
    }
}
