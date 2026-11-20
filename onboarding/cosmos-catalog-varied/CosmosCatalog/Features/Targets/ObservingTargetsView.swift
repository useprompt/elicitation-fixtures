import SwiftUI

struct ObservingTargetsView: View {
    @EnvironmentObject private var store: CatalogStore
    @State private var planetName = ""
    @State private var observatory = ""
    @State private var note = ""
    @State private var savedFlash = false
    @FocusState private var focusedField: Field?

    private enum Field: Hashable {
        case planet
        case observatory
        case note
    }

    private var canSave: Bool {
        !planetName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        NavigationStack {
            ZStack {
                CatalogTokens.background.ignoresSafeArea()

                List {
                    Section {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("targets_title")
                                .font(.system(size: 28, weight: .bold, design: .rounded))
                                .foregroundStyle(CatalogTokens.textPrimary)
                            Text("targets_subtitle")
                                .font(.system(size: 15))
                                .foregroundStyle(CatalogTokens.textSecondary)
                        }
                        .listRowInsets(EdgeInsets(top: 12, leading: 4, bottom: 8, trailing: 4))
                        .listRowBackground(Color.clear)
                    }

                    Section {
                        CatalogTextField(
                            titleKey: "field_planet",
                            placeholder: "field_planet_placeholder",
                            text: $planetName
                        )
                        .focused($focusedField, equals: .planet)
                        .listRowBackground(CatalogTokens.surface)

                        CatalogTextField(
                            titleKey: "field_observatory",
                            placeholder: "field_observatory_placeholder",
                            text: $observatory
                        )
                        .focused($focusedField, equals: .observatory)
                        .listRowBackground(CatalogTokens.surface)

                        CatalogTextField(
                            titleKey: "field_note",
                            placeholder: "field_note_placeholder",
                            text: $note
                        )
                        .focused($focusedField, equals: .note)
                        .listRowBackground(CatalogTokens.surface)

                        Button {
                            save()
                        } label: {
                            Text(savedFlash ? "targets_queued" : "targets_queue_cta")
                                .font(.system(size: 16, weight: .semibold, design: .rounded))
                                .foregroundStyle(Color(red: 0.12, green: 0.09, blue: 0.05))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                                .background(CatalogTokens.accent.opacity(canSave ? 1 : 0.45))
                                .clipShape(RoundedRectangle(cornerRadius: CatalogTokens.corner, style: .continuous))
                        }
                        .buttonStyle(.plain)
                        .disabled(!canSave)
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                    }

                    Section {
                        ForEach(store.targets) { target in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(target.planetName)
                                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                                    .foregroundStyle(CatalogTokens.textPrimary)
                                if !target.note.isEmpty {
                                    Text(target.note)
                                        .font(.system(size: 13))
                                        .foregroundStyle(CatalogTokens.textSecondary)
                                }
                                if !target.observatory.isEmpty {
                                    Text(target.observatory)
                                        .font(.system(size: 12, weight: .medium, design: .monospaced))
                                        .foregroundStyle(CatalogTokens.cool)
                                }
                            }
                            .padding(.vertical, 4)
                            .listRowBackground(CatalogTokens.surface)
                        }
                    } header: {
                        Text("targets_queued_section")
                    }
                }
                .scrollContentBackground(.hidden)
                .scrollDismissesKeyboard(.interactively)
            }
            .toolbar(.hidden, for: .navigationBar)
        }
        .preferredColorScheme(.dark)
    }

    private func save() {
        let planet = planetName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !planet.isEmpty else { return }
        focusedField = nil
        store.queueTarget(
            planetName: planet,
            observatory: observatory.trimmingCharacters(in: .whitespacesAndNewlines),
            note: note.trimmingCharacters(in: .whitespacesAndNewlines)
        )
        planetName = ""
        observatory = ""
        note = ""
        savedFlash = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            savedFlash = false
        }
    }
}
