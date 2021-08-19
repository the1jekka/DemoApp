import Foundation

enum APIError: Error {
    case decoding
    case wrapped(Error)
    case unknown
}
