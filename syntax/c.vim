" Vim syntax file
" Language: C
" Maintainer: Mel Gordon
" Latest Revision: 22 Jun 2025

if exists("b:current_syntax")
    finish
endif

syn keyword Constant nullptr true false NULL

syn keyword Type void bool _Bool nullptr_t
syn keyword Type char short int long
syn keyword Type uchar uchar_t ushort ushort_t uint uint_t ulong ulong_t

syn keyword Type wchar_t wint_t size_t ssize_t
syn keyword Type int8_t int_fast8_t int_least8_t uint8_t uint_fast8_t uint_least8_t
syn keyword Type int16_t int_fast16_t int_least16_t uint16_t uint_fast16_t uint_least16_t
syn keyword Type int32_t int_fast32_t int_least32_t uint32_t uint_fast32_t uint_least32_t
syn keyword Type int64_t int_fast64_t int_least64_t uint64_t uint_fast64_t uint_least64_t
syn keyword Type ptrdiff_t intptr_t intmax_t uintptr_t uintmax_t sig_atomic_t
syn keyword Type u8 u16 u32 u64 i8 i16 i32 i64

syn keyword Type float double
syn keyword Type _Float16 _Float32 _Float64 _Float128
syn keyword Type _Decimal32 _Decimal64 _Decimal128
syn keyword Type _BitInt _Complex _Generic _Imaginary

syn keyword Type typedef struct union enum
syn keyword Type __attribute__

syn keyword Type signed unsigned auto const constexpr
syn keyword Type extern static inline register restrict
syn keyword Type thread_local _Thread_local
syn keyword Type volatile _Atomic _Noreturn

" Thank you microsoft, very cool /s
" MAYBE I will add simple windows.h types like BOOL
syn keyword Type _restrict __restrict
syn keyword Type __based __cdecl __declspec
syn keyword Type __fastcall __stdcall __w64
syn keyword Type __unaligned __vectorcall

syn keyword Statement switch case default
syn keyword Statement if else
syn keyword Statement for do while break continue
syn keyword Statement goto return

" labels
" syn match Special '^\s*\w\+:\s*$'

syn keyword Keyword sizeof typedef typeof typeof_unqual
syn keyword Keyword _Alignas alignas 
syn keyword Keyword _Alignof alignof 
syn keyword Keyword static_assert _Static_assert

syn region Comment start=+\/\/+ end=+$+ contains=@Spell
syn region Comment start=+\/\*+ end=+\*\/+ contains=@Spell

syn region String    start=+\%(u8\|u\|U\|L\)\="+ skip=+\\\\\|\\"+ end=+"+
syn region Character start=+\%(u8\|u\|U\|L\)\='+ skip=+\\\\\|\\'+ end=+'+

syn region Macro start=+#+ end='\a\+\s*'
"syn match Macro '^\s*#\s*define'
"syn match Macro '^\s*#\s*undef'
"syn match Macro '^\s*#\s*if'
"syn match Macro '^\s*#\s*ifdef'
"syn match Macro '^\s*#\s*ifndef'
"syn match Macro '^\s*#\s*pragma'
"syn match Macro '^\s*#\s*pragma\s*once'
"syn match Macro '^\s*#\s*else'
"syn match Macro '^\s*#\s*elif'
"syn match Macro '^\s*#\s*elifdef'
"syn match Macro '^\s*#\s*elifndef'
"syn match Macro '^\s*#\s*endif'
"syn match Macro '^\s*#\s*error'

syn region preProcString display contained start=+"+ skip=+\\\\\|\\"+ end=+"+
syn match preProcString display contained "<[^>]*>"
syn match preProcInclude display "^\s*\zs\%(%:\|#\)\s*include\>\s*["<]" contains=preProcString

hi link preProcString  String
hi link preProcInclude PreProc

let b:current_syntax = "c"

