" Vim syntax file
" Language: Odin
" Maintainer: Mel Gordon
" Latest Revision: 22 Jun 2025

if exists("b:current_syntax")
    finish
endif

syn keyword Constant nil true false
syn match Constant "\s\+---"

syntax region Comment start=/\/\// end=/$/    contains=@Spell
syntax region odinBlockComment start=/\/\*/ end=/\*\// contains=@Spell,odinTodo,odinBlockComment
hi link odinBlockComment Comment

syn keyword Type int uint uintptr
syn keyword Type u8 u16 u32 u64 u128
syn keyword Type i8 i16 i32 i64 i128
syn keyword Type u8le u16le u32le u64le u128le
syn keyword Type i8le i16le i32le i64le i128le
syn keyword Type u8be u16be u32be u64be u128be
syn keyword Type i8be i16be i32be i64be i128be
syn keyword Type bool b8 b16 b32 b64

syn keyword Type f16 f32 f64
syn keyword Type f16le f32le f64le
syn keyword Type f16be f32be f64be

syn keyword Type complex32 complex64 complex128
syn keyword Type quaternion64 quaternion128 quaternion256
syn keyword Type complex quaternion matrix

syn keyword Type byte
syn keyword Type rune string cstring
syn keyword Type rawptr typeid any

syn keyword Type distinct struct union enum
syn keyword Type dynamic map bit_set bit_field

syn keyword Statement proc switch case when if else do fallthrough
syn keyword Statement break continue return in not_in for defer
syn keyword Statement or_break or_continue or_return or_else where
syn keyword Statement package foreign import using

syn keyword Keyword auto_cast cast transmute
syn keyword Keyword size_of type_of typeid_of align_of type_info_of

syn region Character start=+'+ skip=+\\\\\|\\'+ end=+\('\|$\)+
syn region String start=+`+ end=+`+
syn region String start=+"+ skip=+\\\\\|\\'+ end=+\("\|$\)+

syntax match PreProc "@" display
syntax match PreProc "\$" display

syn match PreProc "\#\w\+"
syn region PreProc start='^\#+' end='\(\s\|$\)'

" Since these are compiler defined, they will be keywords
"  But if all these words cause performance issues I will remove this
syn keyword Constant ODIN_ARCH
syn keyword Constant ODIN_ARCH_STRING
syn keyword Constant ODIN_BUILD_MODE
syn keyword Constant ODIN_BUILD_PROJECT_NAME
syn keyword Constant ODIN_COMPILE_TIMESTAMP
syn keyword Constant ODIN_DEBUG
syn keyword Constant ODIN_DEFAULT_TO_NIL_ALLOCATOR
syn keyword Constant ODIN_DEFAULT_TO_PANIC_ALLOCATOR
syn keyword Constant ODIN_DISABLE_ASSERT
syn keyword Constant ODIN_ENDIAN
syn keyword Constant ODIN_ENDIAN_STRING
syn keyword Constant ODIN_ERROR_POS_STYLE
syn keyword Constant ODIN_FOREIGN_ERROR_PROCEDURES
syn keyword Constant ODIN_MICROARCH_STRING
syn keyword Constant ODIN_MINIMUM_OS_VERSION
syn keyword Constant ODIN_NO_BOUNDS_CHECK
syn keyword Constant ODIN_NO_CRT
syn keyword Constant ODIN_NO_ENTRY_POINT
syn keyword Constant ODIN_NO_RTTI
syn keyword Constant ODIN_NO_TYPE_ASSERT
syn keyword Constant ODIN_OPTIMIZATION_MODE
syn keyword Constant ODIN_OS
syn keyword Constant ODIN_OS_STRING
syn keyword Constant ODIN_PLATFORM_SUBTARGET
syn keyword Constant ODIN_ROOT
syn keyword Constant ODIN_SANITIZER_FLAGS
syn keyword Constant ODIN_TEST
syn keyword Constant ODIN_USE_SEPARATE_MODULES
syn keyword Constant ODIN_VALGRIND_SUPPORT
syn keyword Constant ODIN_VENDOR
syn keyword Constant ODIN_VERSION
syn keyword Constant ODIN_VERSION_HASH
syn keyword Constant ODIN_WINDOWS_SUBSYSTEM
syn keyword Constant ODIN_WINDOWS_SUBSYSTEM_STRING
syn keyword Constant __ODIN_LLVM_F16_SUPPORTED

let b:current_syntax = "odin"
