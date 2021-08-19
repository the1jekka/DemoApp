import Foundation

protocol ObservableProtocol {
    associatedtype Observer: ObserverProtocol
    var observers: [WeakBox<Observer>] { get set }
    
    func addObserver(_ observer: Observer)
    func removeObserver(_ observer: Observer)
    func notifyObservers(_ observers: [Observer])
}
