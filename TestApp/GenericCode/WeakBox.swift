import Foundation

struct WeakBox<T: AnyObject> {
    weak var value: T?
}
