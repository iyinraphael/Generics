import Foundation

// MARK: - Nongeneric function

func swapTwoInts(_ a: inout Int, b: inout Int) {
    let tempA = a
    a = b
    b = tempA
}

var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, b: &anotherInt)
print("SomeInt is now \(someInt), and anotherInt is now \(anotherInt)")


// MARK: - Generic function
/// <T> is a type parameter
func swapTwoValues<T>(_ a: inout T, b: inout T) {
    let tempA = a
    a = b
    b = tempA
}

var someString = "hello"
var anotherString = "Somebody"
swapTwoValues(&someString, b: &anotherString)
swapTwoValues(&someInt, b: &anotherInt)
print("SomeString is now \(someString), and anotherString is now \(anotherString)")
print("SomeInt is now \(someInt), and anotherInt is now \(anotherInt)")

// MARK: - Generic type

struct Stack<Element> {
    var items: [Element] = []
    /// These methods are marked as MUTATING, because they need to modify (or mutate) the structure's item array
    mutating func push(_ item: Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")

let fromTheTop = stackOfStrings.pop()
print(fromTheTop)

extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

if let topItem = stackOfStrings.topItem {
    print("The top item on the stack is \(topItem)")
}

// MARK: - Type constraints

func findIndex<T: Equatable>(of valueToFind: T, in array: [T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let doubleIndex = findIndex(of: 9.3, in: [3.14159, 0.1, 0.25])
let stringIndex = findIndex(of: "Andrea", in: ["Mike", "Malcolm", "Andrea"])

// MARK: - Associated Type

protocol Container {
    associatedtype Item
    mutating func appendItem(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

struct IntStack: Container {
    // original IntStack implementation
    var items: [Int] = []
    mutating func push(_ item: Int) {
        items.append(item)
    }
    
    mutating func pop() -> Int {
        return items.removeLast()
    }
    
    // conformance to the Container protocol
    typealias Item = Int
    mutating func appendItem(_ item: Int) {
        self.push(item)
    }
    
    var count: Int {
        return items.count
    }
    
    subscript(i: Int) -> Int {
        return items[i]
    }
}

extension Stack: Container {
    // conformance to the Container protocol
    mutating func appendItem(_ item: Element) {
        self.push(item)
    }
    
    var count: Int {
        return items.count
    }
    
    subscript(i: Int) -> Element {
        return items[i]
    }
}

// using a protocol in it's associated type's contraints
protocol SuffixableContainer: Container {
    associatedtype Suffix: SuffixableContainer where Suffix.Item == Item
    func suffix(_ size: Int) -> Suffix
}

extension Stack: SuffixableContainer {
    func suffix(_ size: Int) -> Stack {
        var result = Stack()
        for index in (count-size)..<count {
            result.appendItem(self[index])
        }
        return result
    }
}

var stackInts = Stack<Int>()
stackInts.appendItem(10)
stackInts.appendItem(20)
stackInts.appendItem(30)
let suffix = stackInts.suffix(2)
print(suffix)

// MARK: - Generic where clauses

func allItemsMatch<C1: Container, C2: Container>(_ someContainer: C1, _ anotherContainer: C2) -> Bool where C1.Item == C2.Item, C1.Item: Equatable {
    
    if someContainer.count != anotherContainer.count {
        return false
    }
    
    for i in 0..<someContainer.count {
        if someContainer[i] != anotherContainer[i] {
            return false
        }
    }
    
    return true
}

extension Array: Container {
    mutating func appendItem(_ item: Element) {
        self.append(item)
    }
}

var arrayOfStrings = ["uno", "dos", "tres"]
if allItemsMatch(stackOfStrings, arrayOfStrings) {
    print("All items match!")
} else {
    print("Not all items match!")
}

extension Stack where Element: Equatable {
    func isTop(_ item: Element) -> Bool {
            guard let topItem = items.last else {
                return false
            }
            return topItem == item
        }
}

if stackOfStrings.isTop("tres") {
    print("Top element is tres")
} else {
    print("Top element is something else")
}

extension Container where Item: Equatable {
    func startsWith(_ item: Item) -> Bool {
        return count >= 1 && self[0] == item
    }
}

if [9, 9, 42].startsWith(4) {
    print("Starts withs 42")
} else {
    print("Starts with something else")
}

extension Container where Item == Double {
    
    func average() -> Double {
        var sum = 0.0
        for index in 0..<count {
            sum += self[index]
        }
        return sum / Double(count)
    }
}

print([1260.0, 98.6, 37.0].average())
