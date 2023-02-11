//
//  MVVMBuilder.swift
//  testArchitecture
//
//  Created by Константин Ирошников on 16.09.2022.
//

import UIKit

final class MVVMBuilder {
    static func build() -> UIViewController {
        let view = MVVMViewController()
        let VM = MVVMViewModel()
        view.VM = VM

        return view
    }
}
