# esolang 1, 2

the language is [Lazy K](https://esolangs.org/wiki/Lazy_K), my favorite language. are you interested in it? I made these challenges to tell you about this language.

the translator is [here](http://esoteric.sange.fi/essie2/download/lazy-k/).

## solution for 1

solutions:

-   timing attack
    -   count the number of $\beta$-reductions (or the number of executed instructions of your interpreter)

to count the beta reductions (and compile in my environment), the diff is:

```
0a1,2
> // Updated 2018 Kimiyuk Onaka
> //
34,35c36,37
< #include <stdio.h>
< #include <io.h>
---
> #include <cstdio>
> #include <unistd.h>
37,38c39,40
< #include <stdlib.h>
< #include <ctype.h>
---
> #include <cstdlib>
> #include <cctype>
40a43
> long long count_beta = 0;
59c62
< 	static void* operator new(unsigned) {
---
> 	static void* operator new(size_t) {
98a102
>             count_beta += 1;
563c567
< 				e = append_program(e, &File(stdin, "(standard input)"));
---
> 				e = append_program(e, new File(stdin, "(standard input)"));
565,567d568
< 			case 'b':
< 				setmode(fileno(stdin), O_BINARY);
< 				setmode(fileno(stdout), O_BINARY);
574c575
< 				e = append_program(e, &StringStream(argv[i]));
---
> 				e = append_program(e, new StringStream(argv[i]));
585c586
< 			e = append_program(e, &File(f, argv[i]));
---
> 			e = append_program(e, new File(f, argv[i]));
591c592,593
< 		if (ch >= 256)
---
> 		if (ch >= 256){
> fprintf(stderr, "beta reduction: %lld\n", count_beta);
592a595
>                 }
```

## solution for 2

for each sub-term, try to read it as a string. in this binary, the flag string exists directly.
