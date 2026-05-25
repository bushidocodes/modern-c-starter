#include <stdio.h>
#include <stdlib.h>

#include "acronym.h"

int main(void)
{
    const char *sample  = "Three Letter Acronym";
    char       *acronym = abbreviate(sample);

    if (acronym == nullptr) {
        fprintf(stderr, "abbreviate() returned null\n");
        return 1;
    }

    printf("%s yields %s\n", sample, acronym);
    free(acronym);
    return 0;
}
