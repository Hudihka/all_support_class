//
//  AccountConection.swift
//  GinzaGO
//
//  Created by Username on 26.08.2019.
//  Copyright © 2019 ITMegastar. All rights reserved.
//

import Foundation

class AccountConection: NSObject {   ///здесь собраны функции которые необходимо провернуть при авторизации/логауте юзера

    static let shared = AccountConection()

    func playAplication(_ window: UIWindow?) {
        self.initContens()

        if !KeysUDef.firstPlayApplication.getBool() {
            window?.rootViewController = Storyboard.page.getStoryboard().instantiateInitialViewController()
        } else {
            if let account = DefaultsUtils.currentAccount() {
                account.reloadServerThroughAccaunt()    //перезагрузка сервера
                window?.rootViewController = Storyboard.main.getStoryboard().instantiateInitialViewController()
            } else {
                window?.rootViewController = Storyboard.registration.getStoryboard().instantiateInitialViewController()
            }
        }
    }

    private func initContens() {
        CoreDataManager.shared.initialize()
        SupportCoreData.deletePurchfse() //удаляем все пукупки что больше 40той
    }

    func exsitAplication() {
        CoreDataManager.shared.save()
        SaveImageClass.removeFrieDayObject()
        if KeysUDef.askedQuestionPfotoLibs.getBool() {
            ManagerLibsUserPhoto.shared.clearCash()
        }
    }

    func logAuht() {
        //да бы подтянуть все покупки при повторной
        //авторизации при выходе из аккаунта мы удаляем все покупки
        SupportCoreData.deleteAllEntity(nameEntity: Purchase.entityName())

        let window: UIWindow? = UIApplication.shared.keyWindow
        let VC = Storyboard.registration.getStoryboard().instantiateInitialViewController()
        window?.transitionRoot(to: VC)

        CoreDataManager.shared.changeContext(for: nil)
        DefaultsUtils.deleteAccountAndSession()

        appDelegateShared().deleteTocken()

        ChatManager.shared.logAutt()
    }

    func start(account: Account, sessionId: String) {
        let strId = String(format: "%d", account.id)
        CoreDataManager.shared.changeContext(for: strId)

        DefaultsUtils.set(currentAccount: account)
        DefaultsUtils.set(sessionID: sessionId)

        SupportOrders.reloadLastPurchase() //что бы не было ситуации когда появляется надпись "неоплачен заказ номер 0"

        let VC = Storyboard.main.getStoryboard().instantiateInitialViewController()
        UIApplication.shared.getWorkVC().customTransition(VC: VC)
    }
}
