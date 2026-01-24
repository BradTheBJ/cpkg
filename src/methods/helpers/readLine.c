#include <stdio.h>
#include <stdlib.h>

char* readLine() {
    char *input = malloc(1024);
    if (!input) return NULL;
    scanf("%1024s", input);
    return input;
}

