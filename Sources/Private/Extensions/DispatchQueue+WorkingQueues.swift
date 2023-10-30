
import Foundation

extension DispatchQueue {
    static let serial = DispatchQueue(label: "digital.gov.cert.library.serial.queue")
    static let concurrent = DispatchQueue(label: "digital.gov.cert.library.serial.concurrent", attributes: [.concurrent])
}
