//
//  Account.swift
//  WalletPOC
//
//  Created by Andrei Gherman on 05.09.2022.
//

import Foundation

struct Account {
    var id: String
    var name: String
    var iban: String
    var amount: String
    //var fact: String
    
  
    
    init(id: String, name: String, iban: String, amount: String) {
        self.id = id
        self.name = name
        self.iban = iban
        self.amount = amount
    }
    
    init(details: [String: Any]) {
        id = details["IBAN"] as? String ?? ""
        name = "name"
        iban = "iban"
        amount = "amount"
        //fact = details["text"] as? String ?? ""
    }
}
