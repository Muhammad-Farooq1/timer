//
//  DataSecurityView.swift
//  EOTimer
//
//  Created by Maximilian Zimmermann on 17.03.23.
//

import SwiftUI

struct DataSecurityView: View {
    var body: some View {
        ScrollView([.vertical]) {
            VStack {
                Text("Datenschutz")
                    .font(.title)
                    .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 0))
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                    .foregroundColor(Colors.white)
                Spacer()
                Spacer().frame(width: UIScreen.main.bounds.width,height: 0)
                Text(Strings.data_safety)
                    .foregroundColor(Colors.white)
                Spacer()
            }
        }
        .background(Colors.darkBlue)

    }
}

struct DataSecurityView_Previews: PreviewProvider {
    static var previews: some View {
        DataSecurityView()
    }
}
