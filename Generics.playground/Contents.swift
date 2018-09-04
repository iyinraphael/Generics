//: Playground - noun: a place where people can play

import UIKit


// Create a generic CountedSet struct that is constrained to Hashable elements.
// A counted set is an unordered collection of unique elements that may appear more than once in the collection.
// Use a private dictionary as your backing storage for set members and their counts.

struct CountedSet<Element> where Element: Hashable {
    
    
    mutating func insert(_ newElement: Element) {
        if var count = dictSet[newElement]{
            count += 1
            dictSet[newElement] = count
        }else{
            dictSet[newElement] = 1
        }
        
    }
    
    mutating func remove(_ newElement: Element) {
        if var count = dictSet[newElement]{
            count -= 1
            if count == 0{
                dictSet.removeValue(forKey: newElement)
            }else {
                dictSet[newElement] = count
            }
        }
    }
    
    subscript(_ member: Element) -> Int{
        return dictSet[member] ?? 0
    }
    
    
    
    var count: Int {
        return dictSet.count
    }

    var isEmpty: Bool {
        return dictSet.isEmpty
    }
    
    private (set) var dictSet: [Element: Int] = [:]
    
}

extension CountedSet: ExpressibleByArrayLiteral{
    init(arrayLiteral: Element...){
        for element in arrayLiteral{
            self.insert(element)
        }
    }
}


enum Arrow { case iron, wooden, elven, dwarvish, magic, silver}
var aCountedSet = CountedSet<Arrow>()
aCountedSet[.iron]

var myCountedSet: CountedSet<Arrow> = [.iron, .magic, .iron, .silver, .iron, .iron]
myCountedSet[.iron]
myCountedSet.remove(.iron)
myCountedSet.remove(.dwarvish)
myCountedSet.remove(.magic)






