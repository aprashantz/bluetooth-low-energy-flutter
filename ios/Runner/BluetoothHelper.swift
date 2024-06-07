import Foundation
import CoreBluetooth
import AVFoundation

class BluetoothHelper: NSObject, CBCentralManagerDelegate {
    var centralManager: CBCentralManager?
    var targetPeripheral: CBPeripheral?

    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            // Bluetooth is on
        }
    }

    func connectToAudioDevice(deviceId: String) {
        let peripherals = centralManager?.retrievePeripherals(withIdentifiers: [UUID(uuidString: deviceId)!])
        if let peripheral = peripherals?.first {
            targetPeripheral = peripheral
            centralManager?.connect(peripheral, options: nil)
        }
    }

    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default, options: [.allowBluetooth])
            try audioSession.setActive(true)
        } catch {
            print("Failed to set audio session category.")
        }
    }
}
