//___FILEHEADER___

import Foundation
import UIKit

protocol ___VARIABLE_productName:identifier___Output: AnyObject {
}

final class ___VARIABLE_productName:identifier___Builder {
    static func build() -> ___VARIABLE_productName:identifier___ViewController {
        let interactor = ___VARIABLE_productName:identifier___Interactor()
        let router = ___VARIABLE_productName:identifier___Router()
        let presenter = ___VARIABLE_productName:identifier___Presenter(interactor: interactor, router: router)
        let viewController = ___VARIABLE_productName:identifier___ViewController(presenter: presenter)

        presenter.view = viewController
        interactor.presenter = presenter
        router.view = viewController

        return viewController
    }
}
