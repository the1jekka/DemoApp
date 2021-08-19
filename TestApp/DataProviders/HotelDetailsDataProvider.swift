import Foundation

protocol HotelDetailsDataProvider {
    var hotel: Observable<HotelDetails?> { get }
    func refresh(completion: (() -> Void)?)
}

final class DefaultHotelDetailsDataProvider: HotelDetailsDataProvider {
    typealias Dependencies = HasAPIService
    
    private let hotelId: Int
    private let dependencies: Dependencies
    let hotel = Observable<HotelDetails?>(value: nil)
    
    init(dependencies: Dependencies, hotelId: Int) {
        self.dependencies = dependencies
        self.hotelId = hotelId
    }
    
    func refresh(completion: (() -> Void)?) {
        dependencies.apiService.fetchHotelDetails(
            id: self.hotelId
        ) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .failure:
                    self?.hotel.value = nil
                case let .success(value):
                    self?.hotel.value = value
                }
                
                completion?()
            }
        }
    }
}
