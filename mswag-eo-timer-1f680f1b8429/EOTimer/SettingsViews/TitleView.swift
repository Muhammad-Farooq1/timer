//
//  SwiftUIView.swift
//  EOTimer
//
//  Created by Maximilian Zimmermann on 21.03.23.
//

import SwiftUI

struct TitleView: View {
    var body: some View {
        HStack {
            Text(Strings.settings_title)
                .font(.title)
                .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 0))
                .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                .foregroundColor(Colors.white)
            Spacer()
            NavigationLink(destination: InformationView()) {
                Image(systemName: Strings.info_circle)
                    .font(.title2)
                    .padding(EdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 24))
            }
        }
    }
}
