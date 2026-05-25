#include <ctype.h>
#include <stdlib.h>

#include "acronym.h"

constexpr int MAX_ACRONYM_LENGTH = 64;

[[nodiscard("result is heap-allocated and must be freed")]]
char *
abbreviate(const char *phrase)
{
    if (phrase == nullptr || phrase[0] == '\0')
        return nullptr;

    char *result = malloc(MAX_ACRONYM_LENGTH);
    if (result == nullptr)
        return nullptr;

    int  len      = 0;
    bool new_word = true;

    for (const char *p = phrase; *p != '\0' && len < MAX_ACRONYM_LENGTH - 1; p++) {
        if (*p == ' ' || *p == '-') {
            new_word = true;
        } else if (new_word) {
            result[len++] = (char)toupper((unsigned char)*p);
            new_word      = false;
        }
    }
    result[len] = '\0';

    return result;
}
