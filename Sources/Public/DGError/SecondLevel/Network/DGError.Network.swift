import Foundation

public extension DGError {
    enum Network: Error {
        case request(_ req: WebRequestProvider, error: Error)
        case response(error: DGError.Network.Response)
    }
}
