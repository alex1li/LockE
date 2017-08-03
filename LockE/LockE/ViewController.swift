//
//  ViewController.swift
//  LockE Controller
//
//  Created by Alexander Li on 6/26/17.
//  Copyright © 2017 Alexander Li. All rights reserved.
//
//  Acknoledgements:
//  https://www.cloudcity.io/blog/2016/09/09/zero-to-ble-on-ios--part-two---swift-edition/
//  https://ladvien.com/robots/connect-an-arduino-to-iphone/

import UIKit
import CoreBluetooth

class ViewController: UIViewController,CBCentralManagerDelegate, CBPeripheralDelegate {
    
    //MARK: Navigation
    @IBAction func unwindToFromDone(sender: UIStoryboardSegue) {
        if (Peripheral.peripheralChosen){
            backgroundView.backgroundColor = UIColor.white
            keepScanning = false
            let temp = Peripheral.peripherals
            sensorTag = temp[Peripheral.chosenPeripheralIndex!].realPeripheral
            sensorTag!.delegate = self
            centralManager.connect(sensorTag!, options: nil)
            disconnectButtonOutlet.isEnabled = true;
            searchButtonOutlet.isEnabled = false
    }
    }
    
    //MARK! buttons for driving
    @IBOutlet weak var frontButton: UIButton!
    var timer: Timer!
    func frontButtonDown(sender: AnyObject) {
        frontSingleFire()
    //    timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.frontRapidFire), userInfo: nil, repeats: true)
    }
    func frontButtonUp(sender: AnyObject) {
        print("stop!")
        //timer.invalidate()
        var number: NSInteger = 48
        let enablebytes = NSData(bytes: &number, length: MemoryLayout<NSInteger>.size)
        sensorTag?.writeValue(enablebytes as Data, for: sensorCharacteristic!, type: .withoutResponse)
    }
    func frontSingleFire() {
        print("start!")
        var number: NSInteger = 49
        let enablebytes = NSData(bytes: &number, length: MemoryLayout<NSInteger>.size)
        sensorTag?.writeValue(enablebytes as Data, for: sensorCharacteristic!, type: .withoutResponse)
    }
    //func frontRapidFire() {
    //   print("----")
    //}
    
    @IBOutlet weak var rightButton: UIButton!
    func rightButtonDown(sender: AnyObject) {
        rightSingleFire()
        //timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.rightRapidFire), userInfo: nil, repeats: true)
    }
    func rightButtonUp(sender: AnyObject) {
        print("stop!")
        //timer.invalidate()
        var number: NSInteger = 48
        let enablebytes = NSData(bytes: &number, length: MemoryLayout<NSInteger>.size)
        sensorTag?.writeValue(enablebytes as Data, for: sensorCharacteristic!, type: .withoutResponse)
    }
    func rightSingleFire() {
        print("start!")
        var number: NSInteger = 52
        let enablebytes = NSData(bytes: &number, length: MemoryLayout<NSInteger>.size)
        sensorTag?.writeValue(enablebytes as Data, for: sensorCharacteristic!, type: .withoutResponse)
    }
    //func rightRapidFire() {
    //    print("----")
    //}
    
    @IBOutlet weak var backButton: UIButton!
    func backButtonDown(sender: AnyObject) {
        backSingleFire()
        //timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.backRapidFire), userInfo: nil, repeats: true)
    }
    func backButtonUp(sender: AnyObject) {
        print("stop!")
        //timer.invalidate()
        var number: NSInteger = 48
        let enablebytes = NSData(bytes: &number, length: MemoryLayout<NSInteger>.size)
        sensorTag?.writeValue(enablebytes as Data, for: sensorCharacteristic!, type: .withoutResponse)
    }
    func backSingleFire() {
        print("start!")
        var number: NSInteger = 50
        let enablebytes = NSData(bytes: &number, length: MemoryLayout<NSInteger>.size)
        sensorTag?.writeValue(enablebytes as Data, for: sensorCharacteristic!, type: .withoutResponse)
    }
    //func backRapidFire() {
    //    print("----")
    //}
    
    @IBOutlet weak var leftButton: UIButton!
    func leftButtonDown(sender: AnyObject) {
        leftSingleFire()
        //timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.leftRapidFire), userInfo: nil, repeats: true)
    }
    func leftButtonUp(sender: AnyObject) {
        print("stop!")
        //timer.invalidate()
        var number: NSInteger = 48
        let enablebytes = NSData(bytes: &number, length: MemoryLayout<NSInteger>.size)
        sensorTag?.writeValue(enablebytes as Data, for: sensorCharacteristic!, type: .withoutResponse)
    }
    func leftSingleFire() {
        print("start!")
        var number: NSInteger = 51
        let enablebytes = NSData(bytes: &number, length: MemoryLayout<NSInteger>.size)
        sensorTag?.writeValue(enablebytes as Data, for: sensorCharacteristic!, type: .withoutResponse)
    }
    //func leftRapidFire() {
    //    print("----")
    //}
    
    
    
    @IBAction func fireButton(_ sender: Any) {
        print("FIRE!")
        var number: NSInteger = 53
        let enablebytes = NSData(bytes: &number, length: MemoryLayout<NSInteger>.size)
        sensorTag?.writeValue(enablebytes as Data, for: sensorCharacteristic!, type: .withoutResponse)
    }

    
    
    //MARK! Connection Labels
    @IBOutlet var backgroundView: UIView!
    
    @IBOutlet weak var disconnectButtonOutlet: UIBarButtonItem!
    @IBAction func disconnectButton(_ sender: Any) {
        //if (bluetoothConnected){
        centralManager.cancelPeripheralConnection(sensorTag!)
    }
    
    @IBOutlet weak var searchButtonOutlet: UIBarButtonItem!
    

    
    //MARK: Bluetooth variables
    let timerPauseInterval:TimeInterval = 5.0
    let timerScanInterval:TimeInterval = 2.0
    let sensorName = "changed SH-HC-08" //CHANGEEEEEEE!!!!!!!!!!!
    
    
    
    //^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    var serviceUUID = "FFE0"
    var characteristicUUID = "FFE1"
    var keepScanning = false;
    var centralManager:CBCentralManager!
    var sensorTag:CBPeripheral?
    var sensorCharacteristic:CBCharacteristic?
    
    var bluetoothConnected = false;
    var valueSent = "1";
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        centralManager = CBCentralManager(delegate: self, queue: nil)
        
        frontButton.addTarget(self, action:#selector(frontButtonDown(sender:)), for: .touchDown)
        frontButton.addTarget(self, action:#selector(frontButtonUp(sender:)), for: [.touchUpInside, .touchUpOutside])
        
        rightButton.addTarget(self, action:#selector(rightButtonDown(sender:)), for: .touchDown)
        rightButton.addTarget(self, action:#selector(rightButtonUp(sender:)), for: [.touchUpInside, .touchUpOutside])
        
        backButton.addTarget(self, action:#selector(backButtonDown(sender:)), for: .touchDown)
        backButton.addTarget(self, action:#selector(backButtonUp(sender:)), for: [.touchUpInside, .touchUpOutside])
        
        leftButton.addTarget(self, action:#selector(leftButtonDown(sender:)), for: .touchDown)
        leftButton.addTarget(self, action:#selector(leftButtonUp(sender:)), for: [.touchUpInside, .touchUpOutside])
        
        disconnectButtonOutlet.isEnabled = false;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - CBCentralManagerDelegate methods
    
    // Invoked when the central manager’s state is updated.
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        var showAlert = true
        var message = ""
        
        switch central.state {
        case .poweredOff:
            message = "Bluetooth on this device is currently powered off."
        case .unsupported:
            message = "This device does not support Bluetooth Low Energy."
        case .unauthorized:
            message = "This app is not authorized to use Bluetooth Low Energy."
        case .resetting:
            message = "The BLE Manager is resetting; a state update is pending."
        case .unknown:
            message = "The state of the BLE Manager is unknown."
        case .poweredOn:
            showAlert = false
            message = "Bluetooth LE is turned on and ready for communication."
            
            print(message)
            keepScanning = true
            _ = Timer(timeInterval: timerScanInterval, target: self, selector: #selector(pauseScan), userInfo: nil, repeats: false)
            
            //Option 1: Scan for all devices
            //centralManager.scanForPeripherals(withServices: nil, options: nil)
            
            // Option 2: Scan for devices that have the service you're interested in...
            let sensorTagAdvertisingUUID = CBUUID(string: serviceUUID)
            centralManager.scanForPeripherals(withServices: [sensorTagAdvertisingUUID], options: nil)
        }
        
        if showAlert {
            let alertController = UIAlertController(title: "Central Manager State", message: message, preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            alertController.addAction(okAction)
            self.show(alertController, sender: self)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("**** SUCCESSFULLY CONNECTED TO SENSOR TAG!!!")
        UIView.animate(withDuration: 0.5, animations: { () -> Void in self.backgroundView.backgroundColor = UIColor.blue })
        bluetoothConnected = true;
        peripheral.discoverServices(nil)
        pauseScan()
    }
    
    /*
    Invoked when the central manager discovers a peripheral while  scanning.
    */
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        // Retrieve the peripheral name from the advertisement data using the "kCBAdvDataLocalName" key
        if let peripheralName = advertisementData[CBAdvertisementDataLocalNameKey] as? String {
            let UUID = peripheral.identifier.uuidString
            let index = UUID.index(UUID.startIndex, offsetBy: UUID.characters.count-2)
            let shorterUUID = UUID.substring(from: index)
            //print("NEXT PERIPHERAL NAME: \(peripheralName)")
            print("NEXT PERIPHERAL UUID: \(peripheral.identifier.uuidString)")
            print ("NEXT PERIPHERAL: \(peripheralName) \(shorterUUID)")
            print(advertisementData)
            if (!Peripheral.UUIDs.contains(UUID)){
                let foundPeripheral = Peripheral(name: peripheralName + " " + shorterUUID, UUID: UUID, realPeripheral: peripheral)
                Peripheral.peripherals.append(foundPeripheral)
                Peripheral.peripheralNames.append(foundPeripheral.name)
                Peripheral.UUIDs.append(foundPeripheral.UUID)
            }
        }
    }
    
    /*
     Invoked when you discover the peripheral’s available services.
    When the specified services are discovered, the peripheral calls the peripheral:didDiscoverServices: method of its delegate object.
    */
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if error != nil {
            print("ERROR DISCOVERING SERVICES")
            return
        }
        
        // Core Bluetooth creates an array of CBService objects —- one for each service that is discovered on the peripheral.
        if let services = peripheral.services {
            for service in services {
                //print("Discovered service \(service)")
                if (service.uuid == CBUUID(string: serviceUUID)) {
                    peripheral.discoverCharacteristics(nil, for: service)
                }
            }
        }
    }
    
    /*
     Invoked when you discover the characteristics of a specified service.
     
     If the characteristics of the specified service are successfully discovered, you can access
     them through the service's characteristics property.
     
     If successful, the error parameter is nil.
     If unsuccessful, the error parameter returns the cause of the failure.
     */
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if error != nil {
            print("ERROR DISCOVERING CHARACTERISTICS")
            return
        }
        
        if let characteristics = service.characteristics {
            
            for characteristic in characteristics {
                // Temperature Data Characteristic
                //print("Characteristic \(characteristic)")
                if characteristic.uuid == CBUUID(string: characteristicUUID) {
                    print("FOUND CHARACTERISTIC")
                    sensorCharacteristic = characteristic
                    sensorTag?.setNotifyValue(true, for: characteristic)
                }
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        
        if (error != nil) {
            print("Error reading characteristics")
            return;
        }
        
        if (characteristic.value != nil) {
            let dataBLE = String(data: characteristic.value!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            if (dataBLE != nil){
                let index = dataBLE?.index((dataBLE?.startIndex)!, offsetBy: 1)
                let shorterDataBLE = dataBLE?.substring(to: index!)
                if (shorterDataBLE == "I"){
                    hitByIR()
                }
                if (shorterDataBLE == "N"){
                    normalAgain()
                }
            }
        }
        
    }
    
    func hitByIR(){
       UIView.animate(withDuration: 0.3, animations: { () -> Void in self.backgroundView.backgroundColor = UIColor.black })
        print("***IR***")
    
    }
    
    func normalAgain(){
        UIView.animate(withDuration: 0.3, animations: { () -> Void in self.backgroundView.backgroundColor = UIColor.blue })
        print("NORMAL")
        
    }
    
    
    
    
    /*
     Invoked when an existing connection with a peripheral is torn down.
     
     This method is invoked when a peripheral connected via the connectPeripheral:options: method is disconnected.
     If the disconnection was not initiated by cancelPeripheralConnection:, the cause is detailed in error.
     Note that when a peripheral is disconnected, all of its services, characteristics, and characteristic descriptors are invalidated.
     */
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        bluetoothConnected = false;
        Peripheral.peripheralChosen = false;
        UIView.animate(withDuration: 0.5, animations: { () -> Void in self.backgroundView.backgroundColor = UIColor.red })
        print("**** DISCONNECTED FROM SENSOR TAG!!!")
        sensorTag = nil
        keepScanning = true
        resumeScan()
        
        disconnectButtonOutlet.isEnabled = false;
        searchButtonOutlet.isEnabled = true
    }
    
/*
    func sendValue(_ str: String) {
        //var myData = [Data]()
        //var controlByte: Int = 0
        let enablebytes = NSData(bytes: &valueSent, length: MemoryLayout<NSInteger>.size)
        // Create a string with all the data, formatted in ASCII.
        let str = String(data: enablebytes as Data, encoding: String.Encoding.utf8) as String!
        // Add the end-of-transmission character to allow the
        // Arduino to parse the string
        // Write the str variable with all our movement data.
        sensorTag?.writeValue((str?.data(using: String.Encoding.utf8)!)!, for: sensorCharacteristic!, type: .withoutResponse)
        print(str)
    }
    */

    // MARK: - Bluetooth scanning
    
    func pauseScan() {
        // Scanning uses up battery on phone, so pause the scan process for the designated interval.
        print("*** PAUSING SCAN...")
        _ = Timer(timeInterval: timerPauseInterval, target: self, selector: #selector(resumeScan), userInfo: nil, repeats: false)
        centralManager.stopScan()
    }
    
    func resumeScan() {
        if keepScanning {
            // Start scanning again...
            print("*** RESUMING SCAN!")
            _ = Timer(timeInterval: timerScanInterval, target: self, selector: #selector(pauseScan), userInfo: nil, repeats: false)
            let sensorTagAdvertisingUUID = CBUUID(string: serviceUUID)
            centralManager.scanForPeripherals(withServices: [sensorTagAdvertisingUUID], options: nil)
        }
    }
    

}

