#include <assert.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "acronym.h"

#define MAX_ACRONYM_LENGTH 20

char *
abbreviate(const char *phrase)
{
	if (phrase == NULL || strlen(phrase) == 0) return NULL;

	// I seem to need to copy the const string to a non-const
	char buffer[strlen(phrase) + 1];
	strcpy(buffer, phrase);

	char *result        = malloc(sizeof(char) * MAX_ACRONYM_LENGTH);
	int   result_length = 0;

	// Tokenize the phrase using ' ' and '-' as delimiters
	// and add the first letter capitalized to result
	for (char *s = buffer; (s = strtok(s, " -")) != NULL; s = NULL) {
		assert(result_length + 1 < MAX_ACRONYM_LENGTH - 1);
		result[result_length++] = toupper(*s);
	}

	// And add the terminator to prevent a buffer overrun!
	result[result_length++] = '\0';

	return result;
}