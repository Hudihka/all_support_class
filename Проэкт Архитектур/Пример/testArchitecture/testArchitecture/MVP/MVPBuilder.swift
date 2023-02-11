//
//  MVPBuilder.swift
//  testArchitecture
//
//  Created by Константин Ирошников on 16.09.2022.
//

import UIKit

final class MVPBuilder {
    static func build() -> UIViewController {
        let VC = MVPViewController()
        let presenter = MVPPresenter(VC: VC)
        
        VC.presenter = presenter
        
        return VC
    }
}
