//  main.swift
//  Lesson7
//
//  Created by Rayen on 7/23/20.
//  Copyright © 2020 Rayen. All rights reserved.
//

import Foundation

struct Tickets {
    internal var price: Int
    internal var count: Int
    internal var product: Product
}

internal enum SaleError: Error {
    case TicketsAreOut
    case empty
    case notEnoughPay
}
internal enum UnknownError: Error {
    case unknown
    
}
internal struct Product {
    internal var name: String
}
class SaleTerminal {
    internal var inventory = [Tickets(price: 3200, count: 250, product: Product(name: "Moscow - St.Peterburg")),
                              Tickets(price: 2700, count: 45, product: Product(name: "Moscow - Velikie Luki")) ]
    internal var pay = 0
    
    internal func getProduct(name: String) throws -> Product {
        guard let item = inventory.first(where: { $0.product.name == name}) else {
            throw SaleError.TicketsAreOut
        }
        if item.count == 0 {
            throw SaleError.empty
        }
        if item.price > pay {
            throw SaleError.notEnoughPay
        }
        throw UnknownError.unknown
        return item.product
    }
}
let terminal = SaleTerminal()
terminal.pay = 5000

do {
    var buy = try terminal.getProduct(name: "AirLines")
} catch SaleError.TicketsAreOut {
    print("Билеты на данный рейс отсутствуют")
} catch SaleError.notEnoughPay {
    print("Недостаточно средств для списания")
} catch UnknownError.unknown {
    print("Неизвестная ошибка. Попробуйте повторить запрос")
}
