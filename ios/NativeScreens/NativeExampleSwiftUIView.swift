import SwiftUI

/// SwiftUI full-screen presented from React Native. Dismisses via Close button or swipe-from-left gesture.
struct NativeExampleSwiftUIView: View {
  let title: String
  let onClose: () -> Void

  var body: some View {
    NavigationView {
      VStack(spacing: 32) {
        Text(title)
          .font(.title2.weight(.semibold))
          .multilineTextAlignment(.center)
          .padding(.horizontal)

        Button("Close") {
          onClose()
        }
        .font(.headline)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(Color(uiColor: .systemBackground))
      .navigationTitle(title)
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .cancellationAction) {
          Button("Close") {
            onClose()
          }
        }
      }
      .overlay(alignment: .leading) {
        Color.clear
          .frame(width: 24)
          .contentShape(Rectangle())
          .gesture(
            DragGesture(minimumDistance: 30)
              .onEnded { value in
                if value.translation.width > 80 {
                  onClose()
                }
              }
          )
      }
    }
  }
}
