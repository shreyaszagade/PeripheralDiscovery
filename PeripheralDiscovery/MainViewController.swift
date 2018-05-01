//
//  ViewController.swift
//  PeripheralDiscovery
//
//  Created by Shreyas Zagade on 4/28/18.
//  Copyright © 2018 Zagade. All rights reserved.
//

import UIKit
import CoreBluetooth

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var centralManager: CBCentralManager!
    var peripheral = [String:CBPeripheral]()
    var currentState : CBManagerState = .poweredOff
    var selectedPeripheral : CBPeripheral?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centralManager = CBCentralManager(delegate: self, queue: nil)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.estimatedRowHeight = 44.0;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func refreshButtonClicked(_ sender: UIBarButtonItem) {
        
        if currentState != .poweredOn {
            print("Cannot access Bluetooth")
        }else{}
    }
    
}

extension MainViewController : CBCentralManagerDelegate{
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        currentState = central.state
        switch central.state {
        case .poweredOn:
            centralManager.scanForPeripherals(withServices: nil)
        default:
            print("Other state")
        }
        
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        self.peripheral[peripheral.identifier.uuidString] = peripheral
        self.tableView.reloadData()
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("successfully connected to \(peripheral.name)")
    }
    
}

extension MainViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peripheral.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "bluetoothDeviceCell") as! BluetoothDeviceCell
        let tempArray = Array(peripheral)
        cell.nameLabel.text = tempArray[indexPath.row].value.name ?? "N/A"
        cell.uuidLabel.text = tempArray[indexPath.row].value.identifier.uuidString
        return cell
    }
    
}

extension MainViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tempArray = Array(peripheral)
        selectedPeripheral = tempArray[indexPath.row].value
        //selectedPeripheral.delegate = self
        centralManager.stopScan()
        centralManager.connect(selectedPeripheral!)
    }
}
