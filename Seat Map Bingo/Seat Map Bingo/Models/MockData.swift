//
//  MockData.swift
//  Seat Map Bingo
//
//  Created by Evan Bakkal on 10/22/24.
//

import Foundation

struct MockData {
//    static func mockMax8SeatMap() -> SeatMaps {
//        return SeatMaps(deck: Deck(deckConfiguration: DeckDimensions(width: 7,
//                                                                       length: 3,
//                                                                       startSeatRow: 1,
//                                                                       endSeatRow: 30,
//                                                                       startWingsX: 8,
//                                                                       endWingsX: 17,
//                                                                       startWingsRow: 8,
//                                                                       endWingsRow: 17,
//                                                                       exitRowsX: [14, 16]
//                                                                      ),
//                                  facilities: [
//                                    // Rear Galley
//                                    Facility(code: "G",
//                                             column: "A",
//                                             row: "31",
//                                             position: "REAR",
//                                             coordinates: Coordinates(x: 31, y: 0)
//                                            ),
//                                    Facility(code: "G",
//                                             column: "B",
//                                             row: "31",
//                                             position: "REAR",
//                                             coordinates: Coordinates(x: 31, y: 1)
//                                            ),
//                                    Facility(code: "G",
//                                             column: "C",
//                                             row: "31",
//                                             position: "REAR",
//                                             coordinates: Coordinates(x: 31, y: 2)
//                                            ),
//                                    Facility(code: "G",
//                                             column: "D",
//                                             row: "31",
//                                             position: "REAR",
//                                             coordinates: Coordinates(x: 31, y: 4)
//                                            ),
//                                    Facility(code: "G",
//                                             column: "E",
//                                             row: "31",
//                                             position: "REAR",
//                                             coordinates: Coordinates(x: 31, y: 5)
//                                            ),
//                                    Facility(code: "G",
//                                             column: "F",
//                                             row: "31",
//                                             position: "REAR",
//                                             coordinates: Coordinates(x: 31, y: 6)
//                                            ),
//                                    // Front Left Lav
//                                    Facility(code: "LA",
//                                             column: "A",
//                                             row: "0",
//                                             position: "FRONT",
//                                             coordinates: Coordinates(x: 0, y: 0)
//                                            ),
//                                    Facility(code: "LA",
//                                             column: "B",
//                                             row: "0",
//                                             position: "FRONT",
//                                             coordinates: Coordinates(x: 0, y: 1)
//                                            ),
//                                    Facility(code: "LA",
//                                             column: "C",
//                                             row: "0",
//                                             position: "FRONT",
//                                             coordinates: Coordinates(x: 0, y: 2)
//                                            ),
//                                    // Front Right Lav
//                                    Facility(code: "LA",
//                                             column: "D",
//                                             row: "0",
//                                             position: "FRONT",
//                                             coordinates: Coordinates(x: 0, y: 4)
//                                            ),
//                                    Facility(code: "LA",
//                                             column: "E",
//                                             row: "0",
//                                             position: "FRONT",
//                                             coordinates: Coordinates(x: 0, y: 5)
//                                            ),
//                                    Facility(code: "LA",
//                                             column: "F",
//                                             row: "0",
//                                             position: "FRONT",
//                                             coordinates: Coordinates(x: 0, y: 6)
//                                            ),
//                                    // Rear Left Lav
//                                    Facility(code: "LA",
//                                             column: "A",
//                                             row: "30",
//                                             position: "FRONT",
//                                             coordinates: Coordinates(x: 30, y: 0)
//                                            ),
//                                    Facility(code: "LA",
//                                             column: "B",
//                                             row: "30",
//                                             position: "FRONT",
//                                             coordinates: Coordinates(x: 30, y: 1)
//                                            ),
//                                    Facility(code: "LA",
//                                             column: "C",
//                                             row: "30",
//                                             position: "FRONT",
//                                             coordinates: Coordinates(x: 30, y: 2)
//                                            ),
//                                    // Rear Left Lav
//                                    Facility(code: "LA",
//                                             column: "D",
//                                             row: "30",
//                                             position: "FRONT",
//                                             coordinates: Coordinates(x: 30, y: 4)
//                                            ),
//                                    Facility(code: "LA",
//                                             column: "E",
//                                             row: "30",
//                                             position: "FRONT",
//                                             coordinates: Coordinates(x: 30, y: 5)
//                                            ),
//                                    Facility(code: "LA",
//                                             column: "F",
//                                             row: "30",
//                                             position: "FRONT",
//                                             coordinates: Coordinates(x: 30, y: 6)
//                                            )
//                                  ],
//                                  seats: [
//                                    Seat(number: "1D",
//                                         characteristicsCodes: [],
//                                         coordinates: Coordinates(x: 1, y: 4),
//                                         isSelected: false
//                                        ),
//                                    Seat(number: "1E",
//                                         characteristicsCodes: [],
//                                         coordinates: Coordinates(x: 1, y: 5),
//                                         isSelected: false
//                                        ),
//                                    Seat(number: "1F",
//                                         characteristicsCodes: [],
//                                         coordinates: Coordinates(x: 1, y: 6),
//                                         isSelected: false
//                                        ),
//                                    Seat(number: "2A",
//                                         characteristicsCodes: [],
//                                         coordinates: Coordinates(x: 2, y: 0),
//                                         isSelected: false
//                                        ),
//                                    Seat(number: "2B",
//                                         characteristicsCodes: [],
//                                         coordinates: Coordinates(x: 2, y: 1),
//                                         isSelected: false
//                                        ),
//                                    Seat(number: "2C",
//                                         characteristicsCodes: [],
//                                         coordinates: Coordinates(x: 2, y: 2),
//                                         isSelected: false
//                                        ),
//                                    Seat(number: "2D",
//                                         characteristicsCodes: [],
//                                         coordinates: Coordinates(x: 2, y: 4),
//                                         isSelected: false
//                                        ),
//                                    Seat(number: "2E",
//                                         characteristicsCodes: [],
//                                         coordinates: Coordinates(x: 2, y: 5),
//                                         isSelected: false
//                                        ),
//                                    Seat(number: "2F",
//                                         characteristicsCodes: [],
//                                         coordinates: Coordinates(x: 2, y: 6),
//                                         isSelected: false
//                                        )
//                                  ]
//        )
//        )
//    }
}
