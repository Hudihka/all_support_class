

import Foundation

struct  Vertex {          //Это структура для хранения положения и цвета каждой вершины

  var x, y, z: Float      // данные о положении
  var r, g, b, a: Float    // данные о цвете

  func  floatBuffer () -> [ Float ] {
    return [x, y, z, r, g, b, a]
  }

}
