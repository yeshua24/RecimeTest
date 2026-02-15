# 🍳 Recipes App (SwiftUI)

A native iOS application built using **Swift + SwiftUI** that allows users to browse and search a collection of cooking recipes with advanced filtering capabilities.

The project is intentionally structured to resemble a **real production app**, while currently loading data from a local JSON file *(mock backend)*.

---
## ✨ App Preview
To better demonstrate the loading states, the app was tested under a **slow network condition** to showcase the shimmering placeholders while images are loading.
🔗 Preview Link: https://drive.google.com/file/d/1fjYsTY1cJjcZFiTrWnxsrC7Wgwsx_ehR/view?usp=sharing

## ✨ Features

- Grid browsing of recipes
- Stretchable hero image in detail screen
- **Full-text search** (title + description + instructions)
- **Debounced search (~350ms)**
- Filter by:
  - Vegetarian
  - Servings
  - Prep time
  - Included ingredients
  - Excluded ingredients
- Ingredient selection sheet *(tap to include, long press to exclude)*
- Image caching (**memory + disk**)
- Shimmer loading placeholders
- Smooth animations & transitions

---

## 🛠 Setup Instructions

### Requirements
- Xcode 16+
- iOS 17+
- Swift 5.9+

### Steps

1. Clone the repository
2. Open `RecimeTest.xcodeproj`
3. Build & run on Simulator or device

> No API keys or external dependencies required.

---

## 🏗 High-Level Architecture

The project follows a lightweight **Layered Architecture (MVVM + Service)**.
```
Presentation Layer
│
├─ Views (SwiftUI)
├─ ViewModels (State + UI logic)
│
Domain Layer
│
├─ Models (Recipe, SearchQuery)
│
Data Layer
│
├─ Service (RecipeService)
├─ Local JSON Loader (Mock backend)
├─ Image Downloader + Cache
│
```
### Data Flow
View
→ ViewModel
→ Service
→ Local JSON (mock API)
→ Filtered Results
→ UI

The service behaves like a real backend:

- Loads data once
- Queries in-memory dataset
- Avoids re-decoding JSON per search

---

## 🧠 Key Design Decisions

### 1. Local JSON behaves as a database (not a network request)
Instead of decoding JSON every search, the app loads once and filters in memory.  
This mimics real backend behavior and improves performance.

---

### 2. Custom Image Loader
A custom `CachedAsyncImage` supports:

- Memory cache
- Disk cache
- Request deduplication *(actor-based)*
- Shimmer loading
- Failure UI

This avoids third-party dependencies while simulating production behavior.

---

### 3. Ingredient Selection UX

| Gesture | Result |
|------|------|
| Tap | Include ingredient |
| Long press | Exclude ingredient |

Chosen to minimize UI complexity and match mobile ergonomics.

---

### 4. Debounced Searching
Search input is debounced (~350ms) to prevent excessive filtering and mimic real-world search behavior found in production apps.

---

### 5. Simple MVVM
ViewModels only manage:

- Screen state
- Filter state
- UI actions

Business logic lives in the Service.

> No excessive protocols or coordinators were added intentionally.

---

## ⚠️ Known Limitations

- No pagination
- No offline persistence for recipes *(only images cached)*
- Filtering done locally *(not scalable for large datasets)*
- Search runs after debounce *(no server throttling)*
- No unit/UI tests included *(architecture supports it)*

---

## 🚀 Future Improvements

- Remote API integration
- Pagination support
- Unit tests for ViewModels
- Prefetch image loading

---

## 📌 Summary

This project demonstrates:

- **Clean SwiftUI architecture**
- **State management**
- **Custom caching**
- **UI composition**
- **Thoughtful UX interactions**

While keeping implementation intentionally simple and readable.
