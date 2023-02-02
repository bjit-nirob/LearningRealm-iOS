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
}

struct Defaults {
    static func savePost(_ isCheck: Bool) {
        UserDefaults.standard.set(isCheck, forKey: "FIRST_POST_CHECK")
        UserDefaults.standard.synchronize()
    }
    
    static func hasPost() -> Bool {
       return UserDefaults.standard.bool(forKey: "FIRST_POST_CHECK")
    }
    
    static func saveIsCheckPost(_ isCheck: Bool) {
        UserDefaults.standard.set(isCheck, forKey: "IS_CHECK_POST")
        UserDefaults.standard.synchronize()
    }
    
    static func getIsCheckPost() -> Bool {
        return UserDefaults.standard.bool(forKey: "IS_CHECK_POST")
    }
    
    static func setPostCount(_ count: Int) {
        UserDefaults.standard.set(count, forKey: "COUNT_POST")
        UserDefaults.standard.synchronize()
    }
    
    static func incrementPostCount() {
        UserDefaults.standard.set(getPostCount() + 1, forKey: "COUNT_POST")
        UserDefaults.standard.synchronize()
    }
    
    static func getPostCount() -> Int {
        return UserDefaults.standard.integer(forKey: "COUNT_POST")
    }
}

struct AppColors {
    static let white = UIColor(rgb: 0xFFFFFF)
    static let transparent = UIColor.clear
    static let red = UIColor(red: 255.0/255.0, green: 0.0, blue: 0.0, alpha: 1.0)
    static let gray = UIColor.gray
    static let blueText = UIColor.init(hexString: "#3385FF")
    static let background = UIColor(named: "Background") ?? UIColor.clear
    static let placeholder = UIColor.gray
    static let primaryColor = UIColor.white
    static let accentColor = UIColor(named: "AccentColor") ?? UIColor.clear

}

enum AppTexts: String {
    // Jamil translate_id_0001 - translate_id_1000
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
    case translate_id_0021
    case translate_id_0022
    case translate_id_0023
    case translate_id_0024
    case translate_id_0025
    case translate_id_0026
    case translate_id_0027
    case translate_id_0028
    case translate_id_0029
    case translate_id_0030
    case translate_id_0031
    case translate_id_0032
    case translate_id_0033
    case translate_id_0034
    case translate_id_0035
    case translate_id_0036
    case translate_id_0037
    case translate_id_0038
    case translate_id_0039
    case translate_id_0040
    case translate_id_0041
    case translate_id_0042
    case translate_id_0043
    case translate_id_0044
    case translate_id_0045
    case translate_id_0046
    case translate_id_0047
    case translate_id_0048
    case translate_id_0049
    case translate_id_0050
    
    case translate_id_0051
    case translate_id_0052
    case translate_id_0053
    case translate_id_0054
    case translate_id_0055
    case translate_id_0056
    case translate_id_0057
    case translate_id_0058
    case translate_id_0059
    case translate_id_0060
    
    case translate_id_0061
    case translate_id_0062
    case translate_id_0063
    case translate_id_0064
    case translate_id_0065
    case translate_id_0066
    case translate_id_0067
    case translate_id_0068
    case translate_id_0069
    case translate_id_0070
    
    case translate_id_0071
    case translate_id_0072
    case translate_id_0073
    case translate_id_0074
    case translate_id_0075
    case translate_id_0076
    case translate_id_0077
    case translate_id_0078
    case translate_id_0079
    case translate_id_0080
    
    case translate_id_0081
    case translate_id_0082
    case translate_id_0083
    case translate_id_0084
    case translate_id_0085
    case translate_id_0086
    case translate_id_0087
    case translate_id_0088
    case translate_id_0089
    case translate_id_0090
    
    case translate_id_0091
    case translate_id_0092
    case translate_id_0093
    case translate_id_0094
    case translate_id_0095
    case translate_id_0096
    case translate_id_0097
    case translate_id_0098
    case translate_id_0099
    case translate_id_0100
}

enum AppImages: String {
//    common
    case defaultProfile = "default_profile"
//    Login
    case logo = "Logo"
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
