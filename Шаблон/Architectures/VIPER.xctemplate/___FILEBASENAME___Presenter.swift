//___FILEHEADER___

import UIKit
import SMBCoreUI

protocol ___VARIABLE_productName:identifier___PresenterProtocol: ___VARIABLE_productName:identifier___PresenterOutput {
}

protocol ___VARIABLE_productName:identifier___PresenterOutput: AnyObject {
}

final class ___VARIABLE_productName:identifier___Presenter: NSObject, ___VARIABLE_productName:identifier___PresenterProtocol {
    weak var view: ___VARIABLE_productName:identifier___ViewControllerProtocol?

    private let interactor: ___VARIABLE_productName:identifier___InteractorProtocol
    private let router: ___VARIABLE_productName:identifier___RouterProtocol

    weak var output: ___VARIABLE_productName:identifier___Output?

    // MARK: - Initialization

    required init(interactor: ___VARIABLE_productName:identifier___InteractorProtocol, router: ___VARIABLE_productName:identifier___RouterProtocol, output: ___VARIABLE_productName:identifier___Output? = nil) {
        self.interactor = interactor
        self.router = router
        self.output = output
    }
}

// MARK: - ___VARIABLE_productName:identifier___PresenterOutput

extension ___VARIABLE_productName:identifier___Presenter: ___VARIABLE_productName:identifier___PresenterOutput {
}

