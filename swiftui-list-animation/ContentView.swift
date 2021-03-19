//
//  ContentView.swift
//  swiftui-list-animation
//
//  Created by Yurii Zadoianchuk on 25/01/2021.
//

import SwiftUI

struct ContentView: View {
    @State var items = Array(0...2)

    var body: some View {
        VStack {
            HStack {
                Button("Add row") {
                    items.append(items.count)
                }
                Button("Remove row") {
                    _ = items.removeLast()
                }
            }
            ScrollView {
                ForEach(items, id: \.self) {
                    Row(idx: $0)
                }
            }
        }.frame(minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .topLeading
        )
    }
}

struct Row: View {
    let idx: Int

    var body: some View {
        HStack {
            Spacer()
            Text(idx.description)
                .font(.largeTitle)
            Spacer()
        }
        .frame(height: 80.0)
        .background(Rectangle().foregroundColor(Color(.lightGray)))
        .clipShape(RoundedRectangle(cornerRadius: 10.0))
        .shadow(color: .white, radius: 5)
        .padding([.leading, .trailing, .top])
//        .opacity(opacity)
//        .rotationEffect(.degrees(rotation), anchor: .bottomTrailing)
//        .offset(x: offsetX)
        .transition(.asymmetric(insertion: .fanInsert, removal: .fanRemove))
//        .onAppear(perform: {
//            withAnimation {
//                self.opacity = 1.0
//                self.rotation = 0.0
//                self.offsetX = 0.0
//            }
//        }).onDisappear(perform: {
//            withAnimation {
//                self.opacity = 0.0
//                self.rotation = 180.0
//            }
//        })
//        })
    }
}

extension AnyTransition {
    static var fanInsert: AnyTransition {
        AnyTransition.modifier(
            active: FanAnimationModifier(
                opacity: 0.0,
                degrees: -90.0,
                anchor: .topTrailing
            ), identity: FanAnimationModifier(
                opacity: 1.0,
                degrees: 0.0,
                anchor: .topTrailing)
        ).animation(.easeOut(duration: 1.0))
    }

    static var fanRemove: AnyTransition {
        AnyTransition.modifier(
            active: FanAnimationModifier(
                opacity: 0.0,
                degrees: 90.0,
                anchor: .topLeading
            ), identity: FanAnimationModifier(
                opacity: 1.0,
                degrees: 0.0,
                anchor: .topLeading)
        ).animation(.easeOut(duration: 1.0))
    }
}

struct FanAnimationModifier: ViewModifier {
    let opacity: Double
    let degrees: Double
    let anchor: UnitPoint

    func body(content: Content) -> some View {
        content
            .opacity(opacity)
            .rotationEffect(.degrees(degrees), anchor: anchor)
    }
}

//struct OpacityModifier: ViewModifier {
//    let opacity: Double
//
//    func body(content: Content) -> some View {
//        content.opacity(opacity)
//    }
//}
//
//struct FanRotationModifier: ViewModifier {
//    let degrees: Double
//    let anchor: UnitPoint
//
//    func body(content: Content) -> some View {
//        content.rotationEffect(.degrees(degrees), anchor: anchor)
//    }
//}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
