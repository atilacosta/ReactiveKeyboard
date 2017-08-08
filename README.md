# ReactiveKeyboard
UIViewController extension to monitor and update layout constraints when keyboard appears<br />

How to use:<br />
    1. Call startWatching() at viewDidLoad() or whenever<br />
    2. Call stopWatching() at deinit() or whenever after you called startWatching() <br />
    3. Declare keyboardConstraint variable and link it to your UITextField bottom layout constraint<br />
