//
//  NHConstants.swift
//  Loop
//
//  Created by mac 2019 on 2/10/22.
//

import Foundation
import UIKit

struct AppConstants {
    static let kAccessTokenKey  = "access-token-key"
    static let realmAppId = "mycontacts-ios-cpzrr"
}

struct AppColors {
    static let white = UIColor(rgb: 0xFFFFFF)
    static let transparent = UIColor.clear
    static let red = UIColor(red: 255.0/255.0, green: 0.0, blue: 0.0, alpha: 1.0)
    static let gray = UIColor.gray
    static let blueText = UIColor.init(hexString: "#3385FF")
    static let background = UIColor(named: "Background") ?? UIColor.clear
    static let placeholder = UIColor.gray
    static let primaryColor = UIColor(named: "AccentColor") ?? UIColor.clear
    static let accentColor = UIColor(named: "AccentColor") ?? UIColor.clear
}

enum AppTexts: String {
    case translate_id_0001
    case translate_id_0002
    case translate_id_0003
    case translate_id_0004
    case translate_id_0005
    case translate_id_0006
    case translate_id_0007
    case translate_id_0008
    case translate_id_0009
    case translate_id_0010
    case translate_id_0011
    case translate_id_0012
    case translate_id_0013
    case translate_id_0014
    case translate_id_0015
    case translate_id_0016
    case translate_id_0017
    case translate_id_0018
    case translate_id_0019
    case translate_id_0020
}

enum AppImages: String {
//    common
    case defaultProfile = "default_profile"
//    Login
    case logo = "Logo"
//    others
    case transparent = "transparent"
}

struct APIConstants {
    static let bearerKey = "Authorization"

    static let baseUrl = "https://dev.thebeats.app/"
    static let loginEndPoint = "login"
    
}

struct DateFormatConstants {
    static let yyyy_MM_dd_T_HH_mm_ss_mmm_z = "yyyy-MM-dd'T'HH:mm:ss.mmmZ"
    static let yyyy_MM_dd_T_HH_mm_ss_z = "yyyy-MM-dd'T'HH:mm:ssZ"
    static let yyyy_MM_dd_HH_mm_ss = "yyyy-MM-dd HH:mm:ss"
    static let yyyy_MM_dd_HH_mm_ss_slash = "yyyy/MM/dd HH:mm:ss"
    static let yyyy_MM_dd_HH_mm_slash = "yyyy/MM/dd HH:mm"
    static let dd_MMM_yyyy = "dd MMM yyyy"
    static let dd_MM_yy = "dd/MM/yy"
    static let MMM_dd_yyyy = "MMM dd, yyyy"
    static let yyyy_mm_dd = "yyyy-MM-dd"
    static let yyyy = "yyyy"
    static let dd_mmm = "dd MMM"
    static let hh_mm_a = "hh:mm a"
}
