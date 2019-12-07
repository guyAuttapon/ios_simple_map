import Foundation

struct InterestingLocation {
    var title: String
    var lat: Double
    var long: Double
}

class SampleLocation {
    static func get() -> [InterestingLocation] {
        return [
            InterestingLocation(title: "Chiang Mai International Airport", lat: 18.774469, long: 98.964731),
            InterestingLocation(title: "Doi Suthep-Pui National Park", lat: 18.813424, long: 98.917479),
            InterestingLocation(title: "Chiang Mai Zoo", lat: 18.811327, long: 98.952604),
            InterestingLocation(title: "Chiang Mai University", lat: 18.796770, long: 98.952400)
        ]
    }
}
