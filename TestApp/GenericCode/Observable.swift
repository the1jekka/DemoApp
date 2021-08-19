import Foundation

class Observable<T>: ObservableProtocol {
    var observers: [WeakBox<AnyObserver>] = []
    
    var value: T {
        didSet {
            self.notifyObservers(self.observers.compactMap { $0.value })
        }
    }
    
    init(value: T) {
        self.value = value
    }
    
    func addObserver(_ observer: AnyObserver) {
        guard !self.observers.contains(where: { $0.value?.id == observer.id }) else { return }
        self.observers.append(WeakBox(value: observer))
    }
    
    func removeObserver(_ observer: AnyObserver) {
        guard let index = self.observers.firstIndex(where: { $0.value?.id == observer.id }) else { return }
        self.observers.remove(at: index)
    }
    
    func notifyObservers(_ observers: [AnyObserver]) {
        observers.forEach { $0.onValueChanged(self.value) }
    }
    
    deinit {
        self.observers.removeAll()
    }
}
