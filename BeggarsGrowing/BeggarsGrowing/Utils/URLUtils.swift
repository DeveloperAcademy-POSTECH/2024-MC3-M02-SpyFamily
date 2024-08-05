//
//  URLUtils.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 8/6/24.
//

import Foundation
import SwiftUI

struct URLUtils {
    static func openLink(urlString: String) {
        if let url = URL(string: urlString) {
            if isYouTubeLink(urlString: urlString), let videoID = extractYouTubeVideoID(from: urlString), let appURL = URL(string: "youtube://\(videoID)"), canOpenURL(url: appURL) {
                openURL(url: appURL)
            } else {
                openURL(url: url)
            }
        } else {
            print("Invalid URL")
        }
    }

    static func isYouTubeLink(urlString: String) -> Bool {
        return urlString.contains("youtube.com") || urlString.contains("youtu.be")
    }

    static func extractYouTubeVideoID(from urlString: String) -> String? {
        let pattern = #"((?<=(v|V)/|\\?v=|\\&v=|youtu.be/|\\/embed\\/|\\/v\\/|\\/\\?v=|\\/\\&v=))([\w-]+)"#
        if let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive),
           let match = regex.firstMatch(in: urlString, options: [], range: NSRange(location: 0, length: urlString.utf16.count)) {
            if let range = Range(match.range(at: 0), in: urlString) {
                return String(urlString[range])
            }
        }
        return nil
    }

    static func canOpenURL(url: URL) -> Bool {
        return UIApplication.shared.canOpenURL(url)
    }

    static func openURL(url: URL) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
