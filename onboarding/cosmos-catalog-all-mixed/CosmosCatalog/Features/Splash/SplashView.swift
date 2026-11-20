import SwiftUI

struct SplashView: View {
    var onFinished: () -> Void

    @State private var glow = false
    @State private var rise = false

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.03, green: 0.04, blue: 0.07),
                    Color(red: 0.06, green: 0.08, blue: 0.12),
                    Color(red: 0.02, green: 0.03, blue: 0.05)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            Canvas { context, size in
                for i in 0..<60 {
                    let x = CGFloat((i * 47) % 97) / 97 * size.width
                    let y = CGFloat((i * 31) % 89) / 89 * size.height
                    let r = CGFloat((i % 3) + 1) * 0.55
                    context.fill(
                        Path(ellipseIn: CGRect(x: x, y: y, width: r, height: r)),
                        with: .color(.white.opacity(0.25 + Double(i % 5) * 0.08))
                    )
                }
            }
            .ignoresSafeArea()

            VStack(spacing: 28) {
                ZStack {
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [
                                    CatalogTokens.accent.opacity(glow ? 0.45 : 0.18),
                                    .clear
                                ],
                                center: .center,
                                startRadius: 8,
                                endRadius: 120
                            )
                        )
                        .frame(width: 230, height: 230)

                    Circle()
                        .stroke(
                            AngularGradient(
                                colors: [CatalogTokens.accent, CatalogTokens.cool, CatalogTokens.accent],
                                center: .center
                            ),
                            lineWidth: 2.5
                        )
                        .frame(width: 116, height: 116)
                        .rotationEffect(.degrees(glow ? 14 : -10))

                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color(red: 0.95, green: 0.82, blue: 0.55),
                                    Color(red: 0.35, green: 0.28, blue: 0.18)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 84, height: 84)
                        .shadow(color: CatalogTokens.accent.opacity(0.35), radius: 18)
                }
                .offset(y: rise ? 0 : 14)

                VStack(spacing: 8) {
                    Text("splash.brand")
                        .font(.system(size: 34, weight: .semibold, design: .rounded))
                        .foregroundStyle(CatalogTokens.textPrimary)
                    Text("A field guide to charted worlds")
                        .font(.system(size: 16, weight: .regular, design: .rounded))
                        .foregroundStyle(CatalogTokens.textSecondary)
                    Text(OutsideSwiftUIBindings.legacySplashTagline())
                        .font(.system(size: 13, weight: .medium, design: .rounded))
                        .foregroundStyle(CatalogTokens.accent)
                }
                .opacity(rise ? 1 : 0)
                .offset(y: rise ? 0 : 10)
            }
        }
        .preferredColorScheme(.dark)
        .onAppear {
            withAnimation(.easeOut(duration: 0.9)) { rise = true }
            withAnimation(.easeInOut(duration: 1.6).repeatForever(autoreverses: true)) { glow = true }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                onFinished()
            }
        }
    }
}
