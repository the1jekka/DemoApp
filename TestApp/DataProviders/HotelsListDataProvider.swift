import Foundation

protocol HotelsListDataProvider {
    var hotels: Observable<[HotelListItem]> { get }
    func refresh(completion: (() -> Void)?)
}

final class DefaultHotelsListDataProvider: HotelsListDataProvider {
    typealias Dependencies = HasAPIService
    
    private let dependencies: Dependencies
    let hotels = Observable<[HotelListItem]>(value: [])
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func refresh(completion: (() -> Void)?) {
        self.dependencies.apiService.fetchHotelsList(id: "0777") { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .failure:
                    self?.hotels.value = []
                case let .success(values):
                    self?.hotels.value = values
                }
                
                completion?()
            }
        }
    }
}
