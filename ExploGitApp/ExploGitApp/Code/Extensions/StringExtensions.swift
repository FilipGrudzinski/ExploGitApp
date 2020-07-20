//
//  StringExtensions.swift
//  ExploGitApp
//
//  Created by Filip Grudziński on 20/07/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import Foundation

extension String {
    static let empty = ""
    static let space = " "
    static let dash = "-"
    static let plus = "+"
    static let dot = "."
    static let threeDot = "..."
    static let comma = ","
    static let newLine = "\n"
    static let backspace = "/"
    static let colon = ":"
    static let quoteSign = "\""
    static let quoteSignToRemove = "&quot;"
    static let htmlTags = "<[^>]+>"
    static let openParenthesis = "("
    static let closeParenthesis = ")"
    static let hourMinuteFormat = "HH:mm"
    static let dateShortFormat = "dd.MM.yy"
    static let dateFormatWithDoubleSpaceAtTheEnd = "dd.MM.yy "
    static let apiDateFormat = "yyyy-MM-dd"
    static let spaceDashSpace = " - "
    static let threDecimalPlacesFormat = "%.3f"
}

extension String {
    func removeDoubleQuotes() -> String {
        return self.replacingOccurrences(of: String.quoteSignToRemove, with: String.quoteSign)
    }
    
    func removeHtmlTags() -> String {
        return self.replacingOccurrences(of: String.htmlTags, with: String.empty, options: .regularExpression, range: nil)
    }
}
