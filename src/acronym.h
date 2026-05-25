#ifndef ACRONYM_H
#define ACRONYM_H

[[nodiscard("result is heap-allocated and must be freed")]]
char *abbreviate(const char *phrase);

#endif
