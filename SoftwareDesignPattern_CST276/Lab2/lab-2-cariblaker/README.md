[![Open in Visual Studio Code](https://classroom.github.com/assets/open-in-vscode-c66648af7eb3fe8bc4f294546bfd86ef473780cde1dea487d3c4ff354943c9ae.svg)](https://classroom.github.com/online_ide?assignment_repo_id=10002762&assignment_repo_type=AssignmentRepo)
# Lab 2

This is a stub for CST276 Lab2. You will be building on top of this.

## Setup

Be sure to have CMake, a C++ compiler, and a text editor installed. Specific instructions per platform:

### Windows

Windows is the most complicated because it has to first be set up for development.

Required:
- Run "Visual Studio Installer" even if you have Visual Studio installed. Install as many C/C++ and .NET components as possible. (Click the "Modify" button and select things, then install.) I know that CMake is listed here, but we actually have to install that manually. I'm not sure why.

- Install Git for Windows (default options should be fine): https://git-scm.com/download/win

- Install CMake for Windows (x64 msi): https://cmake.org/download/

Optional but recommended:
- Install GitHub for Windows: https://desktop.github.com/

- Install VSCode (I find it easier to work with): https://code.visualstudio.com/

Now:
- Clone the Lab2 repo using VSCode or Github Desktop or via the new git-bash shell or via Powershell. Make sure to clone this somewhere you can remember. ("Clone" means download with the git info.)

- Open that Lab2 folder in VSCode and open a terminal via the top menu (Terminal -> New Terminal) if one didn't open. You could also run Powershell and navigate to the directory using `cd`.

- In that terminal, run `cmake -B build -S .`

- Then, `cmake --build build` (this runs msbuild which is what Visual Studio actually uses) or open the solution or project in Visual Studio.

For more details on those commands, see the "Running" section for Windows down below.

### Linux (or WSL2)

In this repo, run `bash setup.sh` to install all of the pre-reqs.

### macOS

Run `xcode-select --install` to be sure you have the latest command line tools.
Then, install Homebrew at https://brew.sh

After install Homebrew, run `brew install cmake` in your terminal.

## Running

### Windows

```bash
cmake -B build -S .
```

This generates the build system. If you'd like to use Visual Studio or VSCode with Visual Studio project integration, then open the build folder and double-click either the solution or the project.

If you open the full Solution, be sure to right-click on the Lab2 project in the pane and select "Set as Startup Project".

Alternatively, you can run the app from the command line (e.g. in VSCode's terminal if not using the GUI):

```bash
cmake --build build
.\build\Debug\Lab2.exe
```

This compiles the code using `msbuild`, which is what Visual Studio actually uses.

### Mac/Linux

In this directory:

```bash
cmake -B build -S .
cmake --build build
./build/Lab2
```
