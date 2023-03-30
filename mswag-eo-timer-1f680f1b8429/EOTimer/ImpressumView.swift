//
//  ImpressumView.swift
//  EOTimer
//
//  Created by Maximilian Zimmermann on 17.03.23.
//

import SwiftUI

struct ImpressumView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Impressum")
                .font(Font.title)
                .foregroundColor(Colors.white)
            Spacer()
            Spacer().frame(width: UIScreen.main.bounds.width,height: 0)
            Text(Strings.impressum)
                .foregroundColor(Colors.white)
            Spacer()
        }
        .background(Colors.darkBlue)

    }
}

struct ImpressumView_Previews: PreviewProvider {
    static var previews: some View {
        ImpressumView()
    }
}
