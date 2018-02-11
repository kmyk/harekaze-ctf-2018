# Harekaze CTF 2018: esolang 1, 2

## description of 1

*(a youtube video is embeded here, but it didn't work due to the scoreserver)*

-   [problem-1.lazy]()

(Rev + Misc, 200 points)

## description of 2

-   en: <https://www.amazon.com/dp/0192801422/>
-   ja: <https://www.amazon.co.jp/dp/4627019017/>

-   [problem-2.lazy]()

(Rev + Misc, 250 points)

## note

the language is [Lazy K](https://esolangs.org/wiki/Lazy_K), my favorite language. are you interested in it? I made these challenges to tell you about this language.

the translator is [here](http://esoteric.sange.fi/essie2/download/lazy-k/).

## solution for 1

the solution is timing attack.
count the number of $\beta$-reductions (or the number of executed instructions of your interpreter).
you can find this solution if you notice that the execution time is very long and varies depending on inputs.

to count the beta reductions (and compile in my environment), the diff for an [interpreter](http://esoteric.sange.fi/essie2/download/lazy-k/lazy.cpp) is:

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

for each sub-term, try to read it as a string.
there is the flag string directly in the binary.

the length of flag is longer than previous one (you can know this with same method for problem 1) while the length of code (6500 byte) is shorter.
the flag string becomes almost 4000 byte if simply constructed, and it is difficult to compress more than this (it is possible if the flag is like `HarekazeCTF{AAAAAAAA...AAA}`, but you can reject this since the length of flag seems to be one of `HarekazeCTF{SHA1(X)}`).
so you can guess the flag is embeded directly in the code.

the annotated code:

```
``s``s``s`k``s`k`s`k`s`k``si`k`ki``s``s`ks``s`kk``s`ks``s``s`ks```ss`si`kk`k``s`k`s``si`kk``s`kk``s`k`s``si`kik``s`k`s`kk``s``s`ks``s``s`ks``s`kk``si`k`ki`k``s`k`s``si`kk``s`kk``s`k`s``si`kik`k`k``s``si`ki`k`k```sii```sii``s``s`kski````sii``s`k``s`k`s``s``si`k`k`k`ki`k`k``s``si`k`ki`k`ki``s`k`s``s`k``s``s`ks``s`kk``s`ks``s``s`ks``s``s`ks``s`k`s`k``si`kk``s`k`s``s``si`kk`k``si`k`ki``s`kk``s``si`k``s`k`s``si`k`kik`k``s``si`kk`k```sii``s`k``s`k`s``si`k`kik``sii`k`k``s``s`ks``s`k`si```ss`si`kk``s`kk``s`k`s``s`ksk``si`k`ki`k`k``s``s`ks``s`k`si``s`kk``s`k`s``s`ksk``si`kk``s`kk``si`k`ki`k``s``s`ksk`k``si`k`ki``si`kk``s``s`ksk`k``si`k`ki``sii  # the main
``s``si`k``s`k```sii``s``s`kski``s``s`ksk``s``s`ksk```s``siii``s``s`kski`k``s``si`k`````s``siii``s``s`kski`s``s`ksk```s``sii`s``s`ksk``s``s`kski`k``s``si`k``s`k``s``s`kski``s``s`ksk``s`k``s``s`kski``s``s`ksk```sii``s``s`ksk``s``s`kski`k``s``si`k``s``s`ksk```s``s`kski``s`k``s``s`kski``s``s`ksk```sii``s``s`kski`k``s``si`k`````sii``s``s`ksk``s``s`kski`s``s`ksk``s`k``s``s`ksk```sii``s``s`kski```s``siii``s``s`kski`k``s``si`k`````s``siii``s``s`kski`s``s`ksk```s``sii`s``s`ksk``s``s`kski`k``s``si`k``s``s`ksk```s``s`kski``s``s`ksk``s`k``s``s`kski``s``s`ksk```sii``s``s`kski`k``s``si`k``s``s`ksk```s``s`kski``s`k``s``s`kski``s``s`ksk```sii``s``s`kski`k``s``si`k``s``s`ksk``s``s`ksk``s``s`ksk```s`s``s`ksk``sii``s``s`kski`k``s``si`k``s`k``s``s`ksk``s``s`kski``s``s`ksk```sii``s``s`ksk``s``s`kski`k``s``si`k``s`k``s``s`kski``s``s`ksk``s`k``s``s`kski``s``s`ksk```s``siii``s``s`kski`k``s``si`k``s``s`ksk``s``s`ksk```s``s`kski``s``s`ksk``s`k``s``s`kski``s``s`ksk```sii``s``s`kski`k``s``si`k``s`k``s``s`ksk``s``s`kski```s``siii``s``s`kski`k``s``si`k``s`k``s``s`kski``s``s`ksk``s`k``s``s`ksk``s``s`kski```s``siii``s``s`kski`k``s``si`k``s`k``s``s`kski```s``s`kski``s``s`ksk```sii``s``s`kski`k``s``si`k``s`k``s``s`kski``s``s`ksk``s`k``s``s`ksk``s``s`kski```s``siii``s``s`kski`k``s``si`k``s`k``s``s`kski```s``s`kski``s``s`ksk```sii``s``s`kski`k``s``si`k``s``s`ksk```s``s`kski``s`k``s``s`kski``s``s`ksk```sii``s``s`kski`k``s``si`k```s``s`kski``s`k``s``s`kski``s``s`ksk```sii``s``s`kski`k``s``si`k`````s``siii``s``s`kski`s``s`ksk```s``sii`s``s`ksk``s``s`kski`k``s``si`k``s`k``s`k``s``s`kski``s``s`ksk``s``s`kski``s``s`ksk```s``siii``s``s`kski`k``s``si`k``s``s`ksk``s`k``s``s`kski```sii``s``s`ksk``s``s`kski`k``s``si`k``s`k``s``s`kski``s``s`ksk```s``s`kski``s``s`ksk```sii``s``s`kski`k``s``si`k``s`k``s``s`kski```s``s`kski``s``s`ksk```sii``s``s`kski`k``s``si`k``s`k``s``s`kski```s``s`kski``s``s`ksk```sii``s``s`kski`k``s``si`k``s`k``s``s`kski``s``s`ksk```s``s`kski``s``s`ksk```sii``s``s`kski`k``s``si`k``s`k``s``s`ksk``s``s`kski```s``siii``s``s`kski`k``s``si`k```s``s`kski``s`k``s``s`kski``s``s`ksk```sii``s``s`kski`k``s``si`k``s``s`ksk```s``s`kski``s`k``s``s`kski``s``s`ksk```sii``s``s`kski`k``s``si`k``s``s`ksk``s`k``s``s`kski``s``s`ksk```sii``s``s`ksk``s``s`kski`k``s``si`k``s``s`ksk``s`k``s``s`kski```sii``s``s`ksk``s``s`kski`k``s``si`k``s`k``s`k``s``s`kski``s``s`ksk``s``s`kski``s``s`ksk```s``siii``s``s`kski`k``s``si`k``s`k``s``s`kski``s``s`ksk```s``s`kski``s``s`ksk```sii``s``s`kski`k``s``si`k``s`k``s``s`kski``s``s`ksk```s``s`kski``s``s`ksk```sii``s``s`kski`k``s``si`k``s`k``s``s`kski``s``s`ksk```sii``s``s`ksk``s``s`kski`k``s``si`k``s`k``s``s`kski``s``s`ksk```s``s`kski``s``s`ksk```sii``s``s`kski`k``s``si`k``s`k``s``s`ksk``s``s`kski```s``siii``s``s`kski`k``s``si`k``s`k``s``s`kski``s``s`ksk``s`k``s``s`ksk``s``s`kski```s``siii``s``s`kski`k``s``si`k``s`k``s``s`kski``s``s`ksk```sii``s``s`ksk``s``s`kski`k``s``si`k``s`k``s``s`ksk``s``s`kski``s``s`ksk```s``siii``s``s`kski`k``s``si`k``s`k``s``s`ksk``s``s`kski```s``siii``s``s`kski`k``s``si`k```s``s`kski``s`k``s``s`kski``s``s`ksk```sii``s``s`kski`k``s``si`k``s`k``s``s`ksk``s``s`kski```s``siii``s``s`kski`k``s``si`k``s`k``s``s`kski``s``s`ksk``s`k``s``s`ksk``s``s`kski```s``siii``s``s`kski`k``s``si`k``s``s`ksk```s``s`kski``s`k``s``s`kski``s``s`ksk```sii``s``s`kski`k``s``si`k``s`k``s`k``s``s`kski``s``s`ksk``s``s`kski``s``s`ksk```s``siii``s``s`kski`k``s``si`k```s``s`kski``s`k``s``s`kski``s``s`ksk```sii``s``s`kski`k``s``si`k``s``s`ksk``s`k``s``s`kski``s``s`ksk```s``s`kski``s``s`ksk```sii``s``s`kski`k``s``si`k``s`k``s``s`kski``s``s`ksk``s`k``s``s`ksk``s``s`kski```s``siii``s``s`kski`k``s``si`k``s`k``s``s`kski``s``s`ksk``s`k``s``s`ksk``s``s`kski```s``siii``s``s`kski`k``s``si`k``s``s`ksk``s`k``s``s`kski``s``s`ksk```sii``s``s`ksk``s``s`kski`k``s``si`k``s``s`ksk``s`k``s``s`kski```sii``s``s`ksk``s``s`kski`k``s``si`k```s``s`ksk``s``s`kski``s``s`ksk```sii``s``s`kski`k`kk  # "HarekazeCTF{0b2b2edaf742240de97f44840b830d0befd5bb97}"
`k
``s``si`k``s`k``s``s`ksk``s``s`kski``s``s`ksk``s`k``s``s`kski```s``siii``s``s`kski`k``s``si`k``s``s`ksk``s`k``s``s`kski``s``s`ksk``s`k``s``s`kski```sii``s``s`ksk``s``s`kski`k``s``si`k``s`k``s``s`kski``s``s`ksk``s`k``s``s`kski``s``s`ksk```sii``s``s`ksk``s``s`kski`k``s``si`k``s`k``s``s`kski``s``s`ksk``s`k``s``s`kski``s``s`ksk```sii``s``s`ksk``s``s`kski`k``s``si`k``s``s`ksk```s``s`kski``s`k``s``s`kski``s``s`ksk```sii``s``s`kski`k``s``si`k``s`k``s``s`ksk``s``s`kski``s``s`ksk``s`k``s``s`kski```s``siii``s``s`kski`k``s``si`k``s`k```sii``s``s`kski``s``s`ksk``s``s`ksk```sii``s``s`ksk``s``s`kski`k``s``si`k``s`k``s``s`kski```s``siii``s``s`kski`k``s``si`k``s`k``s`k``s``s`kski``s``s`ksk``s``s`kski``s``s`ksk```s``siii``s``s`kski`k``s``si`k``s`k```sii``s``s`kski```sii``s``s`ksk``s``s`kski`k``s``si`k`````s``siii``s``s`kski`s``s`ksk```s``sii`s``s`ksk``s``s`kski`k``s``si`k``s``s`ksk``s`k``s`k``s``s`kski``s``s`ksk``s``s`kski``s``s`ksk```s``siii``s``s`kski`k``s``si`k``s`k``s``s`kski``s``s`ksk```sii``s``s`kski`k```sii``sii  # "correct flag"
`k
``s``si`k``s`k``s``s`ksk``s`k``s``s`kski``s``s`ksk``s``s`kski``s``s`ksk```s``siii``s``s`kski`k``s``si`k``s`k``s``s`kski``s``s`ksk``s`k``s``s`kski``s``s`ksk```sii``s``s`ksk``s``s`kski`k``s``si`k``s``s`ksk``s`k``s``s`kski``s``s`ksk``s`k``s``s`kski```sii``s``s`ksk``s``s`kski`k``s``si`k``s`k``s``s`kski``s``s`ksk``s`k``s``s`kski```sii``s``s`ksk``s``s`kski`k``s``si`k``s``s`ksk``s`k``s`k``s``s`kski``s``s`ksk``s``s`kski``s``s`ksk```s``siii``s``s`kski`k``s``si`k``s`k``s``s`kski```s``siii``s``s`kski`k``s``si`k``s`k``s`k``s``s`kski``s``s`ksk``s``s`kski``s``s`ksk```s``siii``s``s`kski`k``s``si`k``s`k```sii``s``s`kski```sii``s``s`ksk``s``s`kski`k``s``si`k`````s``siii``s``s`kski`s``s`ksk```s``sii`s``s`ksk``s``s`kski`k``s``si`k``s``s`ksk``s`k``s`k``s``s`kski``s``s`ksk``s``s`kski``s``s`ksk```s``siii``s``s`kski`k``s``si`k``s`k``s``s`kski``s``s`ksk```sii``s``s`kski`k```sii``sii  # "wrong flag"
```
