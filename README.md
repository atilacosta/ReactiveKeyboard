# ReactiveKeyboard
UIViewController extension to monitor and update layout constraints when keyboard appears

How to use:
    1. Call startWatching() at viewDidLoad() or whenever
    2. Call stopWatching() at deinit() or whenever after you called startWatching()
    3. Declare keyboardConstraint variable and link it to your UITextField bottom layout constraint
