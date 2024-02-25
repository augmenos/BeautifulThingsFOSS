//
//  View+WindowGeometryPreferences.swift
//
//  Created by Drew Olbrich on 1/30/24 with permission to use.
//  https://gist.github.com/drewolbrich/03460fc1bb71b9a821fff722f17ec977
//

// This visionOS SwiftUI view modifier can be used to hide a window's resize
// handles or to constrain a window's aspect ratio. See the documentation comments
// below.

#if os(visionOS)

import SwiftUI

extension View {
    
    // The following code declares the `windowGeometryPreferences` view modifier twice,
    // with and without the `resizingRestrictions` parameter, to work around the Swift
    // compiler warning that would otherwise result from the fact that
    // `resizingRestrictions` should be optional to make `windowGeometryPreferences`
    // match the signature of `UIWindowScene/GeometryPreferences/Vision/init`, while at
    // the same time one of the `UIWindowScene/ResizingRestrictions` enum cases is
    // named `none`, which would create an ambiguity with respect to the `none` case of
    // the `resizingRestrictions` parameter's optional type.
    
    /// Sets the geometry preferences for this view's window scene.
    ///
    /// This view modifier may be used to make a view's window fully non-resizable,
    /// permanently hiding the view's resize handle, which isn't the case if the view's
    /// size is constrained with `View/frame`. Furthermore, the window will not stretch
    /// and snap back. The use of this view modifier in this way matches the behavior of
    /// the visionOS 1.0 Settings app, for example.
    ///
    /// This view modifier may also be used to constrain the aspect ratio of view's
    /// window.
    ///
    /// If you copy the user of `UIWindowScene/requestGeometryUpdate` from Apple's Happy
    /// Beam sample app, you may find that your code won't necessarily work as expected
    /// if your app has multiple windows. That's because the Happy Beam code always
    /// affects the first window group that it finds in the application, which may not
    /// be the one you want. In contrast, this view modifier is guaranteed to affect the
    /// window group corresponding to the view you use it on.
    ///
    /// ## Example Usage
    ///
    /// ```
    /// WindowGroup {
    ///     MyView()
    ///         // Do not display the window's resize handle.
    ///         .windowGeometryPreferences(resizingRestrictions: .none)
    /// }
    /// .defaultSize(width: 600, height: 400)
    ///
    /// WindowGroup {
    ///     MyView()
    ///         // Constrain the window's aspect ratio and specify a minimum allowed size.
    ///         .windowGeometryPreferences(minimumSize: CGSize(width: 800, height: 450),
    ///             resizingRestrictions: .uniform)
    /// }
    /// .defaultSize(width: 1600, height: 900)
    /// ```
    ///
    /// This view modifier was written for visionOS 1.0 and may not necessarily work as
    /// expected in future visionOS releases.
    ///
    /// - Parameters:
    ///   - size: The requested size of the window. **Important:** To avoid unwanted
    ///   window size animation when a window is first presented, the
    ///   `WindowGroup/defaultSize` scene modifier should be used to set the window's
    ///   initial size instead of this parameter.
    ///   - minimumSize: The requested minimum allowed size of the window.
    ///   - maximumSize: The requested maximum allowed size of the window.
    ///   - resizingRestrictions: A constraint on the window's size. The supported values are:
    ///       - `freeform` - The window may be freely resized by the user.
    ///       - `none` - The user cannot resize the window. The window's resize handle
    ///       will not appear in the corners of the window.
    ///       - `uniform` - The user may resize the window, but the window's aspect ratio will
    ///       be constrained to match that of its initial size.
    /// - Returns: A view whose window scene has the requested geometry preferences.
    func windowGeometryPreferences(size: CGSize? = nil, minimumSize: CGSize? = nil, maximumSize: CGSize? = nil, resizingRestrictions: UIWindowScene.ResizingRestrictions) -> some View {
        let geometryPreferences = UIWindowScene.GeometryPreferences.Vision(size: size, minimumSize: minimumSize, maximumSize: maximumSize, resizingRestrictions: resizingRestrictions)
        return modifier(WindowGeometryPreferencesViewModifier(geometryPreferences: geometryPreferences))
    }

    /// Sets the geometry preferences for this view's window scene.
    ///
    /// This view modifier may be used to make a view's window fully non-resizable,
    /// permanently hiding the view's resize handle, which isn't the case if the view's
    /// size is constrained with `View/frame`. Furthermore, the window will not stretch
    /// and snap back. The use of this view modifier in this way matches the behavior of
    /// the visionOS 1.0 Settings app, for example.
    ///
    /// This view modifier may also be used to constrain the aspect ratio of view's
    /// window.
    ///
    /// If you copy the user of `UIWindowScene/requestGeometryUpdate` from Apple's Happy
    /// Beam sample app, you may find that your code won't necessarily work as expected
    /// if your app has multiple windows. That's because the Happy Beam code always
    /// affects the first window group that it finds in the application, which may not
    /// be the one you want. In contrast, this view modifier is guaranteed to affect the
    /// window group corresponding to the view you use it on.
    ///
    /// ## Example Usage
    ///
    /// ```
    /// WindowGroup {
    ///     MyView()
    ///         // Do not display the window's resize handle.
    ///         .windowGeometryPreferences(resizingRestrictions: .none)
    /// }
    /// .defaultSize(width: 600, height: 400)
    ///
    /// WindowGroup {
    ///     MyView()
    ///         // Constrain the window's aspect ratio and specify a minimum allowed size.
    ///         .windowGeometryPreferences(minimumSize: CGSize(width: 800, height: 450),
    ///             resizingRestrictions: .uniform)
    /// }
    /// .defaultSize(width: 1600, height: 900)
    /// ```
    ///
    /// This view modifier was written for visionOS 1.0 and may not necessarily work as
    /// expected in future visionOS releases.
    ///
    /// - Parameters:
    ///   - size: The requested size of the window. **Important:** To avoid unwanted
    ///   window size animation when a window is first presented, the
    ///   `WindowGroup/defaultSize` scene modifier should be used to set the window's
    ///   initial size instead of this parameter.
    ///   - minimumSize: The requested minimum allowed size of the window.
    ///   - maximumSize: The requested maximum allowed size of the window.
    ///   - resizingRestrictions: A constraint on the window's size. The supported values are:
    ///       - `freeform` - The window may be freely resized by the user.
    ///       - `none` - The user cannot resize the window. The window's resize handle
    ///       will not appear in the corners of the window.
    ///       - `uniform` - The user may resize the window, but the window's aspect ratio will
    ///       be constrained to match that of its initial size.
    /// - Returns: A view whose window scene has the requested geometry preferences.
    func windowGeometryPreferences(size: CGSize? = nil, minimumSize: CGSize? = nil, maximumSize: CGSize? = nil) -> some View {
        let geometryPreferences = UIWindowScene.GeometryPreferences.Vision(size: size, minimumSize: minimumSize, maximumSize: maximumSize, resizingRestrictions: nil)
        return modifier(WindowGeometryPreferencesViewModifier(geometryPreferences: geometryPreferences))
    }

}

private struct WindowGeometryPreferencesViewModifier: ViewModifier {
    
    let geometryPreferences: UIWindowScene.GeometryPreferences.Vision
    
    func body(content: Content) -> some View {
        WindowGeometryPreferencesView(geometryPreferences: geometryPreferences, content: {
            content
        })
    }
    
}

private struct WindowGeometryPreferencesView<Content>: UIViewControllerRepresentable where Content: View {
    
    let geometryPreferences: UIWindowScene.GeometryPreferences.Vision

    let content: () -> Content
    
    func makeUIViewController(context: Context) -> WindowGeometryPreferencesUIViewController<Content> {
        WindowGeometryPreferencesUIViewController(geometryPreferences: geometryPreferences, content: content)
    }
    
    func updateUIViewController(_ uiViewController: WindowGeometryPreferencesUIViewController<Content>, context: Context) {
        // Do nothing.
    }
    
}

private class WindowGeometryPreferencesUIViewController<Content>: UIViewController where Content: View {
    
    let geometryPreferences: UIWindowScene.GeometryPreferences.Vision

    private let hostingController: UIHostingController<Content>
    
    init(geometryPreferences: UIWindowScene.GeometryPreferences.Vision, content: @escaping () -> Content) {
        self.geometryPreferences = geometryPreferences
        self.hostingController = UIHostingController(rootView: content())
        
        super.init(nibName: nil, bundle: nil)
        
        addChild(hostingController)
        hostingController.view.frame = view.bounds
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
        
        hostingController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = WindowGeometryPreferencesUIView(geometryPreferences: geometryPreferences)
    }
    
}

private class WindowGeometryPreferencesUIView: UIView {
    
    private let geometryPreferences: UIWindowScene.GeometryPreferences.Vision

    init(geometryPreferences: UIWindowScene.GeometryPreferences.Vision) {
        self.geometryPreferences = geometryPreferences
        
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToWindow() {
        // Allegedly, in visionOS 1.0 there is a short period of time while the scene
        // connects during which geometry preferences requests may not be honored. The
        // recommended workaround is to wait for one run loop spin.
        RunLoop.main.perform {
            self.window?.windowScene?.requestGeometryUpdate(self.geometryPreferences)
        }
    }
    
}

#endif // os(visionOS)
