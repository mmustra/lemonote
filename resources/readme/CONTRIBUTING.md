[:arrow_backward: Development](https://github.com/mmustra/lemonote#development)

## Contributing

#### Requirements

This project was created with [AutoHotkey](https://www.autohotkey.com) v1.1.32.00 and with [Inno Setup](http://www.jrsoftware.org/isinfo.php) v6.0.4. Tests are done within [VirtualBox](https://www.virtualbox.org) v6.1.

To prepare a dev environment you need to:

1. Install AutoHotkey and Inno Setup.
2. Set paths for user environment variables.
   > C:\Users\\[user]\AppData\Local\Programs\Inno Setup 6  
   > C:\Program Files\AutoHotkey\Compiler
3. Install VirtualBox and add Windows 7 or 10 image, depending which Windows version you need.

#### IDE

It's recommended to use [Visual Studio Code](https://code.visualstudio.com/) due to formating requirement ([AutoHotKey SlimCode](https://github.com/rafaelcavasani/vscode-autohotkey-plus-vscode)).

#### Development

Run `dev.ahk`. This will show the AutoHotkey tray icon. When you're done with the code changes and want to see it in action, double click or right-click on the icon to reload the application.

#### Build

Run `build-all.ahk`, `build-installer.ahk` or `build-portable.ahk` to compile application and/or create installation. All built files can be found in `./dist` folder. In case of an error check for the log files which are created in the root folder on each build.

#### Testing

Lemonote strives to support Windows 7+ and MS Office 2007+. Due to differences in MS COM API, testing on Windows 7,10 with both MS Office 2007,2016 is mandatory. Use VirtualBox if you need an additional system version.

#### Code Style

Be sure to follow the current folder structure and code style in the project. Before adding new packages to the project be sure to first check `./app/_libs` and `./app/_common/services` for possible duplicates. Format your code with addon ([AutoHotKey SlimCode](https://github.com/rafaelcavasani/vscode-autohotkey-plus-vscode)).

There are some quirks with format addon you need to be aware of:

- Adds spaces inside curly brackets for strings, can cause issues with regex pattern.
- Wrong spacing for stacked goto labels.
- Switch/Case statement requires brackets for correct formatting.
- Splits variable "index" to "in dex" if used in For loop.

#### How to contribute

Thank you for contributing, please follow these guidelines:

1. Report issue through Github.
2. Fork repo, make a new branch, develop, test and format your code.
3. Submit PR with a clear description of changes.
