//
//  InformationView.swift
//  EOTimer
//
//  Created by Maximilian Zimmermann on 17.03.23.
//

import SwiftUI

struct InformationView: View {
    var body: some View {
        VStack {
            Spacer()
            Spacer().frame(width: UIScreen.main.bounds.width,height: 0)
            NavigationLink(destination: ImpressumView()) {
                Text("Impressum")
                    .foregroundColor(Colors.white)
            }

            Spacer().frame(height: 16)
            NavigationLink(destination: DataSecurityView()) {
                Text("Datenschutz")
                    .foregroundColor(Colors.white)
            }
            
            Spacer()
        }
        .background(Colors.darkBlue)
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView()
    }
}
