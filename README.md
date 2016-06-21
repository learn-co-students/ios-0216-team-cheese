Did You? is a mental health tracking iOS application. Every day you can enter your current mood and answer a series of questions such as, “Did you exercise today?”.  You can add a diary entry to give future perspective on the cause of those moods.  A statistics section lets you track your mood over time in relation to these factors, so that you can track the way your lifestyle affects your mental health. 

![](/ios-0216-team-cheese/mainfeelings.png?raw=true






# OH HEY! Welcome to your new project.

One of your teammates should clone this repository to their machine. Then, go through these steps:

1. Add a `.gitignore` to the cloned directory. The [Github suggested one for Objective-C](https://github.com/github/gitignore/blob/master/Objective-C.gitignore) is a good start.
2. Uncomment the `Pods/` line in the `.gitignore`. We want to ignore the Pods directory. Trust me on this.
3. Add a line that just says `Secrets.m` (or `Constants.m`, your preference) to the `.gitignore`. We want git to ignore your API keys and secrets, since this is going to be open source.
4. Make a new Xcode project in the cloned directory.
5. Run `pod init` in the directory, and add a pod (any pod) to the `Podfile`. Then run `pod install`. This will set up the workspace for the project, so everyone starts on the same foot.
6. Add `Secrets.h` and `Secrets.m` files to your project (using `File > New > Cocoa Class`).
7. In terminal, you'll probably need to do `git reset HEAD` and then `git add .`. This is just necessary when making changes to the `.gitignore`.
8. Once you've done that, run `git status` and ensure that the `Secrets.m` file and `<username>.xcuserdata` files are **not** in the list.
9. Commit! `git commit -m "Initial Commit"`
10. Push! `git push origin master`

Now your teammates can clone this repository and start branching and coding!

