import Foundation

extension DGError {
    enum Converting {
        case stringFromData(_ data: Data)
        case dataFromBase64(_ string: String)
        case urlFromString(_ string: String)
    }
}
