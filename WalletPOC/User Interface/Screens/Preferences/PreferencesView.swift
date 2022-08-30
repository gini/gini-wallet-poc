//
//  PreferencesPage.swift
//  skeleton
//
//  Created by Botond Magyarosi on 15/12/2020.
//

import SwiftUI

struct PreferencesPage: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text(L10n.legal)) {
                    NavigationLink(L10n.termsAndConditions, destination: SafariView(url: .termsAndService))
                    NavigationLink(L10n.privacyPolicy, destination: SafariView(url: .privacyPolicy))
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle(Text(L10n.preferences), displayMode: .inline)
        }
    }
}

struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesPage()
    }
}
