//
//  Actor.swift
//  Подготовка к собесу
//
//  Created by Худышка К on 15.05.2024.
//

import Foundation

actor BankAccount {
    private var balance: Int = 0
    
    // Метод для внесения денег на счет
    func deposit(amount: Int) {
        balance += amount
        print("Деньги внесены на счет: \(amount)")
        print("Новый баланс: \(balance)")
    }
    
    // Метод для снятия денег со счета
    func withdraw(amount: Int) {
        if balance >= amount {
            balance -= amount
            print("Деньги сняты со счета: \(amount)")
            print("Новый баланс: \(balance)")
        } else {
            print("Недостаточно средств на счете")
        }
    }
}


class Actor {
    let account = BankAccount()
    
//    func test() {
//        account.deposit(amount: 100)
//    }
}
