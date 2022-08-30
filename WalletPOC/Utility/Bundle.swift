//
//  Bundle.swift
//  skeleton
//
//  Created by Botond Magyarosi on 04/02/2021.
//

import Foundation

extension Bundle {

    var versionNumber: String {
    #if RELEASE
        return releaseVersionNumber
    #else
        return "\(releaseVersionNumber) (\(buildVersionNumber))"
    #endif
    }

    var releaseVersionNumber: String {
        infoDictionary?["CFBundleShortVersionString"] as? String ?? "-"
    }

    /// Returns
    var buildVersionNumber: String {
        infoDictionary?["CFBundleVersion"] as? String ?? "-"
    }
}
