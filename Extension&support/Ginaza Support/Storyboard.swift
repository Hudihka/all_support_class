//
//  Storyboard.swift
//  Ceorooms
//
//  Created by Oleg Matveev on 24/12/2018.
//
import UIKit

enum Storyboard: String {
    case auth = "Auth"
    case main = "Main"
    case registration = "Registration"
    case support = "SupportStoryboard"
    case profile = "Profile"
    case catalog = "Catalog"
    case page = "Page"

    func getStoryboard() -> UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: nil)
    }
}
