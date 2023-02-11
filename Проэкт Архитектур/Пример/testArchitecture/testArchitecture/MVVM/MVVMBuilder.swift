//
//  MVVMBuilder.swift
//  testArchitecture
//
//  Created by Константин Ирошников on 16.09.2022.
//

import UIKit

final class MVVMBuilder {
    static func build() -> UIViewController {
        let VC = MVVMViewController()
        let VM = MVVMViewModel()
        
        VC.VM = VM
        
        return VC
    }
}
