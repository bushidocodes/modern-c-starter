#include <stdio.h>
#include <stdlib.h>

#include "acronym.h"

int
main()
{
	char *sample  = "Three Letter Acronym";
	char *acronym = abbreviate(sample);

	printf("%s yields %s\n", sample, acronym);

	free(acronym);

	return 0;
}