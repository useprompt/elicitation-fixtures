import SwiftUI

struct FieldNotesView: View {
    @EnvironmentObject private var store: CatalogStore

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("notes_title")
                            .font(.system(size: 28, weight: .bold, design: .rounded))
                            .foregroundStyle(CatalogTokens.textPrimary)
                        Text("notes_subtitle")
                            .font(.system(size: 15))
                            .foregroundStyle(CatalogTokens.textSecondary)
                    }

                    ForEach(store.notes) { note in
                        noteCard(note)
                    }
                }
                .padding(20)
            }
            .background(CatalogTokens.background.ignoresSafeArea())
            .toolbar(.hidden, for: .navigationBar)
        }
        .preferredColorScheme(.dark)
    }

    private func noteCard(_ note: FieldNote) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(note.planetName)
                    .font(.system(size: 17, weight: .semibold, design: .rounded))
                    .foregroundStyle(CatalogTokens.textPrimary)
                Spacer()
                Text(note.stamped)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(CatalogTokens.textSecondary)
            }
            Text(note.body)
                .font(.system(size: 15))
                .foregroundStyle(CatalogTokens.textSecondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(CatalogTokens.surface)
        .clipShape(RoundedRectangle(cornerRadius: CatalogTokens.corner, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: CatalogTokens.corner, style: .continuous)
                .stroke(CatalogTokens.surfaceStroke, lineWidth: 1)
        )
    }
}
