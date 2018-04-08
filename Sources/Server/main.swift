import Async
import HTTP
import NIO
import Vapor
import Foundation
import WebSocket

struct HelloResponder : HTTPResponder {
    func respond(to request: HTTPRequest, on worker: Worker) -> EventLoopFuture<HTTPResponse> {
        let res = HTTPResponse(status: .ok, body: HTTPBody(string: "Hello, world!"))

        return Future.map(on: worker) { res }
    }
}

let server: HTTPServer
let group: MultiThreadedEventLoopGroup

do {
    group = MultiThreadedEventLoopGroup(numThreads: Int(Environment.get("NUM_THREADS") ?? "1") ?? 1)

    server = try HTTPServer.start(
            hostname: Environment.get("HOST") ?? "127.0.0.1",
            port: 8080,
            responder: HelloResponder(),
            upgraders: [ws],
            on: group
    ) {error in
        return
    }.wait()

    print("Starting server")
    try server.onClose.wait()
} catch {
    print(error)
    exit(1)
}
