//
//  Builder.swift
//  combineTest
//
//  Created by Константин Ирошников on 11.06.2022.
//

import UIKit

final class Builder {
    private static var storyboard: UIStoryboard {
        UIStoryboard(name: "Main", bundle: nil)
    }

    static func generateVC() -> UIViewController {
        guard
            let VC = storyboard.instantiateViewController(identifier: "ViewController") as? ViewController
        else {
            return UIViewController()
        }

        return VC
    }

    static func generateVC1() -> UIViewController {
        guard
            let VC = storyboard.instantiateViewController(withIdentifier: "ViewController1") as? ViewController1
        else {
            return UIViewController()
        }

        return VC
    }

    static func generateVC2() -> UIViewController {
        guard
            let VC = storyboard.instantiateViewController(withIdentifier: "ViewController2") as? ViewController2
        else {
            return UIViewController()
        }

        return VC
    }
}
