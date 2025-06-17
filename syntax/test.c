#include <stdlib.h>
#include <stdio.h>
#include "assert.h"

typedef struct {
    _Float32* data;
    size_t len;
    size_t cap;
} Floats;
typedef struct {
    int* data;
    size_t len;
    size_t cap;
} Numbers;

#define DA_DEFAULT_CAP (1)

#define da_append(da, element) do {                  \
    if ((da)->len + 1 >= (da)->cap) {                \
        if ((da)->cap == 0) {                        \
            (da)->cap = DA_DEFAULT_CAP;              \
            (da)->data = malloc((da)->cap);          \
        }                                            \
        while ((da)->len + 1 >= (da)->cap) {         \
            (da)->cap *= 2;                          \
        }                                            \
        (da)->data = realloc((da)->data, (da)->cap); \
        assert((da)->data && "Buy more ram lol");    \
        printf("realloc (da) to %i\n", (da)->cap);   \
    }                                                \
    (da)->data[(da)->len] = (element);               \
    (da)->len += 1;                                  \
} while (0)                                         

// This is a line-comment

/* * * * * * * * * * * *
 * This is a multiline *
 * Comment             *
 * * * * * * * * * * * */

#define da_free(da) free((da).data)

_Bool equals(const Numbers const restrict *a, const Numbers const restrict *b) {
    _Static_assert((sizeof *a) == (sizeof *b));
    if (a->len != b->len) return false;
    for (size_t i = 0; i < a->len; ++i) {
        if (a->data[i] != b->data[i]) return false;
    }
    return true
}

int main(void) {
    printf("Hello, World~! <3\n");

    Numbers nums = {0};
    da_append(&nums, 69);
    da_append(&nums, 420);
    da_append(&nums, 3);
    da_append(&nums, 5);
    da_append(&nums, 8);

    for (size_t i = 0; i < nums.len; ++i) {
        printf("nums[%d] = %d\n", i, nums.data[i]);
    }

defer:
    da_free(nums);
    return 0;
}
