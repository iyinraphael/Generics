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


