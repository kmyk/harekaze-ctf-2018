# Harekaze CTF: gacha 1, 2

## problem 1

[ガチャの出現確率「3％」、実際は0.333％　スマホゲーム「KOF」運営会社に措置命令 - ITmedia NEWS](http://www.itmedia.co.jp/news/articles/1801/26/news125.html)

-   `nc problem.harekaze.com 30214`
-   [problem-1.py]()

(Crypto, 100 points)


## problem 2

![](http://1.bp.blogspot.com/-CQ1BFBhBR5U/Vs1mVP0r6BI/AAAAAAAA4Io/8o5Gmw3kKPI/s800/gachagacha_ataranai.png)
[なかなか当たらないガチャのイラスト | かわいいフリー素材集 いらすとや]()

-   [problem-2.py]()
-   `nc problem.harekaze.com 30002`

(Crypto, 350 points)

## solution for 1

since the plaintexts are fixed (without paddings), you can know the plaintexts for the ciphertexts with encrypting the fixed texts.

## note for 1

it seems I should have told the name of cryptosystem, RSA, because this problem is for beginners

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
