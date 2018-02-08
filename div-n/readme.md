# Div N

## description

```
$ N=974873638438446
$ cat foo.c
long long div(long long x) {
    return x / N;
}
$ gcc -DN=$N -c -O2 foo.c
$ objdump -d foo.o

foo.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <div>:
   0:	48 89 f8             	mov    %rdi,%rax
   3:	48 ba 01 0d 1a 82 9a 	movabs $0x49ea309a821a0d01,%rdx
   a:	30 ea 49 
   d:	48 c1 ff 3f          	sar    $0x3f,%rdi
  11:	48 f7 ea             	imul   %rdx
  14:	48 c1 fa 30          	sar    $0x30,%rdx
  18:	48 89 d0             	mov    %rdx,%rax
  1b:	48 29 f8             	sub    %rdi,%rax
  1e:	c3                   	retq   
$ echo "HarekazeCTF{$N}" > /dev/null
```

## solution

1.  read carefully and decode it by hand
    -   st98 said that he did this with reading <https://yurichev.com/blog/modulo/>
2.  reconstruct the executable and do binary search
    -   easy
    -   the $N$ is the minimum natural number $x$ which satisfies `div(x) = x`

why the asm is given instead of `foo.o` is to hide the 2nd solution and let people to do the 1st one.
