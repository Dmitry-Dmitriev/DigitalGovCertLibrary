import Foundation

struct AuthChallengeResult {
    let disposition: URLSession.AuthChallengeDisposition
    let credential: URLCredential?
}
