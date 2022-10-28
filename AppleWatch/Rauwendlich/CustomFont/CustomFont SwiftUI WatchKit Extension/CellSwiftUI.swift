//
//  CellSwiftUI.swift
//  CustomFont SwiftUI WatchKit Extension
//
//  Created by Константин Ирошников on 17.09.2022.
//

import SwiftUI

struct CellSwiftUI: View {
    private let content: Content

    init(content: Content) {
        self.content = content
    }

    var body: some View {
        VStack {
            Text("Label")
//                .multilineTextAlignment(.center)
//                .foregroundColor(Color(selectedState?.color ?? .white))
//                .font(Font(selectedState?.font ?? UIFont.systemFont(ofSize: 20, weight: .regular)))


        }
    }
}
