CMake support for Emacs
=======================

This is a module to use CMake's knowledge of the build system to integrate with development within Emacs.
Calling the function `write_dir_locals_el` will write out a file called `.dir-locals.el` in that
directory setting variables for Emacs to use. This allows:

1. Flycheck to work correctly with clang
2. Autocomplete to work correctly with clang

Basically it sets the flags needed to run clang in the background. Autocompletion sets
`ac-clang-flags` and adds `ac-clang-flags-c` and `ac-clang-flags-c++`, two variables to be
set in the user's `init.el` file accordingly. Be sure to set include paths for
system headers or autocompletion will not work. As an example, this is what I
have in my `init.el` file:

    (setq ac-clang-flags-c++ '("-std=c++11"
                               "-I/usr/include/c++/4.9.0"
                               "-I/usr/include/c++/4.9.0/x86_64-unknown-linux-gnu"
                               "-I/usr/include"))
    (setq ac-clang-flags-c '("-I/usr/include"))

If everything is set up correctly, all calls to clang for both flycheck and autocomplete-clang will
be made with the right flags.
