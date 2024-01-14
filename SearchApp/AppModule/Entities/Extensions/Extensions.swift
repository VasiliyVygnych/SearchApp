//
//  Extensions.swift
//  SearchApp
//
//  Created by Vasiliy Vygnych on 13.01.2024.
//

import UIKit

//MARK: - extension UIFont
extension UIFont {
    enum SFProDisplay: String {
        case bold = "SFProDisplay-Bold"
        case light = "SFProDisplay-Light"
        case regular = "SFProDisplay-Regular"
    }
    class func sFProDisplay(ofSize fonsize: CGFloat,
                            weight: SFProDisplay) -> UIFont {
        return UIFont(name: weight.rawValue,
                      size: fonsize) ?? .systemFont(ofSize: fonsize)
    }
}
//MARK: - extension Data
extension Data {
    func prettyPrintJson() {
        do {
            let json = try JSONSerialization.jsonObject(with: self,
                                                        options: [])
            let data = try JSONSerialization.data(withJSONObject: json,
                                                  options: .prettyPrinted)
            guard let jsonString = String(data: data,
                                          encoding: .utf8) else {
                print("Inavlid data")
                return
            }
            print(jsonString)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
