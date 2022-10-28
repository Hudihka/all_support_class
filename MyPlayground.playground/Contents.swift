import UIKit

class Point {
	var x: Int
	init(_ x: Int) {
		self.x = x
	}
}

var p = Point(0)
weak var wp = p
p = Point(10)
print(wp?.x)
