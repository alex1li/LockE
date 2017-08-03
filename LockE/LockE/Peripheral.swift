//
//  Peripheral.swift
//  LockE Controller
//
//  Created by Alexander Li on 6/29/17.
//  Copyright © 2017 Alexander Li. All rights reserved.
//

import UIKit
import CoreBluetooth

class Peripheral {
    
    //MARK: Properties
    
    var name: String //Name of the Peripheral + last 2 digits of UUID
    var realPeripheral: CBPeripheral
    var UUID: String
    
    static var peripherals = [Peripheral]()
    static var peripheralNames = [String]()
    static var UUIDs = [String]()
    
    static var chosenPeripheralIndex: Int?
    static var peripheralChosen = false;
    
    //MARK: Initialization
    
    init(name: String, UUID: String, realPeripheral: CBPeripheral) {
        // Initialize stored properties.
        self.name = name
        self.realPeripheral = realPeripheral
        self.UUID = UUID
    }
}
