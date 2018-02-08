# gacha 1, 2

## solution for 1

since the plaintexts are fixed (without paddings), you can know the plaintexts for the ciphertexts with encrypting the fixed texts.

## solution for 2

similar to the previous problem, but paddings are added.
but `random` of the Python standard library is used to generate paddings, you can predict the paddings.

`mt19937predictor` is my library, originally written for a challenge of other CTF, and registered to PyPI while I was making this challenge. but patched a little.

```
2d1
< # https://github.com/kmyk/mersenne-twister-predictor/blob/master/mt19937predictor.py  (edited)
97,98c96
<         self._mt = list(args[0][0])
<         self._mti = args[0][1]
---
>         raise NotImplementedError
101c99
<         return ( tuple(self._mt), self._mti )
---
>         raise NotImplementedError
```
