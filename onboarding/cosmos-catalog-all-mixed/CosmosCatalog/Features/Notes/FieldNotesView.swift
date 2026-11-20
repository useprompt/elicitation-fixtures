import SwiftUI

struct FieldNotesView: View {
    @EnvironmentObject private var store: CatalogStore

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Field notes")
                            .font(.system(size: 28, weight: .bold, design: .rounded))
                            .foregroundStyle(Color(red: 0.12, green: 0.11, blue: 0.10))
                        Text("Quick observations while you chart nearby systems.")
                            .font(.system(size: 15))
                            .foregroundStyle(Color(red: 0.40, green: 0.38, blue: 0.35))
                    }

                    ForEach(store.notes) { note in
                        noteCard(note)
                    }
                }
                .padding(20)
            }
            .background(
                LinearGradient(
                    colors: [
                        Color(red: 0.97, green: 0.95, blue: 0.91),
                        Color(red: 0.94, green: 0.92, blue: 0.88)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            )
            .navigationTitle("Field notes")
            .navigationBarTitleDisplayMode(.inline)
        }
        .preferredColorScheme(.light)
    }

    private func noteCard(_ note: FieldNote) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(note.planetName)
                    .font(.system(size: 17, weight: .semibold, design: .rounded))
                    .foregroundStyle(Color(red: 0.14, green: 0.12, blue: 0.10))
                Spacer()
                Text(note.stamped)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(Color(red: 0.50, green: 0.47, blue: 0.43))
            }
            Text(note.body)
                .font(.system(size: 15))
                .foregroundStyle(Color(red: 0.28, green: 0.26, blue: 0.23))
                .fixedSize(horizontal: false, vertical: true)
            Text(verbatim: note.id)
                .font(.system(size: 11, weight: .medium, design: .monospaced))
                .foregroundStyle(Color(red: 0.58, green: 0.54, blue: 0.48))
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white.opacity(0.92))
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .shadow(color: .black.opacity(0.05), radius: 12, y: 5)
    }
}
