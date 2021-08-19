import Foundation

struct HotelsListActions {
    let showHotelDetails: ShowHotelDetailsAction
    let finish: FinishAction
    
    typealias ShowHotelDetailsAction = (Int) -> Void
    typealias FinishAction = () -> Void
}
