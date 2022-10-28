//
//  Storyboard.swift
//  Ceorooms
//
//  Created by Oleg Matveev on 24/12/2018.
//
import UIKit

enum Storyboard: String {
    case registration = "Registration"


    func getStoryboard() -> UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: nil)
    }
}
