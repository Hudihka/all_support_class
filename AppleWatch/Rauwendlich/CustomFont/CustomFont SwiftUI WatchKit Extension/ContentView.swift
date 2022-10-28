//
//  ContentView.swift
//  CustomFont SwiftUI WatchKit Extension
//
//  Created by Константин Ирошников on 17.09.2022.
//

import SwiftUI

struct ContentView: View {
    @State var selectedState: Content?

    var body: some View {
        VStack {
            Text(selectedState?.text ?? "Label")
                .multilineTextAlignment(.center)
                .foregroundColor(Color(selectedState?.color ?? .white))
                .font(Font(selectedState?.font ?? UIFont.systemFont(ofSize: 20, weight: .regular)))
            
                
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
