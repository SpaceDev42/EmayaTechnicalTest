# EmayaApp

A sample iOS application demonstrating a clean, testable architecture using **MVVM + Coordinator** and UIKit’s **AppDelegate/SceneDelegate** for navigation handling.

---

## Architecture

### MVVM (Model–View–ViewModel)

- **Separation of Concerns**  
  - **Model**: plain data structures (your `Product`, `Rating`, etc.).  
  - **View**: SwiftUI or UIKit views responsible only for layout and simple view logic.  
  - **ViewModel**: exposes data and commands for the view, transforms and combines model data, handles business logic, and talks to services.

- **Benefits**  
  - Easier to unit‑test business logic in the ViewModel (no UI dependencies).  
  - Views remain thin and declarative.  
  - Clear data‑flow: Model → ViewModel → View.

### Coordinator

- **Responsibility**  
  - Centralize all navigation logic (push, modal, flows) in one or more **Coordinator** objects.  
  - Keeps ViewControllers / SwiftUI views unaware of other screens or navigation details.

- **Why Combine with MVVM?**  
  - ViewModels handle *what* to show; Coordinators handle *how* to navigate.  
  - No “segue spaghetti” in view controllers or view models.  
  - Flows become reusable and testable.

### UIKit `AppDelegate` + `SceneDelegate` for Navigation

Although you’re using SwiftUI for your views, we bootstrap the app in UIKit:

1. **AppDelegate**  
   - Standard entry point, handles app‑level lifecycle (e.g. push notifications, app launch).  
2. **SceneDelegate** (iOS 13+)  
   - Manages each window/scene.  
   - Creates the root `UIWindow`, wires up the **root coordinator**, and makes the window key/visible.  

**Why not SwiftUI’s new `@main` App?**  
- Using `SceneDelegate` gives you finer control over:
  - Programmatic instantiation of your **AppCoordinator**.  
  - UIKit‑based features not yet (or more verbosely) supported in SwiftUI’s `App` protocol.  
  - Easy mix‑and‑match of UIKit principals (e.g. navigation controllers) with SwiftUI views.

---

## Running the App

1. **Requirements**  
   - Xcode 14.0 or later  
   - iOS 14.0+ deployment target  

2. **Clone & Open**  
   ```bash
   git clone https://github.com/YourOrg/EmayaApp.git
   cd EmayaApp
   open EmayaApp.xcodeproj# EmayaTechnicalTest
