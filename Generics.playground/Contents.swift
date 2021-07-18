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
