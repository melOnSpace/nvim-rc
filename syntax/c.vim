" Vim syntax file
" Language: C
" Maintainer: Mel Gordon
" Latest Revision: 15 Jun 2025

if exists("b:current_syntax")
  finish
endif

syn keyword Type void bool _Bool signed unsigned
syn keyword Type char short int long
syn keyword Type uchar uchar_t ushort ushort_t uint uint_t ulong ulong_t

syn keyword Type wchar_t wint_t size_t ssize_t
syn keyword Type int8_t int_fast8_t int_least8_t uint8_t uint_fast8_t uint_least8_t
syn keyword Type int16_t int_fast16_t int_least16_t uint16_t uint_fast16_t uint_least16_t
syn keyword Type int32_t int_fast32_t int_least32_t uint32_t uint_fast32_t uint_least32_t
syn keyword Type int64_t int_fast64_t int_least64_t uint64_t uint_fast64_t uint_least64_t
syn keyword Type ptrdiff_t intptr_t intmax_t uintptr_t uintmax_t sig_atomic_t

syn keyword Type typedef struct union enum
syn keyword Type __attribute__

syn keyword Type

syn keyword Statement

alignas
alignof
auto
bool
break
case
char
const
constexpr
continue
default
do
double
else
enum
extern
false
float
for
goto
if
inline
int
long
nullptr
register
restrict
return
short
signed
sizeof
static
static_assert
struct
switch
thread_local
true
typedef
typeof
typeof_unqual
union
unsigned
void
volatile
while
_Alignas
_Alignof
_Atomic
_BitInt
_Complex
_Generic
_Imaginary
_Noreturn
_Static_assert
_Thread_local
