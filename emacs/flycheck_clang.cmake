cmake_minimum_required(VERSION 2.8)


#get a property list and convert it into a space separated
#list of quoted strings
function(get_property_string_list dir property outvarname)

  get_property(paths DIRECTORY ${dir} PROPERTY ${property})

  foreach(path ${paths})
    if(path_list)
      set(path_list "${path_list} \"${path}\"")
    else()
      set(path_list "\"${path}\"")
    endif()
  endforeach()

  set(${outvarname} ${path_list} PARENT_SCOPE)
endfunction()


# Get include directories and compiler definitions from CMake itself
# and write an Emacs file to pass these to clang when it executes
# in the background
function(write_dir_locals_el dir)
  get_property_string_list(${dir} INCLUDE_DIRECTORIES INCLUDE_PATHS)
  get_property_string_list(${dir} COMPILE_DEFINITIONS DEFINITIONS)
  set(EMACS_DIR_LOCALS ${dir}/.dir-locals.el)

  file(WRITE ${EMACS_DIR_LOCALS} ";;; Directory Local Variables
;;; See Info node `(emacs) Directory Variables' for more information.

((c++-mode
  (flycheck-clang-include-path ${INCLUDE_PATHS})
  (flycheck-clang-definitions ${DEFINITIONS})))
")
endfunction()
