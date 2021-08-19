import Foundation

protocol ObserverProtocol: AnyObject {
    associatedtype T
    
    var id: String { get }
    func onValueChanged(_ value: T?)
}

final class AnyObserver: ObserverProtocol {
    typealias T = Any
    
    let id: String
    private let _onValueChanged: (T?) -> Void
    
    init<Observer: ObserverProtocol>(observer: Observer) {
        self.id = observer.id
        self._onValueChanged = { [weak observer] in
            guard let value = $0 as? Observer.T else { return }
            observer?.onValueChanged(value)
        }
    }
    
    func onValueChanged<T>(_ value: T?) {
        self._onValueChanged(value)
    }
}
