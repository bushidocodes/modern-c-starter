#include "vendor/unity.h"
#include "../src/acronym.h"
#include <stdlib.h>
#include <string.h>

void
setUp(void)
{
}

void
tearDown(void)
{
}

static void
test_abbreviation(char *phrase, char *expected)
{
    char *actual = abbreviate(phrase);
    TEST_ASSERT_EQUAL_STRING(expected, actual);
    free(actual);
}

static void
test_null_string(void)
{
    test_abbreviation(NULL, NULL);
}

static void
test_basic_abbreviation(void)
{
    test_abbreviation("Portable Network Graphics", "PNG");
}

static void
test_lower_case_words(void)
{
    test_abbreviation("Ruby on Rails", "ROR");
}

static void
test_punctuation(void)
{
    test_abbreviation("First In, First Out", "FIFO");
}

static void
test_non_acronym_all_caps_words(void)
{
    test_abbreviation("GNU Image Manipulation Program", "GIMP");
}

static void
test_hyphenated(void)
{
    test_abbreviation("Complementary metal-oxide semiconductor", "CMOS");
}

static void
test_all_caps_words(void)
{
    test_abbreviation("PHP: Hypertext Preprocessor", "PHP");
}

static void
test_empty_string(void)
{
    test_abbreviation("", NULL);
}

static void
test_all_words_starting_with_lowercase(void)
{
    test_abbreviation("for what it's worth", "FWIW");
}

static void
test_long_abbreviation(void)
{
    test_abbreviation("Rolling On The Floor Laughing So Hard "
                      "That My Dogs Came Over And Licked Me",
                      "ROTFLSHTMDCOALM");
}

static void
test_single_word(void)
{
    test_abbreviation("Hello", "H");
}

static void
test_hyphen_between_words(void)
{
    test_abbreviation("self-contained", "SC");
}

int
main(void)
{
    UnityBegin("test/test_acronym.c");

    RUN_TEST(test_basic_abbreviation);
    RUN_TEST(test_null_string);
    RUN_TEST(test_lower_case_words);
    RUN_TEST(test_punctuation);
    RUN_TEST(test_non_acronym_all_caps_words);
    RUN_TEST(test_hyphenated);
    RUN_TEST(test_all_caps_words);
    RUN_TEST(test_empty_string);
    RUN_TEST(test_all_words_starting_with_lowercase);
    RUN_TEST(test_long_abbreviation);
    RUN_TEST(test_single_word);
    RUN_TEST(test_hyphen_between_words);

    return UnityEnd();
}
