//
//  Publishers+Extensions.swift
//  BatteryBuddy
//
//  Created by Jay Lau on 10/5/24.
//

import Combine

extension Publishers {
    struct WithPreviousValue<Upstream: Publisher>: Publisher {
        typealias Output = (Upstream.Output?, Upstream.Output)
        typealias Failure = Upstream.Failure
        
        private let upstream: Upstream
        
        init(upstream: Upstream) {
            self.upstream = upstream
        }
        
        func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
            upstream.scan((nil, nil)) { ($0.1, $1) }
                .filter { $0.1 != nil }
                .map { ($0.0, $0.1!) }
                .receive(subscriber: subscriber)
        }
    }
}

extension Publisher {
    func withPreviousValue() -> Publishers.WithPreviousValue<Self> {
        return Publishers.WithPreviousValue(upstream: self)
    }
}
