setlocal enabledelayedexpansion


set SW_LLVM_OPTIONS=-DLLVM_DEFAULT_TARGET_TRIPLE=x86_64-unknown-windows-msvc
set SW_EXTERNAL_SOURCES_OPTIONS=-D LLVM_EXTERNAL_SWIFT_SOURCE_DIR="%SW_SWIFT_SOURCES_DIR%" -D LLVM_EXTERNAL_CMARK_SOURCE_DIR="%SW_CMARK_SOURCES_DIR%"


if defined GITHUB_ACTIONS (
  set SW_PYTHON_OPTIONS=-D PYTHON_EXECUTABLE=%pythonLocation%\python.exe
)

cmake^
 -G Ninja^
 -S %SW_LLVM_SOURCES_DIR%^
 -B %SW_TOOLCHAIN_BUILD_DIR%^
 -C %SW_WORKSPACE%\cmake\caches\toolchain-%SW_SWIFT_BRANCH_SPEC%.cmake^
 -C %SW_WORKSPACE%\cmake\caches\windows-x86_64.cmake^
 -C %SW_WORKSPACE%\cmake\caches\org.lxbndr.dt.cmake^
 -D CMAKE_BUILD_TYPE=Release^
 -D CMAKE_INSTALL_PREFIX=%SW_TOOLCHAIN_INSTALL_DIR%^
 -D LLVM_DEFAULT_TARGET_TRIPLE=x86_64-unknown-windows-msvc^
 -D LLVM_USE_HOST_TOOLS=NO^
 -D LLVM_TABLEGEN=%SW_LLVM_TABLEGEN%^
 -D CLANG_TABLEGEN=%SW_CLANG_TABLEGEN%^
 -D LLDB_TABLEGEN=%SW_LLDB_TABLEGEN%^
 -D SWIFT_PATH_TO_LIBDISPATCH_SOURCE=%SW_DISPATCH_SOURCES_DIR%^
 -D LLVM_ENABLE_LIBEDIT=NO^
 -D LLVM_PARALLEL_LINK_JOBS=2^
 -D SWIFT_WINDOWS_x86_64_ICU_UC_INCLUDE=%SW_ICU_PATH%\usr\include\unicode^
 -D SWIFT_WINDOWS_x86_64_ICU_UC=%SW_ICU_PATH%\usr\lib\icuuc%SW_ICU_VERSION%.lib^
 -D SWIFT_WINDOWS_x86_64_ICU_I18N_INCLUDE=%SW_ICU_PATH%\usr\include^
 -D SWIFT_WINDOWS_x86_64_ICU_I18N=%SW_ICU_PATH%\usr\lib\icuin%SW_ICU_VERSION%.lib^
 -D SWIFT_PARALLEL_LINK_JOBS=2^
 -D SWIFT_BUILD_DYNAMIC_STDLIB=YES^
 -D SWIFT_BUILD_DYNAMIC_SDK_OVERLAY=YES^
 %SW_PYTHON_OPTIONS%^
 %SW_LLDB_OPTIONS%^
 %SW_LLVM_OPTIONS%^
 %SW_EXTERNAL_SOURCES_OPTIONS%

endlocal