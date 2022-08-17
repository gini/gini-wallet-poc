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
                Section {
                    Button(L10n.language, action: openAppSettings)
                }
                Section(header: Text(L10n.legal), footer: Text(Bundle.main.versionNumber)) {
                    NavigationLink(L10n.termsAndConditions, destination: SafariView(url: .termsAndService))
                    NavigationLink(L10n.privacyPolicy, destination: SafariView(url: .privacyPolicy))
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle(Text(L10n.preferences), displayMode: .inline)
        }
    }

    private func openAppSettings() {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
    }
}

// MARK: - Preview

struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesPage()
    }
}
