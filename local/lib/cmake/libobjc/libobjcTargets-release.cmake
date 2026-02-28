#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "objc" for configuration "Release"
set_property(TARGET objc APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(objc PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libobjc.so.4.6"
  IMPORTED_SONAME_RELEASE "libobjc.so.4.6"
  )

list(APPEND _cmake_import_check_targets objc )
list(APPEND _cmake_import_check_files_for_objc "${_IMPORT_PREFIX}/lib/libobjc.so.4.6" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
