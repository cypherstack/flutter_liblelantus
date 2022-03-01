cmake_minimum_required(VERSION 3.10)
set(PROJECT_NAME "flutter_liblelantus")
project(${PROJECT_NAME} LANGUAGES CXX)

# This value is used when generating builds using this plugin, so it must
# not be changed
set(PLUGIN_NAME "flutter_liblelantus_plugin")

add_library(${PLUGIN_NAME} SHARED
  "flutter_liblelantus_plugin.cc"
)
apply_standard_settings(${PLUGIN_NAME})
set_target_properties(${PLUGIN_NAME} PROPERTIES
  CXX_VISIBILITY_PRESET hidden)
target_compile_definitions(${PLUGIN_NAME} PRIVATE FLUTTER_PLUGIN_IMPL)
target_include_directories(${PLUGIN_NAME} INTERFACE
  "${CMAKE_CURRENT_SOURCE_DIR}/include")
target_link_libraries(${PLUGIN_NAME} PRIVATE flutter)
target_link_libraries(${PLUGIN_NAME} PRIVATE PkgConfig::GTK)

# List of absolute paths to libraries that should be bundled with the plugin
set(flutter_liblelantus_bundled_libraries
  ""
  PARENT_SCOPE
)

# Link bundled libraries from plugins into main executable to enable dlopen
# with only library name.
# Will NOT be needed once: https://github.com/flutter/engine/pull/28525 lands in Flutter channel we are using
foreach(plugin ${FLUTTER_PLUGIN_LIST})
  if(${plugin}_bundled_libraries)
    target_link_libraries(
      ${BINARY_NAME}
      PRIVATE
      ${${plugin}_bundled_libraries}
    )
  endif()
endforeach(plugin)
