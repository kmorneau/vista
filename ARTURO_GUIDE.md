# Arturo Programming language
## Language overview
Arturo is a very simple language. Even without any prior experience, I estimate it would take you roughly half an hour before you are comfortable enough to write your first program. 

Here, you'll find everything you may need to know about the language (and perhaps a bit more). In a single page. 

---

- [Introduction](#introduction)
- [The basics](#the-basics)
   * [Words](#words)
   * [Labels](#labels)
   * [Symbols](#symbols)
   * [Attributes](#attributes)
       - [:attribute](#attribute)
       - [:attributeLabel](#attributeLabel)
   * [More values](#more-values)
       - [:null](#null)
       - [:logical](#logical)
       - [:integer](#integer)
       - [:floating](#floating)
       - [:complex](#complex)
       - [:rational](#rational)
       - [:version](#version)
       - [:type](#type)
       - [:char](#char)
       - [:string](#string)
       - [:range](#range)
       - [:regex](#regex)
       - [:path](#path)
       - [:pathLabel](#pathLabel)
       - [:literal](#literal)
       - [:symbolLiteral](#symbolLiteral)
       - [:pathLiteral](#pathLiteral)
       - [:inline](#inline)
       - [:block](#block)
       - [:dictionary](#dictionary)
       - [:store](#store)
       - [:object](#object)
       - [:function](#function)
       - [:method](#method)
       - [:unit](#unit)
       - [:quantity](#quantity)
       - [:color](#color)
       - [:date](#date)
       - [:database](#database)
       - [:socket](#socket)
       - [:binary](#binary)
       - [:bytecode](#bytecode)
- [Important concepts](#important-concepts)
   * [Precedence and evaluation](#precedence-and-evaluation)
       - [The right-to-left rule](#the-right-to-left-rule)
   * [Scope and rules](#scope-and-rules)
       - [Blocks](#blocks)
       - [Iterators](#iterators)
       - [Functions](#functions)
   * [In-place variable modification](#in-place-variable-modification)
       - [Using literals](#using-literals)
- [Syntactic sugar](#syntactic-sugar)
   * [Right-arrow operator: `->`](#right-arrow-operator)
   * [Fat right-arrow operator: `=>`](#fat-right-arrow-operator)
   * [Double-colon operator: `::`](#double-colon-operator)
   * [Exclamation-mark operator: `!`](#exclamation-mark-operator)
   * [Pipe operator: `|`](#pipe-operator)
- [Conclusion](#conclusion)

---

<h2 id="introduction">Introduction</h2>

Arturo's syntax is probably as easy as it could get. Basically, you could say: *there is no syntax*.

Let's try to resume some key points of Arturo's no-syntax:

- Code is just a list of **words**, **labels**, **symbols**, **values** and **attributes** (you'll learn what all this is about very soon!)
- Code can be grouped into **blocks** (that is: a *list* of words, labels, symbols, and values within square brackets: `[ ... ]`
- A block has no meaning until it is given one, or interpreted within some specific context, that is: `[ lorem ipsum ]` is perfectly valid Arturo code, until you try to "run" it - where the interpreter will complain that it has no idea what `lorem` and `ipsum` is. Pretty much like if I tell you a word in Swahili - you'll most likely need a dictionary to figure out what it might mean.
- There are <u>no reserved "keywords"</u>. Every word can be re-defined.
- You can format your code any way you want: no semicolons to add, no obligatory newlines, no commas, no parentheses, no Python-style indentation rules
- Every **function** expects a pre-determined number of arguments. Initially, we check during evaluation, and during runtime, we "consume" values until we reach the number of arguments required.

As you can see, there is not much to learn from scratch here:

Once you learn what the language [**building blocks**](#the-basics) are & a few details about **[precedence and evaluation](#precedence-and-evaluation)**, then only with the [**Library Reference**](../library/) at hand (the built-in functions that are already there for you, available to use), you're pretty much ready to write *any* program. ;-)

So, let's get to the gist of the matter!

<h2 id="the-basics">The basics</h2>

<h3 id="words">Words</h3>

*Words* in Arturo are pretty much like words in English: a series of characters separated by *spaces* or some [*symbol*](#symbols). E.g.: `this is a series of words` (in this case, `this`, `is`, `a`, `series`, `of`, `words` are all - well... - *words*.

> 💡 In Arturo, a word can be start with any letter or underscore followed by any letter/numbers/underscore or a question mark (`?`).

As with a real (spoken) language, every word has a specific meaning. And if you don't know the meaning of a word, you'll have to look it up in the dictionary. That's pretty much the way things work in Arturo as well.

In Arturo, a *word* may have 3 main different uses:

- refer to a value (that is: a variable, e.g. `x + 2`)
- refer to an action, which does something (that is: a function, e.g. `doSomething`) - Arturo comes with hundreds already defined in its standard library
- refer to nothing (that is: a word without meaning, as in the `[lorem ipsum]` example above)

<h3 id="labels">Labels</h3>

A label is nothing but Arturo's way of assigning meaning (to be read as a value) to a word - what you would normally call *variable assignment* or *variable initialization*. (In Arturo, these two terms can be used invariably, since there is practically no difference: you can set and re-define a word/variable as many times as you wish).

So, let's say you want to give a new meaning to the word `x`:

```arturo
x: 2
```
That was it: from now on, `x` will mean `2` (until and if it's changed). So if you follow the above statement with:
```arturo
print x
```
...Arturo will print `2` for you.

<h3 id="symbols">Symbols</h3>

As the mere word says, *symbols* are used to symbolize something, mainly as an alias to an existing *word* - although, by convention, as *infix* operators.

Hence, let's take the function <code><a href="../library/arithmetic/add">add</a></code>. This takes two parameters, adds them up, and returns the result.

So, you may write:

```arturo
print add 2 3
```
and Arturo will print out `5` for you.

Now, if you don't want to use the <code><a href="../library/arithmetic/add">add</a></code> function (and *prefix notation*, which is the standard for *all* function calls), there is a *symbol-alias* for that: `+`

So, you could just as well write:

```arturo
print 2 + 3
```
Only, this time you're expressing it more like you would in a normal math expression: with *infix notation*.

Here is the complete list of symbols recognized in Arturo, along with their predefined usage - if any:

<table><tr><th>Symbol</th><th>Usage</th></tr>
<tr><td><code>&lt;=</code></td><td><i>alias of</i> <code><a href="../library/core/dup">dup</a></code> (prefix)</td></tr>
<tr><td><code>=&gt;</code></td><td><a href="#fat-right-arrow-operator">syntactic sugar</a></td></tr>
<tr><td><code>&lt;=&gt;</code></td><td><i>alias of</i> <code><a href="../library/comparison/between-">between?</a></code> (infix)</td></tr>
<tr><td><code>&lt;&lt;=</code></td><td>-</td></tr>
<tr><td><code>=&gt;&gt;</code></td><td>-</td></tr>
<tr><td><code>&lt;&lt;=&gt;&gt;</code></td><td>-</td></tr>
<tr><td><code>&lt;-</code></td><td>-</td></tr>
<tr><td><code>-&gt;</code></td><td><a href="#right-arrow-operator">syntactic sugar</a></td></tr>
<tr><td><code>&lt;-&gt;</code></td><td>-</td></tr>
<tr><td><code>&lt;&lt;-</code></td><td>-</td></tr>
<tr><td><code>-&gt;&gt;</code></td><td>-</td></tr>
<tr><td><code>&lt;&lt;-&gt;&gt;</code></td><td>-</td></tr>
<tr><td><code>-&lt;</code></td><td>-</td></tr>
<tr><td><code>&gt;-</code></td><td>-</td></tr>
<tr><td><code>&gt;-&lt;</code></td><td>-</td></tr>
<tr><td><code>-&lt;&lt;</code></td><td>-</td></tr>
<tr><td><code>&gt;&gt;-</code></td><td>-</td></tr>
<tr><td><code>&gt;&gt;-&lt;&lt;</code></td><td>-</td></tr>
<tr><td><code>&lt;&lt;</code></td><td><i>alias of</i> <code><a href="../library/files/read">read</a></code> (prefix)</td></tr>
<tr><td><code>&gt;&gt;</code></td><td><i>alias of</i> <code><a href="../library/files/write">write</a></code> (infix)</td></tr>
<tr><td><code>&lt;&lt;&lt;</code></td><td>-</td></tr>
<tr><td><code>&gt;&gt;&gt;</code></td><td>-</td></tr>
<tr><td><code>&lt;--</code></td><td>-</td></tr>
<tr><td><code>--&gt;</code></td><td><i>alias of</i> <code><a href="../library/quantities/convert">convert</a></code> (infix)</td></tr>
<tr><td><code>&lt;--&gt;</code></td><td>-</td></tr>
<tr><td><code>&lt;==</code></td><td>-</td></tr>
<tr><td><code>==&gt;</code></td><td>-</td></tr>
<tr><td><code>&lt;==&gt;</code></td><td>-</td></tr>
<tr><td><code>&lt;~</code></td><td>-</td></tr>
<tr><td><code>~&gt;</code></td><td>-</td></tr>
<tr><td><code>&lt;~&gt;</code></td><td>-</td></tr>
<tr><td><code>|&gt;</code></td><td>-</td></tr>
<tr><td><code>&lt;|</code></td><td>-</td></tr>
<tr><td><code>&lt;|&gt;</code></td><td>-</td></tr>
<tr><td><code>=&lt;</code></td><td><i>alias of</i> <code><a href="../library/comparison/lessOrEqual-">lessOrEqual?</a></code> (infix)</td></tr>
<tr><td><code>&gt;=</code></td><td><i>alias of</i> <code><a href="../library/comparison/greaterOrEqual-">greaterOrEqual?</a></code> (infix)</td></tr>
<tr><td><code>&lt;&gt;</code></td><td><i>alias of</i> <code><a href="../library/comparison/notEqual-">notEqual?</a></code> (infix)</td></tr>
<tr><td><code>&lt;:</code></td><td>-</td></tr>
<tr><td><code>-:</code></td><td>-</td></tr>
<tr><td><code>&gt;:</code></td><td>-</td></tr>
<tr><td><code>~</code></td><td><i>alias of</i> <code><a href="../library/strings/render">render</a></code> (prefix)</td></tr>
<tr><td><code>!</code></td><td><a href="#exclamation-mark-operator">syntactic sugar</a></td></tr>
<tr><td><code>!!</code></td><td>-</td></tr>
<tr><td><code>?</code></td><td><i>alias of</i> <code><a href="../library/core/switch">switch</a></code> (infix)</td></tr>
<tr><td><code>??</code></td><td><i>alias of</i> <code><a href="../library/core/coalesce">coalesce</a></code> (infix)</td></tr>
<tr><td><code>@</code></td><td><i>alias of</i> <code><a href="../library/collections/array">array</a></code> (prefix)</td></tr>
<tr><td><code>#</code></td><td><i>alias of</i> <code><a href="../library/collections/dictionary">dictionary</a></code> (prefix)</td></tr>
<tr><td><code>##</code></td><td>-</td></tr>
<tr><td><code>###</code></td><td>-</td></tr>
<tr><td><code>####</code></td><td>-</td></tr>
<tr><td><code>#####</code></td><td>-</td></tr>
<tr><td><code>######</code></td><td>-</td></tr>
<tr><td><code>$</code></td><td><i>alias of</i> <code><a href="../library/core/function">function</a></code> (prefix)</td></tr>
<tr><td><code>%</code></td><td><i>alias of</i> <code><a href="../library/arithmetic/mod">mod</a></code> (infix)</td></tr>
<tr><td><code>^</code></td><td><i>alias of</i> <code><a href="../library/arithmetic/pow">pow</a></code> (infix)</td></tr>
<tr><td><code>&amp;</code></td><td>-</td></tr>
<tr><td><code>*</code></td><td><i>alias of</i> <code><a href="../library/arithmetic/mul">mul</a></code> (infix)</td></tr>
<tr><td><code>**</code></td><td>-</td></tr>
<tr><td><code>-</code></td><td><i>alias of</i> <code><a href="../library/arithmetic/sub">sub</a></code> (infix)</td></tr>
<tr><td><code>--</code></td><td><i>alias of</i> <code><a href="../library/collections/remove">remove</a></code> (infix)</td></tr>
<tr><td><code>=</code></td><td><i>alias of</i> <code><a href="../library/comparison/equal-">equal?</a></code> (infix)</td></tr>
<tr><td><code>==</code></td><td>-</td></tr>
<tr><td><code>=~</code></td><td>-</td></tr>
<tr><td><code>+</code></td><td><i>alias of</i> <code><a href="../library/arithmetic/add">add</a></code> (infix)</td></tr>
<tr><td><code>++</code></td><td><i>alias of</i> <code><a href="../library/collections/append">append</a></code> (infix)</td></tr>
<tr><td><code>&lt;</code></td><td><i>alias of</i> <code><a href="../library/comparison/less-">less?</a></code> (infix)</td></tr>
<tr><td><code>&gt;</code></td><td><i>alias of</i> <code><a href="../library/comparison/greater-">greater?</a></code> (infix)</td></tr>
<tr><td><code>/</code></td><td><i>alias of</i> <code><a href="../library/arithmetic/div">div</a></code> (infix)</td></tr>
<tr><td><code>/%</code></td><td><i>alias of</i> <code><a href="../library/arithmetic/divmod">divmod</a></code> (infix)</td></tr>
<tr><td><code>//</code></td><td><i>alias of</i> <code><a href="../library/arithmetic/fdiv">fdiv</a></code> (infix)</td></tr>
<tr><td><code>\</code></td><td>-</td></tr>
<tr><td><code>\\</code></td><td>-</td></tr>
<tr><td><code>|</code></td><td><a href="#pipe-operator">syntactic sugar</a></td></tr>
<tr><td><code>|-</code></td><td>-</td></tr>
<tr><td><code>|=</code></td><td>-</td></tr>
<tr><td><code>..</code></td><td><i>alias of</i> <code><a href="../library/collections/range">range</a></code> (infix)</td></tr>
<tr><td><code>...</code></td><td>-</td></tr>
<tr><td><code>./</code></td><td><i>alias of</i> <code><a href="../library/paths/relative">relative</a></code> (prefix)</td></tr>
<tr><td><code>:</code></td><td><i>alias of</i> <code><a href="../library/core/let">let</a></code> (infix)</td></tr>
<tr><td><code>::</code></td><td><a href="#double-colon-operator">syntactic sugar</a></td></tr>
<tr><td><code>:=</code></td><td><i>alias of</i> <code><a href="../library/quantities/conforms-">conforms?</a></code> (infix)</td></tr>
<tr><td><code>||</code></td><td>-</td></tr>
<tr><td><code>∅</code></td><td><i>alias of</i> <code><a href="../library/core/null">null</a></code></td></tr>
<tr><td><code>∞</code></td><td><i>alias of</i> <code><a href="../library/numbers/infinite">infinite</a></code></td></tr> 
<tr><td><code>∑</code></td><td><i>alias of</i> <code><a href="../library/numbers/sum">sum</a></code> (prefix)</td></tr>
<tr><td><code>∏</code></td><td><i>alias of</i> <code><a href="../library/numbers/product">product</a></code> (prefix)</td></tr>
<tr><td><code>∩</code></td><td><i>alias of</i> <code><a href="../library/sets/intersection">intersection</a></code> (infix)</td></tr>
<tr><td><code>∪</code></td><td><i>alias of</i> <code><a href="../library/sets/union">union</a></code> (infix)</td></tr>
<tr><td><code>⊂</code></td><td>-</td></tr>
<tr><td><code>⊃</code></td><td>-</td></tr>
<tr><td><code>⊆</code></td><td><i>alias of</i> <code><a href="../library/sets/subset-">subset?</a></code> (infix)</td></tr>
<tr><td><code>⊇</code></td><td><i>alias of</i> <code><a href="../library/sets/superset-">superset?</a></code> (infix)</td></tr>
<tr><td><code>∈</code></td><td><i>alias of</i> <code><a href="../library/collections/in-">in?</a></code> (infix)</td></tr>
<tr><td><code>∉</code></td><td>-</td></tr>
<tr><td><code>∧</code></td><td><i>alias of</i> <code><a href="../library/logic/and-">and?</a></code> (infix)</td></tr>
<tr><td><code>∨</code></td><td><i>alias of</i> <code><a href="../library/logic/or-">or?</a></code> (infix)</td></tr>
<tr><td><code>⊻</code></td><td><i>alias of</i> <code><a href="../library/logic/xor-">xor?</a></code> (infix)</td></tr>
<tr><td><code>⊼</code></td><td><i>alias of</i> <code><a href="../library/logic/nand-">nand?</a></code> (infix)</td></tr>
<tr><td><code>¬</code></td><td><i>alias of</i> <code><a href="../library/logic/not-">not?</a></code> (prefix)</td></tr>
</table>

<h3 id="attributes">Attributes</h3>

Another interesting feature of Arturo is what we'll analyze here: attributes.

Technically, *attributes* are nothing but an easy way of defining optional named parameters for functions - but which can however transcend between different function calls.

There are two types: 

 a. attributes   
 b. attribute labels

<h4 id="attribute">:attribute</h4>

Attributes are actually optional on/off-type of values, set during a function call, that is there to denote some variation of the initial meaning of the function. To define an attribute, we'll be using a `.`(dot) followed by a normal word: `\.\w+`

Let's say we used the function <code><a href="../library/collections/split">split</a></code>, to split a string into parts:
```arturo
split "hello world"

; => [`h` `e` `l` `l` `o` ` ` `w` `o` `r` `l` `d` ]
```
That does what it says: splits the string into an array of `:char`s.

What if we want for example to split the string into words? For that, there is the `.words` attribute for the function <code><a href="../library/collections/split">split</a></code>. So:

```arturo
split.words "hello world"

; = ["hello" "world"]
```
> 💡 The order in which you pass the different attributes does <u>not</u> matter. Also, there is no issue at all whether you want to use spaces between them and the surrounding function call; Arturo will still be able to parse them and recognize them fine

<h4 id="attributeLabel">:attributeLabel</h4>

Attribute labels are pretty much like simple *attributes*, only they can also take a value. As it worked with *attributes*, we'll be using a `.`(dot) followed by a normal word, but now also followed by a `:`(colon) -- exactly like with normal *labels*, as we've seen above.

Here's an example:

```arturo
split .every: 2 "hello world"

; => ["he" "ll" "ow" "or" "ld"]
```

<h3 id="more-values">More Values</h3>

Values are the very core of Arturo and are used to refer to pretty much all the different kinds of data you can have.

> 💡 Words, labels, and symbols - that we already saw above - can be considered "values" as well; and treated as such, unless we proceed to evaluate them!

We could split values into 2 categories: a) literal values - that is values you can directly define in your code and b) constructible - values that are created using some function.

The (hopefully) complete list follows.

<h4 id="null">:null</h4>

Null values generally denote *nothing* and it's mostly used as a return value by functions to inform us that something went wrong. If you want to set it as a  value, you may just use the *word* <code><a href="../library/core/null">null</a></code>, like:

```arturo
x: null
```

<h4 id="logical">:logical</h4>

Logicals are Arturo's logical values. They are like normal boolean values (true, false), with a twist: they fully support ternary logic and an additional <code><a href="../library/logic/maybe">maybe</a></code> value.

```arturo
x: true
y: false
z: maybe
```

<h4 id="integer">:integer</h4>

Integers represent positive or negative integers. When they are declared they are comprised only by digits (`[0-9]+`) and they can be as long as you want - Arturo does support big numbers.

```arturo
x: 2
y: 876528347613438247982374913423423947329
```

<h4 id="floating">:floating</h4>

Floating values are basically floating-point numbers, that is: decimals. They begin with an initial all-digit part, followed by a `.` (dot) and another all-digit part: `[0-9]+\.[0-9]+`

```arturo
pi: 3.14159
```

<h4 id="complex">:complex</h4>

Even though there is no special syntax for defining a complex number, you can always create one using <code><a href="../library/types/to">to</a></code>. Arturo comes with full support for complex numbers and all the associated operations.

```arturo
a: to :complex [1 2]      ; a: 1.0+2.0i
b: to :complex @[pi pi]   ; b: 3.141592653589793+3.141592653589793i

print a + b 
; 4.141592653589793+5.141592653589793i
```

<h4 id="rational">:rational</h4>

The syntax for rational literals is simply a number followed by a colon, followed by a number (pretty much like you would normally represent a ratio).

```arturo
a: 1:2                   ; 1/2
b: 3:4                   ; 3/4
```

As with complex numbers, rationals can also be defined using <code><a href="../library/types/to">to</a></code>. And again, Arturo comes with full support for rational numbers and all the associated operations.

```arturo
a: to :rational [1 2]     ; 1/2
b: to :rational [3 4]     ; 3/4

print a + b 
; 5/4
```

<h4 id="version">:version</h4>

Version values are nothing but a fancy and portable way of defining SemVer-compliant versions (e.g. for packaging an application). The rule is rather simple: it has three numeric parts, separated by a `.` (dot) and an optional part with build or prerelease information.

```arturo
package: 1.0.3

if package > 1.0.0 -> print "yep, the version is right!"
```

or

```arturo
version: 1.2.3-rc1+build123
```

<h4 id="type">:type</h4>

Type is a value representing another... type. To specify a type value, the format is a `:` (colon) followed by a word - the type's name: `:\w+`

```arturo
myType: :integer
```
or
```arturo
if (type x) = :integer [ print "it's an integer!" ]
```

> 💡 If you want to define your own custom types (think "classes" in OOP languages), we have <code><a href="../library/types/define">define</a></code> for that: e.g. 
> ```arturo
> define :person [
>    init: method [name :string][
>        \name: name 
>    ]
> ]
> p: to :person ["John"]!
> print p\name ; John
> ```

<h4 id="char">:char</h4>

Characters in Arturo can be declared using single quotes:  `'\w'`

```arturo
ch: 'a'
```

<h4 id="string">:string</h4>

A string is nothing but a series of characters, seen as one unit. In Arturo, to define a string, there are various ways:

**Single-line strings**

- using double quotes: ```x: "this is a string"``` (with escaped characters)
- using right *smart-quote* notation ```x: « This is a string``` (in this case, everything following `«` till the end of the line, will be stripped and considered one string)

**Multi-line strings**

- using curly-brace blocks (the result will be stripped and un-indented):
  ```arturo
  x: {
      this is yet
      another
      very
      long string
      that spans more
      than
      one
      line
  }
  ```

- using verbatim curly-brace blocks (the result will remain exactly as-is):
  ```arturo
  x: {:
    this is yet
      another
      very
    long string
    that spans more
        than
            one
            line
  :}
  ```
- using dash notation (where everything after the line, until the end of the file, is a string - stripped and un-indented):
  ```arturo
  x: 
  ------
  this is the last very
  long string
  that spans more
  than
  one
  line
  ```

> 💡 If you want your string to contain sub-expressions that will be evaluated on the fly - that is *string interpolation* - all you have to do is include your code inside the string within pipe-bars and then call the function <code><a href="../library/string/render">render</a></code> (or `~`) to process it accordingly: e.g. 
> ```arturo
> x: 2
> print ~"my variable is: |x|"
> 
> ; prints: 
> ; my variable is: 2
> ```

<h4 id="range">:range</h4>

Arturo comes with full support of lazy ranges.

To create a range all you have to do is use the built-in <code><a href="../library/collections/range">range</a></code> function (or its `..` infix equivalent):

```arturo
numbers: 1..10    ; contains all numbers from 1 to 10 (inclusive)
downwards: 10..1  ; this is valid as well

chars: 'a'..'z'   ; yes, we can actually have character ranges too
```

Ranges can be used in most functions as-is, e.g. Iterators, where we can take full advantage of their "lazy" nature: they are not evaluated until needed.

However, you can still evaluate a lazy range into its corresponding block any time you want:

```arturo
@1..10 ; [1,2,3,4,5,6,7,8,9,10]
```

<h4 id="regex">:regex</h4>

A regex value is nothing but a string containing a regular expression (that is then compiled and treated as such).

The normal syntax is `{/regex/}`:

```arturo
type {/[A-Z]/}                    ; => :regex

replace "HelLo" {/[A-Z]/} "X"     ; here we replace all capital letters
                                  ; with an X
```

While we may - optionally - use any of the supported PCRE-compliant flags:

- `i`: case-insensitive matching
- `m`: multiline
- `s`: dot-all

```arturo
match "Hello" {/he/i}             ; => ["He"]
```

<h4 id="path">:path</h4>

Paths in Arturo are a way of defining some hierarchy between values, something along the lines of *parent* -> *child* -> *grandchild*. For this, in Arturo, we'd use a series of *values* or *words* delimited with a `\` (backslash). You can think of them as *indexes* in other programming languages.

```arturo
print user\name
```

or

```arturo
x: "name"
print user\[x]
```

or

```arturo
myArray: ["zero" "one" "two" "three"]
print myArray\1

; prints "one"
```

<h4 id="pathLabel">:pathLabel</h4>

If paths are the way of defining some hierarchy between values, with *pathLabel*s we are also able to assign values to some specific path.

```arturo
user: #[
    name: "John"
    surname: "Doe"
]
print user\name  ; will print "John"

; let's change this user's name
user\name: "Jane"

; we can also do it like that
x: "name"
user\[x]: "Jane"

print user\name ; ok, now it should print "Jane"
```

> 💡 If you we are inside a custom type, an easy way to refer to fields of the same object is using `this`. However, Arturo comes with a shortcut: e.g. 
> ```arturo
> define :person [
>    init: constructor [name :string]
>    sayHello: method [][
>        print ["Hello" \name] ; this is equivalent to `this\name`
>    ]
> ]
> ```
> which generally helps us write more better-looking code. :)

<h4 id="literal">:literal</h4>

Literals in Arturo are just a way of referring to the *name* of a word or symbol. Think of it as the *string* version of a word, or like Ruby's *symbols*. 

For example, the function <code><a href="../library/reflection/info">info</a></code> takes as an argument the name of the function for which you want some information. If you wrote like `info print`, the interpreter would execute the function <code><a href="../library/io/print">print</a></code> and try to... print something (which would not be there). If you wanted to refer to the *name* of the function -- that is: without actually calling it -- you would precede it with a `'` (single-quote): `'[\w+]`

```arturo
func: 'print
info func
```

However, literals may be used for much more - e.g. modifying a passed parameter in-place, without having to re-assign the result of an operation to a new variable. To learn more, have a look at **[In-place variable modification](#in-place-variable-modification)**.

<h4 id="symbolLiteral">:symbolLiteral</h4>

Symbol literals are to symbols pretty much what literals are to words. That is: the "literal", unevaluated form of the symbol.

To declare a symbol literal, we may follow the example of normal, literals: `single quote` + accompanied by the symbol in question:

```arturo
type '++        ; => :symbolliteral
```

<h4 id="pathLiteral">:pathLiteral</h4>

Now, that we've seen both "normal" literals and paths, I guess you can already imagine what Path Literals are about... :)

And, yes, you guessed right:

```arturo
type 'this\is\a\path  ; => :pathliteral
```

<h4 id="inline">:inline</h4>

*Inline*s in Arturo generally denote a list of words/symbols/values that are grouped and given some type of priority in evaluation. An *inline* block is denoted by `(...)` (parentheses).

```arturo
print (2+3)*4
```

Please note though that, apart from precedence, `:inline` is a value type on its own:

```arturo
a: [(one) two three]
print type a\0      ; that is: (one)

; prints :inline
```

<h4 id="block">:block</h4>

Blocks are a fundamental part of Arturo.

As we've already said, it's just a `[...]` (square-bracket enclosed) block of words/symbols/values that - in contrast with *inline* blocks above which are evaluated in-place - are <u>not evaluated</u> until it's necessary.

```arturo
myBlock: [one two three]
anArray: [1 2 3 4 5]
anotherArray: ["zero" 1 "two" 3 "cuatro"]
```

As you can see, blocks can contain practically anything: any word, any symbol, and any value. Of course, they can contain other blocks too:

```arturo
x: [
   1 2 [
       3 4 [
           5 "six" 7
       ] 
       8 
   ] 
   9
]
```

<h4 id="dictionary">:dictionary</h4>

Dictionaries in Arturo as what in other languages you'd call an *associative array* or *hash table*. In Arturo, it's practically the same, only with an added twist: they are *ordered* hash tables.
If you want to create one, just give the <code><a href="../library/collections/dictionary">dictionary</a></code> function (or use the `#` alias) a block, with different labels, and it'll automatically convert it to a dictionary.

```arturo
user: #[
     name: "John"
     surname: "Doe"
     age: 34
]
```

What the `#` function here does is:
- execute the block
- retrieve only the words/variables defined in there
- return a dictionary with the aforementioned words

> 💡 As you can probably assume from the above definition, a dictionary block doesn't necessarily have to contain just labels and word definitions - it may contain whatever you want, even function calls; only it will return you back just a table with the defined words in there

<h4 id="store">:store</h4>

Now, that you've seen Dictionaries, imagine a dictionary that could actually save its contents to disk for every change you make to it.
Or retrieve it from disk when you start your program again, offering you seamless integration with your data. And safety too.

Well, that's exactly what Stores are. :)

```arturo
d: store "mystore" ; initialize your Store and 
                   ; specify where you want to store it 
                   ; (if the store already exists, it'll automatically load it)

d\name: "John"     ; and you can use it as any normal dictionary
```

<h4 id="object">:object</h4>

Object values are intimately related to custom types, as we have already seen above.

And while Arturo isn't properly speaking a primarily Object-oriented language, it offers more than enough functionality that will cover most OOP needs.

The normal way to create a new object, is by using <code><a href="../library/types/to">to</a></code> and a new custom type you have defined before:

```arturo
newClient: to :person ["John" "Doe"]!
; yep, we've just created a new Object value!
```

Technically, Objects are nothing but supercharged Dictionaries that come with a twist:
their functions (see: methods) can have access to its own fields and methods, *from within* - using `this`. But other than that, don't let them scare you out: it's just another tool in our toolkit! ;-)

<h4 id="function">:function</h4>

Functions are another important value type in Arturo - and yes, you heard right: *functions* a *value* too. You can assign them to a word/variable, pass them around, re-define them and whatever you want with them, pretty much as you would do with another value, let's say a number.

To define a function, all you have to do is call the <code><a href="../library/core/function">function</a></code>... function (or use the `$` alias) followed by two parameters:
- the parameters' names (this can be either a literal, e.g. `'x` - if it's just one argument - or a block, e.g. `[x y]`. If you want to use commas, for readability, like `[x,y]` you are free to do so: Arturo will simply ignore them.

```arturo
multiply: function [x y][
     x * y
]

print multiply 2 3

; would print 6
```

or

```arturo
addThemUp: $[x,y][x+y]

print addThemUp 2 3

; would print 5
```

<h4 id="method">:method</h4>

Methods in Arturo are pretty much like functions. With a couple of asterisks:
- They are meant to be used only inside a custom type (in <code><a href="../library/types/define">define</a></code>) or in a <code><a href="../library/core/module">module</a></code> context
- We'd use them only when we want to have access to `this` (= in a few words, when we want to access other fields/functions/methods of the same object; if we don't need that, we could still use a function)

A quick example:

```arturo
define :car [
    init: method [; our constructor
        brand :string
        speed :quantity
    ][ 
        this\brand: brand
        this\speed: speed
    ]

    distanceTravelled: method [inHours :quantity][
        this\speed * inHours
    ]
]
myCar: to :car ["Volvo" 100`km/h]!

print ["In 2 hours, we'll have travelled:" myCar\distanceTravelled 2`h]
```

We may also have *magic methods*, that is: making our custom types accessible-to or "overloading" normal stdlib methods.

For example, if we want to be able to <code><a href="../library/io/print">print</a></code> one of our custom objects, we'd first have to define a way that this custom object is meant to be converted to a string.
For that, we'd define a `string` magic method:

```arturo
define :car [
    ; as previously

    string: method [][
        return "CAR :: " ++ \name
    ]
]
myCar: to :car ["Volvo C30" 100`km/h]!

print myCar ; this would print: CAR :: Volvo C30
```

**Supported Magic methods:**

```
get: method [what]          ; this\what
set: method [what, value]   ; this\what: value

changing: method []     ; object about to change
changed: method []      ; object changed

compare: method [that]  ; comparator definition (to compare between `this` and a second object)
equal?: method [that]   ; this = that
less?: method [that]    ; this < that
greater?: method [that] ; this > that

add: method [that]      ; this + that
sub: method [that]      ; this - that
mul: method [that]      ; this * that
div: method [that]      ; this / that
fdiv: method [that]     ; this // that
mod: method [that]      ; this % that
pow: method [that]      ; this ^ that

inc: method []          ; inc this
dec: method []          ; dec this

neg: method []          ; neg this

key?: method [key]          ; key? this key
contains?: method [field]   ; contains? this field

append: method [what]   ; this ++ what
remove: method [what]   ; this -- what

string: method []       ; to :string this
integer: method []      ; to :integer this
floating: method []     ; to :floating this
rational: method []     ; to :rational this
complex: method []      ; to :complex this
quantity: method []     ; to :quantity this
logical: method []      ; to :logical this
block: method []        ; to :block this
dictionary: method []   ; to :dictionary this
```

<h4 id="unit">:unit</h4>

Arturo has very advanced capabilities related to physical quantities, measurements and the related operations.

And everything begins with the concept of *units*.

To declare a Unit value, all you have to do is use a backtick, followed by the unit in question:

```arturo
Meters: `m 
SquareMeters: `m2
Becquerels: `Bq
```

The list of builtin, supported Units is quite... long:

```
m, s, K, g, A, mol, cd, USD, B, rad, sr, in, ft, yd, ftm, rod, mi, fur, nmi, ang, au, ly, px, pt, pc, sqin, sqft, ac, are, ha, barn, L, gal, bbl, qt, p, cup, floz, tbsp, tsp, bu, cord, min, h, day, wk, mo, yr, lb, slug, oz, ct, t, ton, lt, st, Da, gr, dwt, ozt, lbt, mps, kph, mph, kn, fps, mach, Gal, N, dyn, lbf, kgf, pdl, Pa, atm, bar, pz, Ba, mmHg, psi, Torr, J, Wh, cal, BTU, eV, erg, th, thm, W, hp, statA, abA, Bi, V, statV, abV, Ohm, statOhm, abOhm, S, C, statC, abC, Fr, F, Daraf, H, abH, Wb, Mx, T, G, degC, degF, degR, b, KiB, MiB, GiB, TiB, PiB, EiB, deg, grad, arcmin, arcsec, kat, Hz, Bq, Ci, Gy, Sv, R, P, St, rpm, clo, bps, lx, Lb, lm
```

We also support most world currencies, with their ISO 3-letter code, e.g. `USD`, `EUR`, etc.

**Compound units:**

If you want to define compound units, Arturo actually supports that natively:

```arturo
squareMeters: `m2
kilometersPerHours: `km/h

newtonDefinition: `kg.m/s2    ; yes, that's actually a N(ewton)
```

<h4 id="quantity">:quantity</h4>

Now, as we've seen, Arturo's Unit values are quite powerful. So, how can we express a Quantity using units?

Very simple: just add a number (a Rational literal works too) just in front of a unit:

```arturo
twoMeters: 2`m    ; yes, we've just expressed the notion of "2 meters"
                  ; as a native Arturo value
```

And we can obviously use them in operations as every other value:

```
print 3`m + 4`yd    ; 6.6576 m
```

And, yes, no need to worry about compatibility: Arturo actually understands dimensional analysis! ;-)

<h4 id="color">:color</h4>

Colors can be easily defined using the `#xxxxxx` syntax, where *xxxxxx* is either the RGB value of the color in hex, or its common-name alias, like `#red`, `#green` or `#blue`:

```arturo
color1: #red
color2: #0077BB

print color1 + color2
```

<h4 id="date">:date</h4>

Dates in Arturo are a distinct type of value. If you want to create one, you'll have to use one of the corresponding functions. For example, the function <code><a href="../library/dates/now">now</a></code> returns a `:date` object, representing the current point in time. And it can be handled pretty much like you would handle a `:dictionary`.

```arturo
print now

; would print 2020-10-26T10:27:14+01:00

print now\year

; would print 2020
```

<h4 id="database">:database</h4>

Database values cannot be constructed literally. However, using the function <code><a href="../library/databases/open">open</a></code>, you can create a database value and then use it to query the database in question and much more.

```arturo
db: open.sqlite "my.db"

print query db "SELECT * FROM users"

print type db   ; would print: :database
```

<h4 id="socket">:socket</h4>

Another not-literally constructible (but still powerful) value type is the Socket.

To use Socket values properly, just have a look into the Sockets library module.

If you want to create one, just have a look at the quick example below, using <code><a href="../library/sockets/listen">listen</a></code>:

```arturo
; start a server listening on port 18966
server: listen 18966    ; and, yes, that's a socket!
```

<h4 id="binary">:binary</h4>

Binary values are used to represent *binary* data, that is: an array of bytes. You cannot define them directly, however, you can sure convert other data to binary.

```arturo
print to :binary "Hello world!"

; would print 4865 6C6C 6F20 776F 726C 6421
```

<h4 id="bytecode">:bytecode</h4>

Bytecode values cannot be constructed literally. However, you can create them indirectly, e.g. using the function <code><a href="../library/types/to">to</a></code>.

```arturo
; let's create some Arturo bytecode from scratch 
bcode: to :bytecode [
    loop 1..10 'x [
        print x
    ]
]

; and execute it!
do bcode          

; we can also inspect it
inspect bcode
; [ :bytecode
;         ================================
;          DATA
;         ================================
;         0: [ :block
;                 print :word
;                 x :word
;         ]
;         1: x :literal
; 
;         ================================
;          CODE
;         ================================
;         push0
;         eol                  #4
;         push1
;         consti10
;         consti1
;         range
;         loop
;         end
; ]
```

<h2 id="important-concepts">Important concepts</h2>

Here we are going to analyze a few aspects that make Arturo rather unique; or that - in any case - you should study a bit more in order to become a real... Arturo guru, in no time.

So, let's get started...

<h3 id="precedence-and-evaluation">Precedence and Evaluation</h3>

The easiest way to explain precedence rules in Arturo is pretty much like it happened with our introduction: there are <u>no precedence rules</u> whatsoever.

So, in an expression like `2 * 3 + 4`, if you'd normally expect to get a result of `10`, you would be wrong: the result is `14`.

But in order to understand why, you'd have to understand how evaluation in Arturo works.

<h4 id="the-right-to-left-rule">The right-to-left rule</h4>

The main expression evaluation order of Arturo is *right-to-left*. But with a tiny asterisk: Your code *will* be evaluated from left to right, it is the expressions passed to your function calls that will be evaluated from right-to-left.

Let's take a very simple example:

```arturo
print add 1 2 
print "Done"
```

As you would expect, the first function to be executed is the first <code><a href="../library/io/print">print</a></code> function and then the second one. Nothing new here.

Now let's take the first <code><a href="../library/io/print">print</a></code>. How is it working?

Let's see:

- First, the value `2 ` is pushed onto the stack
- Then, we push the value `1  `
- Then, we execute the function <code><a href="../library/arithmetic/add">add</a></code>: it pops two values from the stack, adds them up, and pushes the result (`3`) back onto the stack
- Finally, we execute the function <code><a href="../library/io/print">print</a></code>: it pops the top value from the stack (`3`) and prints it.

Then, execution would move on and... `print "Done."`

What you have to understand here is that evaluation within an expression will *always* be done from right to left, irrespective of what you might know from other languages or math operator precedence. In Arturo, you have to learn <u>no precedence rules</u> at all. You'll just have to remember to always calculate from right to left.

Re-visiting our previous, seemingly paradoxical, example:

```arturo
2 * 3 + 4
```
> 💡 Remember: our `+` and `*` operators are nothing but simple *infix* aliases to the functions <code><a href="../library/arithmetic/add">add</a></code> and <code><a href="../library/arithmetic/mul">mul</a></code> respectively -- nothing more!

This is as if we had written (moving the operators in front):

```arturo
* 2 + 3 4
```

which practically means: FIRST add 3 and 4 and THEN take the result and multiply it with 2.

If this is not what intended, then the right way in Arturo would be, either:

```arturo
4 + 2 * 3
```

or (giving precedence to the multiplication, artificially, using parentheses): 

```arturo
(2 * 3) + 4
``` 

**Another example:**

Let's say we want to concatenate a number and a string into a new string.

```arturo
to :string 3 ++ " <-- this is our number"
```

The above example wouldn't work, because first it tries to concatenate `3` with a string (`" <-- this is our number`) and *then* performs `to :string`.
While what we actually want is to *first* convert our number to a string and *then* concatenate the two strings.

The correct code in that case would be:

```arturo
(to :string 3) ++ " <-- this is our number"
```

<h3 id="scope-and-rules">Scope and rules</h3>

Contrary to what you might expect, Arturo doesn't feature a traditional concept of *scope*. There are no real *local* or *global* variables, no *local* or *global* functions, no *local* or *global* blocks, no *local* or *global* anything.

Generally, if a variable has been previously declared at the moment and location of its usage, then it is available. Otherwise, it is not.

But let's see a couple of concrete cases to make this clearer.

<h4 id="blocks">Blocks</h4>

Arturo doesn't have a block scope.

In a few words, this means:

- A variable declared inside a block is available outside of it
- A variable previously declared outside of a block is available inside
- The changes of an existing variable, inside a block, persist after the block

```arturo
x: 1    ; here, we declare a variable x
        ; and set it to 1
do [
    x: 2      ; here, we re-assign the value of x
              ; to 2
    print x   ; prints 2
    y: 3      ; here, we declare a variable y
              ; and set it to 3
]
print x     ; prints 2 (the value of x has been changed)
print y     ; prints 3 (the value of y is still available)
```

<h4 id="iterators">Iterators</h4>

Iterators (such as <code><a href="../library/iterators/loop">loop</a></code>, <code><a href="../library/iterators/map">map</a></code>, etc) always work with a block as well. But in a special way.

Basically, the logic is identical to the one of blocks, but with a slight difference: 
- the *injected* variables (e.g. the iteration arguments), are available only inside the block, but not after the iteration is over
- any previous value is "protected" and restored if needed

```arturo
x: 3
loop.with:'i ["one" "two" "three"] 'x [
  print i  ; prints 0, 1, 2,...
  print x  ; prints "one", "two", "three",...
]
print x    ; prints 3 (the value of x has been restored)
print i    ; ERROR: variable not found 
           ; (i is not available anymore)
```

<h4 id="functions">Functions</h4>

Functions are totally different. Why? Because they do have their own scope.

The general idea is:

- A variable declared inside a function is available only inside the function
- A variable previously declared outside of a function is available inside
- The changes of an existing variable, inside a function, do not persist after the function

If we want to *export* a specific symbol to the outer scope, that is, make it available outside the function, we can use the `.export:` attribute.

If we want to export *all* of the symbols - thus, practically making the function *scope-less*, we may use the `.inline` attribute.

<h3 id="in-place-variable-modification">In-place variable modification</h3>

In Arturo, every time you pass a parameter to a function, you can rest assured that the value of that parameter won't change (unless it's a string, block or dictionary and you - consciously - decided to use <code><a href="../library/collections/set">set</a></code> on it, in which case it does alter its inner structure).

So, basically, you when do this...

```arturo
a: [1 5 2 4 3]
sort a
```

...all you do is to take an array, sort it, and push the sorted array onto the stack. Variable `a` simply does not change.

So, what would you do if you wanted to get the array back, but sorted?

The simple - and most obvious - way would be to re-assign the returned result from <code><a href="../library/collections/sort">sort</a></code>:

```arturo
a: [1 5 2 4 3]
a: sort a
```

And now, yes, `a` does contain the sorted version of the initial array.

But, what if you want to perform the modification in-place, which is normally faster and without the need for intermediate variables? Literals come to the rescue!

<h4 id="using-literals">Using literals</h4>

As we've already said, "literals" (`'i 'am 'a 'literal`) are nothing but string representations of a word, that is... the word itself. For that reason, they may come in very handy when you want to modify a variable in-place.

Let's revisit the above example and what the syntax of <code><a href="../library/collections/sort">sort</a></code> is:

```arturo
sort collection :literal :dictionary :block
```

As we can see, <code><a href="../library/collections/sort">sort</a></code> takes one parameter (*collection*) which is either a `:dictionary` or `:block` OR a `:literal`.

Why pass a literal? Simply because this turns in-place modification on! Let's have a look:

```arturo
a: [1 5 2 4 3]
sort 'a         ; yep, now a *has* been sorted in-place!
```

And this is *very powerful*: in Arturo, most of the built-in functions in the library come with this feature included. Practically, whenever you see a function taking a literal first parameter, that means you can use it for in-place modifying a variable (yes, even <code><a href="../library/arithmetic/add">add</a></code> works like that!).

> ⚠️ **Word of caution:**
> Values in Arturo are always passed by reference - unless they are constant/readonly values. So if you want to assign one variable to another and then modify one of them in-place, make sure you use <code><a href="../library/core/new">new</a></code>; otherwise, both values will change!
>
> ```arturo
> a: 1
> b: a
> inc 'a    ; both a and b are now 2
>
> c: 1      
> d: new c  ; we copy the value of c into d
> inc 'c    ; now c is 2 and d is 1, as expected
> ```

<h2 id="syntactic-sugar">Syntactic sugar</h2>

As you have hopefully seen so far, Arturo is rather simple, with fairly simple rules and that's pretty much it.

However, we also have some "syntactic sugar": a fancy way of referring to syntactic constructs, so that something more complicated will look better, or easier-to-write, or more readable.

Here you'll learn about some useful examples of *syntactic sugar* supported in Arturo.

<h3 id="right-arrow-operator">Right-arrow operator: `->`</h3>

The function of the right operator is rather straightforward: basically, it wraps the following *terminal* value inside a block.

Let's take a simple example.

```arturo
x: -> 2
```
This is 100% equivalent to:

```arturo
x: [2]
```

You can also use the right-arrow operator to make many common constructs far more readable.

For example:

```arturo
if x=2 -> print "x was 2!"
```
is the same as writing:

```arturo
if x=2 [ print "x was 2!" ]
```

As you can see, it can be pretty handy. Just remember that `->` can wrap only <u>one</u> *terminal* value.

For example:

```arturo
x: -> 2 3
```

This doesn't result in `x: [2 3]` but in `x: [2] 3`

Another interesting way of making use of the power of the *right-arrow operator*:

```arturo
loop 1..10 'x -> print x
```

which is the same as writing (only much more elegant):

```arturo
loop 1..10 'x [ print x ]
```

<h3 id="fat-right-arrow-operator">Fat right-arrow operator: `=>`</h3>

The fat right-arrow operator is like a super-charged *simple* right arrow operator (`->`) as described above.

If `->` was used to wrap the following terminal into a block, the `=>` operator does even more.

Let's take this simple example:

```arturo
x: $ => add
```

This is equivalent to writing:

```arturo
x: $[x,y][add x y]
```

Basically, it reads the following word, and if it's a function, pushes all its needed arguments as anonymous variables.

The same could work with a block argument, where `&` can be used as a placeholder for the needed anonymous variables:

```arturo
x: $ => [add & &]
```

(The first `&` will pop the first argument, and the second the next one - and so on...)

---

As you can already imagine, this is perfect for easily defining functions or action blocks that take exactly one parameter.

For example, to print an array of the even numbers between 1 and 10:

```arturo
print select 1..10 'x [even? x]
```

This could be easily written as (using the `->` operator):

```arturo
print select 1..10 'x -> even? x
```

But pushing the limits more, we can also use the `=>` operator:

```arturo
print select 1..10 => even?
```

That's surely much more readable, isn't it?

<h3 id="double-colon-operator">Double-colon operator: `::`</h3>

The *double-colon* operator does something very simple: it wraps everything in a block - until the end of... the current block:

```arturo
do [
    print :: 
        "This is a number:"
        123
]
```

Is equivalent to:

```arturo
do [
    print ["This is a number:" 123]
]
```

<h3 id="exclamation-mark-operator">Exclamation-mark operator: `!`</h3>

Explaining the *exclamation-mark* can be a bit tricky, but if you want the short version: 
it wraps everything that follows in a <code><a href="../library/core/do">do</a></code> block (more or less).

Or the shorter version:

- Have you just created a new custom-type object? (e.g. `to :myObject []`)?
- Have you imported an external package? (e.g. `import 'somePackage`)?

Then just put `!` at the end of the statement (e.g. `import 'somePackage!`) and everything will work as you expect.

**The long explanation:**

Arturo, when parsing a block of code, has to know which symbols correspond to function calls and how many arguments they take. The exact same is valid for object methods. 

When we create a new object (e.g. `p: to :person ["John"]`), if we attempt to use `p\someMethod` from the exact same block where this `p` value was initialized, there is no possible way to know beforehand that e.g. `someMethod` is a method. We'll know that only *after* `to :person ["John"]` has been executed. But then, it's already too late. So, how do we make sure that Arturo knows about the object before we attempt to call inner methods? By putting a "stopper" after the object creation, and that stopper is our beloved... `!`.

> 💡 Technically we could achieve the same thing without the `!` sugar:
> ```arturo
> p: to :person ["John"]
> do [
>     p\sayHello
> ]
> ```
> That would work too, for all practical purposes. But: `!` is looking good. And it's also far more performant, based on the way it's implemented internally! ;-)


<h3 id="pipe-operator">Pipe operator: `|`</h3>

> ⚠️ This is experimental and may still not be stable enough for use in production scripts

The *pipe* operator is an easy way of reversing the default *prefix* notation of function calls and simulating what in OOP languages is called *function chain*.

Let's take this simple example:

```arturo
1..10 | print
```

This equivalent to:

```arturo
print 1..10
```
Or a bit more elaborate example (using *pipes* and the `->`/`=>` operators):

```arturo
1..10 | map => [2 * &]
      | select 'x -> even? x
      | print
```

which would be like writing:

```arturo
print select map 1..10 'x [2*x] 'x [even? x] 
```

----

<h2 id="conclusion">Conclusion</h2>

If you made it here, then I can assure you: you've already learned more than you need in order to be fully proficient in Arturo.

Just head to the [Library Reference](../library/) and have a look at the built-in functions (with explanations and example code) and see what's already available for you or - if you want to see the language in action - just browse through the [Examples](../examples): there are many (many!) *working* examples, to get more than just an idea.

**Welcome on board! :)**
## Example program
This section is inspired by [Learn X in Y minutes](https://learnxinyminutes.com/) and its goal is to present the most basic features of Arturo, in a concise way, so that you can get started fast.

So... **With X = Arturo and Y = ~15 minutes**, here you are:

---

```arturo
; this is a comment
; this is another comment

;---------------------------------
; VARIABLES & VALUES
;---------------------------------

; numbers
a1: 2
a2: 3.14
a3: to :complex [1 2.0]     ; 1.0+2.0i

; strings
c1: "this is a string"
c2: {
    this is a multiline string
    that is indentation-agnostic
}
c3: {:
    this is 
        a verbatim
            multiline string
                which will remain exactly
                    as the original
:}

; characters
ch: 'c'

; blocks/arrays
d: [1 2 3]

; dictionaries
e: #[
    name: "John"
    surname: "Doe"
    age: 34
    likes: [pizza spaghetti]
]

; yes, functions are values too
f: function [x][
    2 * x
]

; colors - right, you can directly define them as well!
g1: #red
g2: #0077BF

; dates
h: now              ; 2021-05-03T17:10:48+02:00

; versions

currentVersion: 3.2.10-beta ; SemVer compatible :)

; logical values
i1: true
i2: false
i3: maybe

; units
meters: `m
kilograms: `kg

; quantities
height: 3`yd
width: 4`m

;---------------------------------
; BASIC OPERATORS
;---------------------------------

; simple arithmetic
1 + 1       ; => 2
8 - 1       ; => 7
4.2 - 1.1   ; => 3.1
10 * 2      ; => 20
35 / 4      ; => 8
35 // 4     ; => 8.75
2 ^ 5       ; => 32
5 % 3       ; => 2

; bitwise operators
and 3 5     ; => 1
or 3 5      ; => 7
xor 3 5     ; => 6

; pre-defined constants
pi          ; => 3.141592653589793
epsilon     ; => 2.718281828459045
null        ; => null
true        ; => true
false       ; => false

;---------------------------------
; COMPARISON OPERATORS
;---------------------------------

; equality
1 = 1       ; => true
2 = 1       ; => false

; inequality
1 <> 1      ; => false
2 <> 1      ; => true

; more comparisons
1 < 10      ; => true
1 =< 10     ; => true
10 =< 10    ; => true
1 > 10      ; => false
1 >= 10     ; => false
11 >= 10    ; => true

;---------------------------------
; CONDITIONALS
;---------------------------------

; logical operators
and? true true      ; => true
and? true false     ; => false
or? true false      ; => true
or? false false     ; => false

and? [1=2][2<3]     ; => false 
                    ; (the second block will not be evaluated)

; simple if statements
if 2 > 1 [ print "yes!"]    ; yes!
if 3 <> 2 -> print "true!"  ; true!

; switch statements
switch 2 > 3 -> print "2 is greater than 3"
             -> print "2 is not greater than 3" ; 2 is not greater than 3

a: (2 > 3)?["yes"]["no"]         ; a: "no"
a: (2 > 3)? -> "yes" -> "no"     ; a: "no" (exactly the same as above)

; case statements
key: "one"

case key [ ; the main block is always evaluated!
    "one"   -> print "key is one!"
    "two"   -> print "key is two!"
    any     -> print "key is none of the above"
]

; when statements
when [ ; the main block is always evaluated!
    prime? 4 -> print "yes, 4 is prime - wait, what?!"
    prime? 5 -> print "yes, 5 is prime
    prime? 7 -> print "yes, 6 is prime
    true     -> print "none of the above was true"
]
; yes, 5 is prime

when.any [ ; cascade-style checking (without breaking)
    prime? 4 -> print "yes, 4 is prime - wait, what?!"
    prime? 5 -> print "yes, 5 is prime"
    prime? 7 -> print "yes, 7 is prime"
]
; yes, 5 is prime
; yes, 7 is prime

x: 2
when.has: x [ ; prepends passed parameter to each block/condition
    [=0] -> print "x is zero!"
    [<1] -> print "x is less than 1"
    [<4] -> print "x is less than 4"
    true -> print "x is >= 4"
]
; x is less than 4

;---------------------------------
; LOOPS
;---------------------------------

; with `loop`
arr: [1 4 5 3]
loop arr 'x [
    print ["x =" x]
]
; x = 1
; x = 4
; x = 5
; x = 3

; with loop and custom index
loop.with:'i arr 'x [
    print ["item at position" i "=>" x]
]
; item at position 0 => 1
; item at position 1 => 4
; item at position 2 => 5
; item at position 3 => 3

; using ranges
loop 1..3 'x ->         ; since it's a single statement
    print x             ; there's no need for [block] notation
                        ; we can wrap it up using the `->` syntactic sugar

loop 'a'..'c' 'ch ->
    print ch
; a
; b
; c

; picking multiple items
loop 1..10 [x y] ->
    print ["x =" x ", y =" y]
; x = 1 , y = 2 
; x = 3 , y = 4 
; x = 5 , y = 6 
; x = 7 , y = 8 
; x = 9 , y = 10 

; looping through a dictionary
dict: #[name: "John", surname: "Doe", age: 34]
loop dict [key value][
    print [key "->" value]
]
; name -> John 
; surname -> Doe 
; age -> 34 
                    
; while loops
i: 0
while [i<3][
    print ["i =" i]
    inc 'i
]
; i = 0
; i = 1
; i = 2
 
;---------------------------------
; STRINGS
;---------------------------------

; case
a: "tHis Is a stRinG"
print upper a               ; THIS IS A STRING
print lower a               ; this is a string
print capitalize a          ; THis Is a stRinG

; concatenation
a: "Hello " ++ "World!"     ; a: "Hello World!"

; strings as an array
split "hello"               ; => [h e l l o]
split.words "hello world"   ; => [hello world]

print first "hello"         ; h
print last "hello"          ; o

; conversion
to :string 123              ; => "123"
to :integer "123"           ; => 123

; joining strings together
join ["hello" "world"]              ; => "helloworld"
join.with:"-" ["hello" "world"]     ; => "hello-world"

; string interpolation
x: 2
print ~"x = |x|"            ; x = 2

; interpolation with `print`
print ["x =" x]             ; x = 2
                            ; (`print` works by calculating the given block
                            ;  and joining the different values as strings
                            ;  with a single space between them)

; templates
print render.template {
    <||= switch x=2 [ ||>
        Yes, x = 2
    <||][||>
        No, x is not 2
    <||]||> 
} ; Yes, x = 2

; matching
prefix? "hello" "he"        ; => true
suffix? "hello" "he"        ; => false

contains? "hello" "ll"      ; => true
contains? "hello" "he"      ; => true
contains? "hello" "x"       ; => false

in? "ll" "hello"            ; => true 
in? "x" "hello"             ; => false

;---------------------------------
; BLOCKS
;---------------------------------

; calculate a block
arr: [1 1+1 1+1+1]
@arr                        ; => [1 2 3]

; execute a block
sth: [print "Hello world"]  ; this is perfectly valid,
                            ; could contain *anything*
                            ; and will not be executed...

do sth                      ; Hello world
                            ; (...until we tell it to)

; array indexing
arr: ["zero" "one" "two" "three"]
print first arr             ; zero
print arr\0                 ; zero
print last arr              ; three
print arr\3                 ; three

x: 2
print get arr x             ; two
print arr\[x]               ; two

; setting an array element
arr\0: "nada"
set arr 2 "dos"
print arr                   ; nada one dos three

z: 2
arr\[z]: "dos"              ; would have the same effect

; adding elements to an array
arr: []
'arr ++ "one"
'arr ++ "two"
print arr                   ; one two

; remove elements from an array
arr: ["one" "two" "three" "four"]
'arr -- "two"               ; arr: ["one" "three" "four"]
remove 'arr .index 0        ; arr: ["three" "four"]

; getting the size of an array
arr: ["one" 2 "three" 4]
print size arr              ; 4

; getting a slice of an array
print slice ["one" "two" "three" "four"] 0 1        ; one two

; check if array contains a specific element
print contains? arr "one"   ; true
print contains? arr "five"  ; false

; sorting array
arr: [1 5 3 2 4]
sort arr                    ; => [1 2 3 4 5]
sort.descending arr         ; => [5 4 3 2 1]

; mapping values
map 1..10 [x][2*x]          ; => [2 4 6 8 10 12 14 16 18 20]
map 1..10 'x -> 2*x         ; same as above
map 1..10 => [2 * &]        ; same as above
map 1..10 => [2*]           ; same as above

; selecting/filtering array values
select 1..10 [x][odd? x]    ; => [1 3 5 7 9]
select 1..10 => odd?        ; same as above

filter 1..10 => odd?        ; => [2 4 6 8 10]
                            ; (now, we leave out all odd numbers - 
                            ;  while select keeps them)

; misc operations
arr: ["one" 2 "three" 4]
reverse arr                 ; => [4 "three" 2 "one"]
shuffle arr                 ; => [2 4 "three" "one"]
unique [1 2 3 2 3 1]        ; => [1 2 3]
permutate [1 2 3]           ; => [[1 2 3] [1 3 2] [3 1 2] [2 1 3] [2 3 1] [3 2 1]]
take 1..10 3                ; => [1 2 3]
repeat [1 2] 3              ; => [1 2 1 2 1 2]

;---------------------------------
; FUNCTIONS
;---------------------------------

; declaring a function
f: function [x][ 2*x ]
f: function [x]-> 2*x       ; same as above
f: $[x]->2*x                ; same as above (only using the `$` alias 
                            ;  for the `function`... function)

; calling a function
f 10                        ; => 20

; returning a value
g: function [x][
    if x < 2 -> return 0

    res: 0
    loop 0..x 'z [
        res: res + z
    ]
    return res
]

;---------------------------------
; CUSTOM TYPES
;---------------------------------

; defining a custom type
define :person [
    ; define a new custom type "Person"
    ; with fields: name, surname, age
    init: method [name surname age][
        \name: capitalize name
        \surname: surname
        \age: age
    ]

    ; custom print function
    string: method [][
        render "NAME: |\name|, SURNAME: |\surname|, AGE: |\age|"
    ]

    ; custom comparison operator
    compare: sortable 'age
]

; create a method for our custom type
sayHello: function [this :person][
    print ["Hello" this\name]
]

; create new objects of our custom type
a: to :person ["John" "Doe" 34]!                ; let's create 2 "Person"s
b: to :person ["jane" "Doe" 33]!                ; and another one

; call pseudo-inner method
sayHello a                                      ; Hello John                       
sayHello b                                      ; Hello Jane

; access object fields
print ["The first person's name is:" a\name]    ; The first person's name is: John
print ["The second person's name is:" b\name]   ; The second person's name is: Jane

; changing object fields
a\name: "Bob"                                   
sayHello a                                      ; Hello Bob

; verifying object type
print type a                                    ; :person
print is? :person a                             ; true

; printing objects
print a                                         ; NAME: Bob, SURNAME: Doe, AGE: 34

; sorting user objects (using custom comparator)
print sort @[a b]                                     ; Jane..., Bob...
print sort.descending @[a b]                          ; Bob..., Jane...       
```
## Standard library
### Arithmetic
Basic arithmetic operations (addition, subtraction, multiplication, etc) for integers and floating-point numbers

----

The Arithmetic module provides basic mathematical operations that work seamlessly across different numeric types - integers, floating-point numbers, complex numbers, and rationals.

#### Key Concepts

- Operations work with multiple numeric types
- Support for in-place modifications
- Complex and rational number operations
- Automatic type promotion when needed
- All operators available as infix symbols

#### Basic Usage

##### Basic Operations

```arturo
; addition
print 2 + 3             ; 5
print add 2 3           ; 5

; subtraction
print 5 - 3             ; 2
print sub 5 3           ; 2

; multiplication
print 4 * 3             ; 12
print mul 4 3           ; 12

; division
print 10 / 3            ; 3 (integer division)
print 10 // 3           ; 3.333333333333333 (floating division)
print div 10 3          ; 3
print fdiv 10 3         ; 3.333333333333333
```

##### Working with Different Types

```arturo
; integer + floating
print 2 + 3.81          ; 5.81

; with complex numbers
z: to :complex [3 4]    ; 3.0+4.0i
print z + 2             ; 5.0+4.0i
print z * 3             ; 9.0+12.0i

; with rationals
a: 1:2                  ; 1/2
b: 3:4                  ; 3/4
print a + b             ; 5/4
```

##### In-place Modifications

```arturo
x: 5

; increment
inc 'x                   ; x is now 6
print x                  ; 6

; decrement
dec 'x                   ; x is now 5
print x                  ; 5

; other operations
add 'x 3                 ; x is now 8
mul 'x 2                 ; x is now 16
print x                  ; 16
```

> [!NOTE] Using literals (e.g., `'x`) performs operations in-place, modifying the original value.

#### Common Patterns

##### Division and Remainder

```arturo
; integer division with remainder
[quotient remainder]: divmod 17 5
print ["17 ÷ 5 =" quotient "remainder" remainder]    
; 17 ÷ 5 = 3 remainder 2

; floating division
print fdiv 17 5             ; 3.4
```

##### Working with Quantities

```arturo
distance: 100`m         ; 100 meters
time: 5`s               ; 5 seconds

speed: fdiv distance time
print speed             ; 20 m/s
```

##### Type Conversions & Promotions

```arturo
; integer → floating
a: 5 + 3.41             ; 8.41 (floating)
b: 2 * 3.5              ; 7.0 (floating)

; integer → rational
x: 3 + 1:2              ; 7/2 (rational)
y: 2 3:4                ; 3/2 (rational)

; integer → complex
z: 2 + to :complex [1 1]  
; 3.0+1.0i (complex)

; quantity +/- amount
q: 3`m + 10             ; 3 meters (quantity)     
r: 3`m - 2              ; 1 meter (quantity)

; quantity * times
s: 3`km * 3             ; 9 kilometers (quantity)
t: 3 * 3`km             ; 9 kilometers (quantity)

; quantity * quantity
u: 2`m * 3`m            ; 6 sq.meters (quantity)
```

> [!NOTE] When operating with different numeric types, Arturo automatically promotes to the most precise type needed.

----

#### `add` (alias: `+` - infix: true)
add given values and return result
##### Arguments
- `valueA` (:integer,:floating,:complex,:rational,:literal,:pathliteral,:quantity,:color,:object)
- `valueB` (:integer,:floating,:complex,:rational,:quantity,:color,:object)
##### Returns
:integer,:floating,:complex,:rational,:quantity,:color,:object,:nothing
#### `dec`
decrease given value by 1
##### Arguments
- `value` (:integer,:floating,:complex,:rational,:literal,:pathliteral,:quantity,:object)
##### Returns
:integer,:floating,:complex,:rational,:quantity,:object,:nothing
#### `div` (alias: `/` - infix: true)
perform integer division between given values and return result
##### Arguments
- `valueA` (:integer,:floating,:complex,:rational,:literal,:pathliteral,:quantity,:object)
- `valueB` (:integer,:floating,:complex,:rational,:quantity,:object)
##### Returns
:integer,:floating,:complex,:rational,:quantity,:object,:nothing
#### `divmod` (alias: `/%` - infix: true)
perform integer division between given values and return tuple with quotient and remainder
##### Arguments
- `valueA` (:integer,:floating,:complex,:rational,:literal,:pathliteral,:quantity)
- `valueB` (:integer,:floating,:complex,:rational,:quantity)
##### Returns
:block,:nothing
#### `fdiv` (alias: `//` - infix: true)
divide given values and return result
##### Arguments
- `valueA` (:integer,:floating,:rational,:literal,:pathliteral,:quantity,:object)
- `valueB` (:integer,:floating,:rational,:quantity)
##### Returns
:floating,:rational,:quantity,:object,:nothing
#### `inc`
increase given value by 1
##### Arguments
- `value` (:integer,:floating,:complex,:rational,:literal,:pathliteral,:quantity,:object)
##### Returns
:integer,:floating,:complex,:rational,:quantity,:object,:nothing
#### `mod` (alias: `%` - infix: true)
calculate the modulo of given values and return result
##### Arguments
- `valueA` (:integer,:floating,:rational,:literal,:pathliteral,:quantity,:object)
- `valueB` (:integer,:floating,:rational,:quantity)
##### Returns
:integer,:floating,:rational,:quantity,:object,:nothing
#### `mul` (alias: `*` - infix: true)
calculate the product of given values and return result
##### Arguments
- `valueA` (:integer,:floating,:complex,:rational,:literal,:pathliteral,:quantity,:object)
- `valueB` (:integer,:floating,:complex,:rational,:quantity,:object)
##### Returns
:integer,:floating,:complex,:rational,:quantity,:object,:nothing
#### `neg`
reverse sign of given value and return it
##### Arguments
- `value` (:integer,:floating,:complex,:rational,:literal,:pathliteral,:quantity,:object)
##### Returns
:integer,:floating,:complex,:rational,:quantity,:object,:nothing
#### `pow` (alias: `^` - infix: true)
calculate the power of given values and return result
##### Arguments
- `valueA` (:integer,:floating,:complex,:rational,:literal,:pathliteral,:quantity,:object)
- `valueB` (:integer,:floating)
##### Returns
:integer,:floating,:complex,:rational,:quantity,:object,:nothing
#### `sub` (alias: `-` - infix: true)
subtract given values and return result
##### Arguments
- `valueA` (:integer,:floating,:complex,:rational,:literal,:pathliteral,:quantity,:color,:object)
- `valueB` (:integer,:floating,:complex,:rational,:quantity,:color,:object)
##### Returns
:integer,:floating,:complex,:rational,:quantity,:color,:object,:nothing
### Bitwise
Bit manipulation methods & bitwise operators (AND, OR, XOR, etc) for integer values

----

The Bitwise module provides functions for bit-level operations on integer values, including basic boolean operations and bit shifting.

#### Key Concepts

- Bitwise boolean operations (AND, OR, XOR, etc.)
- Bit shifting operations
- Works with integer values
- Results are always integers

#### Basic Usage

##### Boolean Operations

```arturo
x: 5    ; binary: 101
y: 3    ; binary: 011

and x y       ; => 1  (001)
or x y        ; => 7  (111)
xor x y       ; => 6  (110)

; complement
not x         ; => -6 (complement of 101)
```

##### Advanced Operations

```arturo
a: 12   ; binary: 1100
b: 9    ; binary: 1001

nand a b      ; => -9
nor a b       ; => -14
xnor a b      ; => -6
```

##### Bit Shifting

```arturo
num: 8   ; binary: 1000

; left shift (multiply by 2^n)
print shl num 2     ; 32 (100000)

; right shift (divide by 2^n)
print shr num 1     ; 4  (100)
```

> [!NOTE] Shift operations are equivalent to multiplication or division by powers of 2.

#### Common Patterns

##### Checking Individual Bits

```arturo
value: 42          ; binary: 101010
mask: shl 1 3      ; binary: 001000

if and value mask -> 
    print "Bit 3 is set"
```

##### Setting and Clearing Bits

```arturo
number: 10         ; binary: 1010
pos: 2

; set bit
number: or number shl 1 pos
print ["After setting:" number]    ; After setting: 14 (1110)

; clear bit
number: and number not shl 1 pos
print ["After clearing:" number]   ; After clearing: 10 (1010)
```

----

#### `and`
calculate the binary AND for the given values
##### Arguments
- `valueA` (:integer,:literal,:pathliteral,:binary)
- `valueB` (:integer,:binary)
##### Returns
:integer,:binary,:nothing
#### `nand`
calculate the binary NAND for the given values
##### Arguments
- `valueA` (:integer,:literal,:pathliteral,:binary)
- `valueB` (:integer,:binary)
##### Returns
:integer,:binary,:nothing
#### `nor`
calculate the binary NOR for the given values
##### Arguments
- `valueA` (:integer,:literal,:pathliteral,:binary)
- `valueB` (:integer,:binary)
##### Returns
:integer,:binary,:nothing
#### `not`
calculate the binary complement the given value
##### Arguments
- `value` (:integer,:literal,:pathliteral,:binary)
##### Returns
:integer,:binary,:nothing
#### `or`
calculate the binary OR for the given values
##### Arguments
- `valueA` (:integer,:literal,:pathliteral,:binary)
- `valueB` (:integer,:binary)
##### Returns
:integer,:binary,:nothing
#### `shl`
shift-left first value bits by second value
##### Arguments
- `value` (:integer,:literal,:pathliteral)
- `bits` (:integer)
##### Options
- `safe` (:logical): check for overflows
##### Returns
:integer,:nothing
#### `shr`
shift-right first value bits by second value
##### Arguments
- `value` (:integer,:literal,:pathliteral)
- `bits` (:integer)
##### Returns
:integer,:nothing
#### `xnor`
calculate the binary XNOR for the given values
##### Arguments
- `valueA` (:integer,:literal,:pathliteral,:binary)
- `valueB` (:integer,:binary)
##### Returns
:integer,:binary,:nothing
#### `xor`
calculate the binary XOR for the given values
##### Arguments
- `valueA` (:integer,:literal,:pathliteral,:binary)
- `valueB` (:integer,:binary)
##### Returns
:integer,:binary,:nothing
### Collections
Functions and helpers for manipulating and dealing with different types of collections (blocks, dictionaries, and strings)

----

The Collections module provides a unified interface for working with different types of collections: blocks, dictionaries, and strings. Most operations work seamlessly across all collection types, making it easy to manipulate data regardless of its structure.

#### Key Concepts

- Unified operations across blocks, dictionaries, and strings
- Support for both mutable and immutable operations
- Efficient array/block manipulation
- Ordered dictionary operations
- Lazy evaluation with ranges
- Flexible combination and permutation generation

#### Basic Usage

##### Creating Collections

```arturo
; blocks (arrays)
numbers: [1 2 3 4 5]
mixed: ["hello" 42 true]

; dictionaries (ordered hash tables)
user: #[
    name: "John"
    age: 30
    city: "London"
]

; ranges (lazy collections)
evens: 2..10

; use `@` (or `array`) to "evaluate" a range
print @evens     ; 2 3 4 5 6 7 8 9 10
```

> [!NOTE] Dictionaries in Arturo maintain insertion order, unlike hash tables in many other languages.

##### Basic Operations

```arturo
lst: [1 2 3]

; adding/removing elements
'lst ++ 4           ; append
'lst -- 2           ; remove value
'lst ++ [5 6]       ; extend

print lst           ; 1 3 4 5 6

; accessing elements
print first lst     ; 1
print last lst      ; 6

; accessing the element at index: 2
; (= the third element in our list)
print lst\2         ; 4
```

> [!IMPORTANT] Using the literal form (e.g., `'lst`) modifies the collection in place, while using the value directly returns a new collection.

##### Collection Indexing

```arturo
; basic array indexing
colors: ["red" "green" "blue"]
print colors\0              ; red (first element)
print colors\2              ; blue (last element)

; dynamic indexing with expressions
pos: 1
print colors\[pos]          ; green

; dictionary field access
user: #[
    name: "John"
    surname: "Doe"
    age: 30
]

print user\name             ; John

; dynamic dictionary field access
field: 'surname             ; using a literal
print user\[field]          ; Doe
```

> [!NOTE] Indexing with `\` works uniformly across all collection types. Use a block after `\` when you need to evaluate an expression to get the index or field name.

##### Collection Information

```arturo
data: [1 2 2 3 3 3]

size data           ; => 6
empty? data         ; => false
contains? data 2    ; => true
index data 3        ; => 2
```

#### Common Patterns

##### Collection Transformation

```arturo
; flatten nested structure
nested: [[1 2] [3 4] [5 6]]
flat: flatten nested
; [1 2 3 4 5 6]

; unique elements
duplicates: [1 2 2 3 3 3]
print unique duplicates     ; 1 2 3

; reversing
print reverse [1 2 3]       ; 3 2 1
```

##### Working with Dictionaries

```arturo
user: #[
    name: "John"
    age: 30
]

; accessing data
keys user     ; => ["name" "age"]
values user   ; => ["John" 30]

; extending
additional: #[
    city: "London"
    job: "Developer"
]
complete: extend user additional
print complete
; [name:John age:30 city:London job:Developer]
```

##### Working with Strings

```arturo
text: "Hello 世界"      ; unicode string

; strings are like character arrays
print text\0           ; H
print text\4           ; o
print text\5           ; [space]
print text\6           ; 世

; get size (in characters, not bytes)
print size text        ; 8

; iterate through characters
loop text 'c ->
    print ["char:" c]
; char: H 
; char: e 
; char: l 
; char: l 
; char: o 
; char:   
; char: 世 
; char: 界
```

> [!NOTE] Strings in Arturo are always Unicode-aware. When indexing or iterating, you're working with actual characters, not bytes.

##### Combinations & Permutations

```arturo
items: [1 2 3]

; specific size combinations
combine.by:2 items 
; => [[1 2] [1 3] [2 3]]

; permutations
permutate items    
; => [[1 2 3] [1 3 2] [2 1 3] [2 3 1] [3 1 2] [3 2 1]]
```

> [!TIP] Use the `.repeated` attribute with `combine` or `permutate` when you want to allow elements to be used multiple times.

##### Efficient Range Operations

```arturo
; create a range of numbers
nums: 1..1000

; work with it without generating all values
first nums          ; => 1
last nums           ; => 1000
nums\42             ; => 42
```

> [!NOTE] Ranges are lazy - they don't generate all values until needed, making them very memory-efficient for large sequences.

##### Advanced Examples

###### Working with Nested Data

```arturo
users: #[
    active: @[
        #[name: "John" score: 42 tags: ["admin" "dev"]]
        #[name: "Alice" score: 28 tags: ["dev"]]
        #[name: "Bob" score: 35 tags: ["admin"]]
    ]
    inactive: @[
        #[name: "Eve" score: 15 tags: ["guest"]]
    ]
]

; find all admins with scores > 30
admins: select users\active 'user -> 
    and? [contains? user\tags "admin"]
         [user\score > 40]

print map admins 'usr -> 
    usr\name     
; John

; get unique tags across all users
allTags: unique flatten map users\active 'usr -> usr\tags    
; admin dev
```

###### Managing a Priority Queue

```arturo
tasks: []

; add tasks with priorities
'tasks ++ #[priority: 3 task: "Low priority"]
'tasks ++ #[priority: 1 task: "Urgent!"]
'tasks ++ #[priority: 2 task: "Important"]

; sort by priority
sorted: arrange tasks 'item -> item\priority
loop sorted 'item ->
    print [item\priority ":" item\task]
; 1 : Urgent!
; 2 : Important
; 3 : Low priority
```

----

#### `append` (alias: `++` - infix: true)
append value to given collection
##### Arguments
- `collection` (:char,:string,:literal,:pathliteral,:binary,:object,:block)
- `value` (:any)
##### Returns
:string,:binary,:object,:block,:nothing
#### `array` (alias: `@` - infix: false)
create array from given block, by reducing/calculating all internal values
##### Arguments
- `source` (:any)
##### Options
- `of` (:integer,:block): initialize an empty n-dimensional array with given dimensions
##### Returns
:block
#### `chop`
remove last item from given collection
##### Arguments
- `collection` (:string,:literal,:pathliteral,:block)
##### Options
- `times` (:integer): remove multiple items
##### Returns
:string,:block,:nothing
#### `combine`
get all possible combinations of the elements in given collection
##### Arguments
- `collection` (:block)
##### Options
- `by` (:integer): define size of each set
- `repeated` (:logical): allow for combinations with repeated elements
- `count` (:logical): just count the number of combinations
##### Returns
:integer,:block
#### `contains?`
check if collection contains given value
##### Arguments
- `collection` (:string,:dictionary,:object,:block,:range)
- `value` (:any)
##### Options
- `at` (:integer): check at given location within collection
- `deep` (:logical): searches recursively in deep for a value.
##### Returns
:logical
#### `couple`
get combination of elements in given collections as array of tuples
##### Arguments
- `collectionA` (:block)
- `collectionB` (:block)
##### Returns
:block
#### `decouple`
get tuple of collections from a coupled collection of tuples
##### Arguments
- `collection` (:literal,:pathliteral,:block)
##### Returns
:block
#### `dictionary` (alias: `#` - infix: false)
create dictionary from given block or file, by getting all internal symbols
##### Arguments
- `source` (:string,:block)
##### Options
- `with` (:block): embed given symbols
- `raw` (:logical): create dictionary from raw block
- `lower` (:logical): automatically convert all keys to lowercase
##### Returns
:dictionary
#### `drop`
remove first item from given collection
##### Arguments
- `collection` (:string,:literal,:pathliteral,:block)
##### Options
- `times` (:integer): remove multiple items
##### Returns
:string,:block,:nothing
#### `empty`
empty given collection
##### Arguments
- `collection` (:literal,:pathliteral)
##### Returns
:nothing
#### `empty?`
check if given collection is empty
##### Arguments
- `collection` (:null,:string,:dictionary,:block)
##### Returns
:logical
#### `extend`
get new dictionary by merging given ones
##### Arguments
- `parent` (:literal,:pathliteral,:dictionary)
- `additional` (:dictionary)
##### Returns
:dictionary
#### `first`
return the first item of the given collection
##### Arguments
- `collection` (:string,:block,:range)
##### Options
- `n` (:integer): get first *n* items
##### Returns
:null,:any
#### `flatten`
flatten given collection by eliminating nested blocks
##### Arguments
- `collection` (:literal,:pathliteral,:block)
##### Options
- `once` (:logical): do not perform recursive flattening
##### Returns
:block
#### `get`
get collection's item by given index
##### Arguments
- `collection` (:complex,:string,:error,:errorkind,:date,:binary,:dictionary,:object,:store,:block,:range,:bytecode)
- `index` (:any)
##### Options
- `safe` (:logical): get value, overriding potential magic methods (only for Object values)
##### Returns
:any
#### `in?` (alias: `∈` - infix: true)
check if value exists in given collection
##### Arguments
- `value` (:any)
- `collection` (:string,:dictionary,:object,:block,:range)
##### Options
- `at` (:integer): check at given location within collection
- `deep` (:logical): searches recursively in deep for a value.
##### Returns
:logical
#### `index`
return first index of value in given collection
##### Arguments
- `collection` (:string,:dictionary,:block,:range)
- `value` (:any)
##### Returns
:null,:integer,:string
#### `insert`
insert value in collection at given index
##### Arguments
- `collection` (:string,:literal,:pathliteral,:dictionary,:block)
- `index` (:integer,:string)
- `value` (:any)
##### Returns
:string,:dictionary,:block,:nothing
#### `key?`
check if collection contains given key
##### Arguments
- `collection` (:dictionary,:object)
- `key` (:any)
##### Returns
:logical
#### `keys`
get list of keys for given collection
##### Arguments
- `dictionary` (:dictionary,:object)
##### Returns
:block
#### `last`
return the last item of the given collection
##### Arguments
- `collection` (:string,:block,:range)
##### Options
- `n` (:integer): get last *n* items
##### Returns
:null,:any
#### `max`
get maximum element in given collection
##### Arguments
- `collection` (:block,:range)
##### Options
- `index` (:logical): retrieve index of maximum element
##### Returns
:null,:any
#### `min`
get minimum element in given collection
##### Arguments
- `collection` (:block,:range)
##### Options
- `index` (:logical): retrieve index of minimum element
##### Returns
:null,:any
#### `one?`
check if given number or collection size is one
##### Arguments
- `number` (:null,:integer,:floating,:string,:dictionary,:block,:range)
##### Returns
:logical
#### `permutate`
get all possible permutations of the elements in given collection
##### Arguments
- `collection` (:block)
##### Options
- `by` (:integer): define size of each set
- `repeated` (:logical): allow for permutations with repeated elements
- `count` (:logical): just count the number of permutations
##### Returns
:block
#### `pop`
remove and return the last item from given collection
##### Arguments
- `collection` (:literal,:pathliteral)
##### Options
- `n` (:integer): remove multiple items. (Must be greater than 0.)
##### Returns
:any
#### `prepend`
prepend value to given collection
##### Arguments
- `collection` (:char,:string,:literal,:pathliteral,:binary,:block)
- `value` (:any)
##### Returns
:string,:binary,:block,:nothing
#### `range` (alias: `..` - infix: true)
get list of values in given range (inclusive)
##### Arguments
- `from` (:integer,:char)
- `to` (:integer,:floating,:char)
##### Options
- `step` (:integer): use step between range values
##### Returns
:range
#### `remove` (alias: `--` - infix: true)
remove value from given collection
##### Arguments
- `collection` (:string,:literal,:pathliteral,:dictionary,:object,:block)
- `value` (:any)
##### Options
- `key` (:logical): remove dictionary key
- `once` (:logical): remove only first occurence
- `index` (:logical): remove specific index
- `prefix` (:logical): remove first matching prefix from string
- `suffix` (:logical): remove first matching suffix from string
- `instance` (:logical): remove an instance of a block, instead of its elements.
##### Returns
:string,:dictionary,:block,:nothing
#### `repeat`
repeat value the given number of times and return new one
##### Arguments
- `value` (:literal,:pathliteral,:any)
- `times` (:integer)
##### Returns
:string,:block
#### `reverse`
reverse given collection
##### Arguments
- `collection` (:string,:literal,:pathliteral,:block,:range)
##### Options
- `exact` (:logical): make sure the reverse range contains the same elements
##### Returns
:string,:block,:nothing
#### `rotate`
right-rotate collection by given distance
##### Arguments
- `collection` (:string,:literal,:pathliteral,:block)
- `distance` (:integer)
##### Options
- `left` (:logical): left rotation
##### Returns
:string,:block,:nothing
#### `sample`
get a random element from given collection
##### Arguments
- `collection` (:block,:range)
##### Returns
:null,:any
#### `set`
set collection's item at index to given value
##### Arguments
- `collection` (:string,:binary,:dictionary,:object,:store,:block,:bytecode)
- `index` (:any)
- `value` (:any)
##### Options
- `safe` (:logical): set value, overriding potential magic methods (only for Object values)
##### Returns
:nothing
#### `shuffle`
get given collection shuffled
##### Arguments
- `collection` (:literal,:pathliteral,:block)
##### Returns
:block,:nothing
#### `size`
get size/length of given collection
##### Arguments
- `collection` (:null,:string,:binary,:dictionary,:object,:block,:range)
##### Returns
:integer,:floating
#### `slice`
get a slice of collection between given indices
##### Arguments
- `collection` (:string,:literal,:pathliteral,:block)
- `from` (:integer)
- `to` (:integer)
##### Returns
:string,:block
#### `sort`
sort given block in ascending order
##### Arguments
- `collection` (:literal,:pathliteral,:dictionary,:block)
##### Options
- `as` (:literal): localized by ISO 639-1 language code
- `sensitive` (:logical): case-sensitive sorting
- `descending` (:logical): sort in descending order
- `values` (:logical): sort dictionary by values
- `by` (:string,:literal): sort array of dictionaries by given key
##### Returns
:block,:nothing
#### `sorted?`
check if given collection is already sorted
##### Arguments
- `collection` (:block)
##### Options
- `descending` (:logical): check for sorting in ascending order
##### Returns
:logical
#### `split`
split collection to components
##### Arguments
- `collection` (:string,:literal,:pathliteral,:block)
##### Options
- `words` (:logical): split string by whitespace
- `lines` (:logical): split string by lines
- `by` (:string,:regex,:block): split using given separator
- `at` (:integer): split collection at given position
- `every` (:integer): split collection every *n* elements
- `path` (:logical): split path components in string
##### Returns
:block,:nothing
#### `squeeze`
reduce adjacent elements in given collection
##### Arguments
- `collection` (:string,:literal,:pathliteral,:block)
##### Returns
:string,:block,:nothing
#### `take`
keep first <number> of elements from given collection and return the remaining ones
##### Arguments
- `collection` (:string,:literal,:pathliteral,:block,:range)
- `number` (:integer)
##### Returns
:string,:block,:nothing
#### `tally`
find number of occurences of each value within given block and return as dictionary
##### Arguments
- `collection` (:string,:block)
##### Returns
:dictionary
#### `unique`
get given collection without duplicates
##### Arguments
- `collection` (:string,:literal,:pathliteral,:block)
##### Options
- `id` (:logical): generate unique id using given prefix
##### Returns
:block,:nothing
#### `values`
get list of values for given collection
##### Arguments
- `dictionary` (:dictionary,:object,:block,:range)
##### Returns
:block
#### `zero?`
check if given number or collection size is zero
##### Arguments
- `number` (:null,:integer,:floating,:string,:dictionary,:block,:range)
##### Returns
:logical
### Colors
Functions and helpers for manipulating color values

----

The Colors module provides comprehensive color handling capabilities. It includes support for RGB colors, color manipulations, and a rich set of predefined color names.

#### Key Concepts

- RGB color representation
- Color manipulation (blending, saturation, etc.)
- Support for alpha channel
- Over 350 predefined color names
- Color space conversions (RGB, HSL, HSV)

#### Basic Usage

##### Creating Colors

```arturo
; using hex notation
color1: #f00            ; short RGB
color2: #ff0000         ; full RGB
color3: #ff0000ff       ; RGB with alpha

; using predefined colors
red: #red
azure: #azure
deepPurple: #deepPurple

; extracting components
extract.red #ff0000      ; => 255
extract.green #00ff00    ; => 255
extract.blue #0000ff     ; => 255
extract.alpha #ff0000ff  ; => 255
```

##### Color Operations

```arturo
; lighten/darken
dark: darken #red 0.3          ; 30% darker (= #B20000)
light: lighten #emerald 0.2    ; 20% lighter (= #60F090)

; saturation
more: saturate #green 0.4      ; 40% more saturated (= #008000)
less: desaturate #green 0.4    ; 40% less saturated (= #1A661A)

; blending
mixed: blend #red #blue                     ; 50-50 mix (= #800080)
customMix: blend.balance:0.7 #red #blue     ; 70-30 mix (= #4D00B3)

; invert colors
opposite: invert #white        ; #black
```

##### Color Space Conversions

```arturo
col: #magenta       ; #FF00FF

; get HSL representation
hsl: extract.hsl col        ; #[hue:300 saturation:1.0 luminosity:0.5]

; get HSV representation
hsv: extract.hsv col        ; #[hue:300 saturation:1.0 value:1.0]

; create the same color
; starting from its HSV representation
newColor: to :color .hsv [300, 1.0 1.0]     ; #FF00FF (yep, #magenta!)
```

##### Color Palettes

```arturo
baseColor: #4169e1          ; royal blue

; generate different palettes
print palette.triad baseColor
; #4169E1 #E14169 #69E141 

print palette.tetrad baseColor
; #4169E1 #E141B9 #E1B941 #41E169 

print palette.split baseColor
; #4169E1 #D941E1 #A9E141

print palette.analogous baseColor
; #41C9E1 #41A9E1 #4189E1 #4169E1 #4149E1 #5941E1
```

#### Predefined Colors

> [!NOTE] Colors can be referenced using their names in various formats. For example, `deep sea blue` can be written as `#deepSeaBlue`, `#deepsea` or even just `#deep`.

Here are some of the most commonly used colors organized by hue:

##### Reds
- `#red`, `#crimson`, `#darkRed`, `#fireEngineRed`, `#cherryRed`
- `#ruby`, `#burgundy`, `#bloodRed`, `#lavaRed`

##### Blues
- `#blue`, `#navy`, `#royalBlue`, `#skyBlue`, `#azureBlue`
- `#cobaltBlue`, `#cornflowerBlue`, `#denimBlue`, `#deepSeaBlue`

##### Greens
- `#green`, `#emerald`, `#forestGreen`, `#limeGreen`, `#seaGreen`
- `#oliveGreen`, `#sageGreen`, `#mintGreen`, `#jade`

##### Purples
- `#purple`, `#violet`, `#plum`, `#lavender`, `#mauve`
- `#orchid`, `#royalPurple`, `#deepPurple`, `#amethyst`

##### Yellows & Oranges
- `#yellow`, `#gold`, `#amber`, `#mustard`, `#canary`
- `#orange`, `#tangerine`, `#coral`, `#peach`

##### Neutrals
- `#white`, `#black`, `#gray`, `#silver`
- `#beige`, `#tan`, `#brown`, `#taupe`

> [!TIP] The complete list of colors can be found in the [Arturo repository](https://github.com/arturo-lang/arturo/blob/master/src/vm/values/custom/vcolor.nim#L41-L618), although it would be most likely safe to say that any [W3C color name recognized](https://www.w3schools.com/tags/ref_colornames.asp) is also recognized by Arturo too.

#### Common Patterns

##### Working with Alpha

```arturo
; full opacity
solid: #ff0000ff      ; red, 100% opaque

; semi-transparent
trans: #ff000080      ; red, 50% transparent
```

----

#### `blend`
blend given colors and get result
##### Arguments
- `colorA` (:literal,:pathliteral,:color)
- `colorB` (:color)
##### Options
- `balance` (:floating): use different mix of color (0.0-1.0, default:0.5)
##### Returns
:color
#### `darken`
darken color by given percentage (0.0-1.0)
##### Arguments
- `color` (:literal,:pathliteral,:color)
- `percent` (:floating)
##### Returns
:color
#### `desaturate`
desaturate color by given percentage (0.0-1.0)
##### Arguments
- `color` (:literal,:pathliteral,:color)
- `percent` (:floating)
##### Returns
:color
#### `grayscale`
convert color to grayscale
##### Arguments
- `color` (:literal,:pathliteral,:color)
##### Returns
:color
#### `invert`
get complement for given color
##### Arguments
- `color` (:literal,:pathliteral,:color)
##### Returns
:color
#### `lighten`
lighten color by given percentage (0.0-1.0)
##### Arguments
- `color` (:literal,:pathliteral,:color)
- `percent` (:floating)
##### Returns
:color
#### `palette`
create palette using given base color
##### Arguments
- `color` (:color)
##### Options
- `triad` (:logical): generate a triad palette
- `tetrad` (:logical): generate a tetrad palette
- `split` (:logical): generate a split complement palette
- `analogous` (:logical): generate an analogous palette
- `monochrome` (:logical): generate a monochromatic palette
- `random` (:logical): generate random palette based on color triads
- `size` (:integer): specify the size of the generated palette
##### Returns
:block
#### `saturate`
saturate color by given percentage (0.0-1.0)
##### Arguments
- `color` (:literal,:pathliteral,:color)
- `percent` (:floating)
##### Returns
:color
#### `spin`
spin color around the hue wheel by given amount
##### Arguments
- `color` (:literal,:pathliteral,:color)
- `amount` (:integer)
##### Returns
:color
### Comparison
Comparison operations for any kind of value

----

The Comparison module provides functions for comparing values of any type. Beyond basic equality checks, it includes ordering operations and advanced comparison features.

#### Key Concepts

- Works with all value types
- Consistent behavior across different types
- Support for both equality and ordering
- Range checking with `between?`

#### Basic Usage

##### Simple Comparisons

```arturo
; equality
print 2 = 2              ; true
print "abc" = "abc"      ; true
print 2 = "2"            ; false

; inequality
print 2 <> 3             ; true
print "abc" <> "def"     ; true
print 2.0 <> 2           ; false
```

##### Ordering

```arturo
; less/greater than
print 2 < 3              ; true
print 3 > 2              ; true

; less/greater or equal
print 2 =< 2             ; true
print 3 >= 2             ; true
```

> [!NOTE] The ordering operators work with numbers, strings, dates, and any type that defines ordering.

##### Range Checking

```arturo
; check if value is in range (inclusive)
5 <=> 1 10              ; => true
'm' <=> 'a' 'z'         ; => true

; or more explicitly
between? 5 1 10         ; => true
```

> [!TIP] Another way to check if a value is within a given range would be `contains?` - or its reversed equivalent - `in?`.

#### Common Patterns

##### Custom Sorting

The `compare` function returns -1, 0, or 1 and is useful for custom sorting:

```arturo
a: "hello"
b: "world"

result: compare a b        ; -1
print ["A comes" (result < 0)? -> "before" -> "after" "B"]   
; A comes before B
```

##### Identity vs Equality

```arturo
x: 1`N
y: 1`kg.m/s2    ; actually, that's the definition of 1 Newton!

; equality (same value)
print x = y             ; true

; identity (exactly the same?)
print same? x y         ; false
```

----

#### `between?` (alias: `<=>` - infix: true)
check if given value is between the given values (inclusive)
##### Arguments
- `value` (:any)
- `rangeFrom` (:any)
- `rangeTo` (:any)
##### Returns
:logical
#### `compare`
compare given values and return -1, 0, or 1 based on the result
##### Arguments
- `valueA` (:any)
- `valueB` (:any)
##### Returns
:integer
#### `equal?` (alias: `=` - infix: true)
check if valueA = valueB (equality)
##### Arguments
- `valueA` (:any)
- `valueB` (:any)
##### Returns
:logical
#### `greater?` (alias: `>` - infix: true)
check if valueA > valueB (greater than)
##### Arguments
- `valueA` (:any)
- `valueB` (:any)
##### Returns
:logical
#### `greaterOrEqual?` (alias: `>=` - infix: true)
check if valueA >= valueB (greater than or equal)
##### Arguments
- `valueA` (:any)
- `valueB` (:any)
##### Returns
:logical
#### `less?` (alias: `<` - infix: true)
check if valueA < valueB (less than)
##### Arguments
- `valueA` (:any)
- `valueB` (:any)
##### Returns
:logical
#### `lessOrEqual?` (alias: `=<` - infix: true)
check if valueA =< valueB (less than or equal)
##### Arguments
- `valueA` (:any)
- `valueB` (:any)
##### Returns
:logical
#### `notEqual?` (alias: `<>` - infix: true)
check if valueA <> valueB (not equal)
##### Arguments
- `valueA` (:any)
- `valueB` (:any)
##### Returns
:logical
#### `same?`
check if given values are exactly the same (identity)
##### Arguments
- `valueA` (:any)
- `valueB` (:any)
##### Returns
:logical
### Converters
Functions and helpers to create common objects (functions, arrays, dictionaries) and utilities for converting between different types and formats

----

> [!IMPORTANT] This module is being reorganized. Functions described here may be renamed, removed, or moved to different modules in future versions of Arturo. Please check the latest documentation for up-to-date information.

----

#### `as`
format given value as implied type
##### Arguments
- `value` (:any)
##### Options
- `binary` (:logical): format integer as binary
- `hex` (:logical): format integer as hexadecimal
- `octal` (:logical): format integer as octal
- `agnostic` (:logical): convert words in block to literals, if not in context
- `data` (:logical): parse input as Arturo data block
- `code` (:logical): convert value to valid Arturo code
- `pretty` (:logical): prettify generated code
- `unwrapped` (:logical): omit external block notation
##### Returns
:any
#### `from`
get value from string, using given representation
##### Arguments
- `value` (:string,:literal)
##### Options
- `binary` (:logical): get integer from binary representation
- `hex` (:logical): get integer from hexadecimal representation
- `octal` (:logical): get integer from octal representation
- `opcode` (:logical): get opcode by from opcode literal
##### Returns
:any
### Core
Basic functions and constants that make up the very core of the language

----

The Core module provides the fundamental building blocks of Arturo: functions for control flow, variable assignment, function definition, and basic program structure.

#### Key Concepts

- Variable and symbol management
- Control flow and conditionals
- Function and method definitions
- Scope management and modules
- Basic constants (null, any)

#### Basic Usage

##### Variable Assignment

```arturo
; basic assignment
x: 5                ; assign value to symbol
let 'x 5            ; alternative syntax

; multiple assignments
[a,b,c]: 1,2,3      ; assign multiple values
```

##### Conditionals

Arturo provides several ways to handle conditional execution:

```arturo
; simple if statement
if x=2 [
    print "x is two"
]

; using the arrow operator for single statements
if x=2 -> 
    print "x is two"

; switch statement (if-else)
switch x=2 -> print "x is two"
           -> print "x is not two"

; the exact same thing, using `?`
(x=2)? -> print "x is two"
       -> print "x is not two"

; case statement (value matching)
case value [
    1      -> print "one"
    2      -> print "two"
    "abc"  -> print "found abc"
    any    -> print "something else"  ; default case
]

; multiple conditions
when [
    x=1     -> print "x is one"
    x>10    -> print "x is greater than ten"
    x<0     -> print "x is negative"
    true    -> print "none of the above"  ; default case
]

; check all conditions without breaking
when.any [
    prime? x    -> print "x is prime"
    even? x     -> print "x is even"
    x>100      -> print "x is large"
]

; with shared condition target
when.has: x [
    [>10]  -> print "greater than 10"
    [<0]   -> print "negative"
    [=5]   -> print "equals 5"
]
```

> [!NOTE] The `->` arrow operator can be used to wrap a single expression in a block, making code more readable.

##### Function Definition

```arturo
; basic function
sum: function [a b][
    a + b
]

; with the $ shorthand
multiply: $[x y][
    x * y
]

; using arrow syntax for simple functions
double: $[x]-> x * 2
```

##### Modules

Modules are a way of isolating pieces of code so that we can expose only the functions we need, while still safeguarding parts of the internal implementation.

```arturo
; create new module
math: module [
    pwr: function [x][
        x * x
    ]
    
    calculate: method.public [z][
        \pwr z
    ]
]

export math!

; `calculate` has been exported
print calculate 10      ; 100

; but `pwr` wouldn't be available here...
```

#### Common Patterns

##### Safe Operations

```arturo
; coalesce operator
value: null
result: value ?? "default"      ; use default if null

; safe variable checking
if set? 'x [                    ; check if x exists
    print x
]

counter: 0
; variable modification
'counter + 1                    ; in-place increment
```

##### Loop Control

```arturo
; break from loop
done?: false
while [true][
    if done? -> break
    doSomething
]

; continue to next iteration
loop 1..10 'x [
    if odd? x -> continue
    print x
]
```

----

#### `alias`
assign symbol to given function
##### Arguments
- `symbol` (:string,:symbol,:symbolliteral,:block)
- `function` (:string,:word,:literal)
##### Options
- `infix` (:logical): use infix precedence
##### Returns
:nothing
#### `any`
the ANY constant
#### `break`
break out of current block or loop
##### Returns
:nothing
#### `call`
call function with given list of parameters
##### Arguments
- `function` (:string,:word,:literal,:pathliteral,:function,:method)
- `params` (:block)
##### Options
- `external` (:string): path to external library
- `expect` (:type): expect given return type
##### Returns
:any
#### `case`
match given argument against different values and execute corresponding block
##### Arguments
- `argument` (:any)
- `matches` (:dictionary,:block)
##### Returns
:logical
#### `coalesce` (alias: `??` - infix: true)
if first value is null or false, return second value; otherwise return the first one
##### Arguments
- `value` (:any)
- `alternative` (:any)
##### Returns
:any
#### `continue`
immediately continue with next iteration
##### Returns
:nothing
#### `discard`
discard given value, without pushing it onto the stack
##### Arguments
- `value` (:any)
##### Returns
:nothing
#### `do`
evaluate and execute given code
##### Arguments
- `code` (:string,:block,:bytecode)
##### Options
- `times` (:integer): repeat block execution given number of times
##### Returns
:any
#### `dup` (alias: `<=` - infix: false)
duplicate the top of the stack and convert non-returning call to a do-return call
##### Arguments
- `value` (:any)
##### Returns
:any
#### `else`
perform action, if last condition was not true
##### Arguments
- `otherwise` (:block,:bytecode)
##### Returns
:nothing
#### `ensure`
assert given condition is true, or exit
##### Arguments
- `condition` (:block)
##### Options
- `that` (:string): prints a custom message when ensure fails
##### Returns
:nothing
#### `export`
export given container children to current scope
##### Arguments
- `module` (:dictionary,:object,:module)
##### Options
- `all` (:logical): export everything, regardless of whether it's been marked as public (makes sense only for modules)
##### Returns
:nothing
#### `function` (alias: `$` - infix: false)
create function with given arguments and body
##### Arguments
- `arguments` (:literal,:block)
- `body` (:block)
##### Options
- `import` (:block): import/embed given list of symbols from current environment
- `export` (:block): export given symbols to parent
- `memoize` (:logical): store results of function calls
- `inline` (:logical): execute function without scope
##### Returns
:function
#### `if`
perform action, if given condition is not false or null
##### Arguments
- `condition` (:any)
- `action` (:block,:bytecode)
##### Returns
:nothing
#### `if?`
perform action, if given condition is not false or null and return condition result
##### Arguments
- `condition` (:any)
- `action` (:block)
##### Returns
:logical
#### `import`
import given package
##### Arguments
- `package` (:string,:literal,:block)
##### Options
- `version` (:version): specify package version
- `min` (:logical): get any version >= the specified one
- `branch` (:string,:literal): use specific branch for repository url (default: main)
- `latest` (:logical): always check for the latest version available
- `lean` (:logical): return as a dictionary, instead of importing in main namespace
- `only` (:block): import only selected symbols, if available
- `verbose` (:logical): output extra information
##### Returns
:dictionary,:block,:nothing
#### `let` (alias: `:` - infix: true)
set symbol to given value
##### Arguments
- `symbol` (:string,:word,:literal,:block)
- `value` (:any)
##### Returns
:nothing
#### `method`
create type method with given arguments and body
##### Arguments
- `arguments` (:literal,:block)
- `body` (:block)
##### Options
- `distinct` (:logical): shouldn't be treated as a magic method
- `public` (:logical): make method public (relevant only in modules!)
##### Returns
:method
#### `module`
create new module with given contents
##### Arguments
- `contents` (:dictionary,:block)
##### Options
- `with` (:block): use given initialization parameters
##### Returns
:module
#### `new`
create new value by cloning given one
##### Arguments
- `value` (:any)
##### Returns
:any
#### `null`
the NULL constant
#### `return`
return given value from current function
##### Arguments
- `value` (:any)
##### Returns
:nothing
#### `set?`
check if given variable is defined
##### Arguments
- `symbol` (:string,:literal)
##### Returns
:logical
#### `switch` (alias: `?` - infix: true)
if condition is not false or null perform given action, otherwise perform alternative action
##### Arguments
- `condition` (:any)
- `action` (:block)
- `alternative` (:block)
##### Returns
:any
#### `unless`
perform action, if given condition is false or null
##### Arguments
- `condition` (:any)
- `action` (:block,:bytecode)
##### Returns
:nothing
#### `unless?`
perform action, if given condition is false or null and return condition result
##### Arguments
- `condition` (:any)
- `action` (:block,:bytecode)
##### Returns
:logical
#### `unset`
undefine given symbol, if already defined
##### Arguments
- `symbol` (:string,:literal)
##### Returns
:nothing
#### `unstack`
pop top <number> values from stack
##### Arguments
- `number` (:integer)
##### Options
- `discard` (:logical): do not return anything
##### Returns
:any
#### `until`
execute action until the given condition is not false or null
##### Arguments
- `action` (:block,:bytecode)
- `condition` (:block,:bytecode)
##### Returns
:nothing
#### `var`
get symbol value by given name
##### Arguments
- `symbol` (:string,:word,:literal,:pathliteral)
##### Returns
:any
#### `when`
check conditions one by one and execute corresponding block accordingly
##### Arguments
- `conditions` (:block)
##### Options
- `any` (:logical): check all conditions, without breaking, regardless of success
- `has` (:any): prepend given value to each of the conditions
##### Returns
:logical
#### `when?`
check if a specific condition is fulfilled and, if so, execute given action
##### Arguments
- `condition` (:block)
- `action` (:block)
##### Returns
:logical
#### `while`
execute action while the given condition is is not false or null
##### Arguments
- `condition` (:null,:block,:bytecode)
- `action` (:block,:bytecode)
##### Returns
:nothing
#### `with`
create closure-style block by embedding given words
##### Arguments
- `embed` (:string,:word,:literal,:dictionary,:block)
- `body` (:block)
##### Returns
:block
### Crypto
Cryptography- or encoding-related functions

----

# Crypto

The Crypto module provides basic cryptographic functions and encoding utilities. It includes support for hashing, CRC calculation, and various encoding/decoding operations.

#### Key Concepts

- Hash calculation (MD5, SHA1)
- CRC32 polynomial calculation
- Base64 encoding/decoding
- URL encoding/decoding
- Character encoding conversion

#### Basic Usage

##### Hashing

```arturo
; calculate MD5 digest (default)
print digest "hello world"          ; 5eb63bbbe01eeed093cb22bb8f5acdc3

; using SHA1
print digest.sha "hello world"      ; 2aae6c35c94fcfb415dbe95f408b9ce91ee846ed

; CRC32 calculation
print crc "hello world"             ; 0d4a1185
```

> [!IMPORTANT] The Crypto module provides basic cryptographic functions. For serious cryptographic needs, consider using specialized libraries.

##### Base64 Encoding/Decoding

```arturo
; encoding
encoded: encode "Hello World!"      ; SGVsbG8gV29ybGQh
print encoded

; decoding
decoded: decode encoded             ; Hello World!
print decoded
```

##### URL Encoding/Decoding

```arturo
; encode URL
url: "https://example.com/path with spaces?q=test+1"
encoded: encode.url url
print encoded       
; https%3A%2F%2Fexample.com%2Fpath%20with%20spaces%3Fq%3Dtest%2B1

; decode URL
decoded: decode.url encoded
print decoded       
; https://example.com/path with spaces?q=test+1

; encode only spaces
spaceEncoded: encode.url.spaces "hello world"  
; hello%20world

; encode everything including slashes
fullEncoded: encode.url.slashes "/path/to/resource"
; %2Fpath%2Fto%2Fresource
```

##### Character Encoding Conversion

```arturo
; convert between character encodings
text: "Hello världen"           ; text with non-ASCII characters
converted: encode .from:"UTF-8" .to: "ISO-8859-1" text
```

#### Common Patterns

##### Password Hashing

```arturo
hashPassword: function [password][
    ; combine password with... salt and hash
    salt: "somesalt"
    combined: join @[password salt]
    digest.sha combined
]

; usage
password: "mypassword123"
hashed: hashPassword password

print ["Hashed password:" hashed]
; Hashed password: 81ea5410f1cb78c81cbb6dbd678782f80f9150f5 
```

##### Safe URL Building

```arturo
buildUrl: function [baseUrl parameters][
    query: map parameters [key value][
        key ++ "=" ++ encode.url value
    ]
    
    join.with:"?" @[
        baseUrl
        join.with:"&" query
    ]
]

; usage
url: buildUrl "https://api.example.com/search" #[
    "q": "search term"
    "lang": "en-US"
    "page": "1"
]

print url
; https://api.example.com/search?q=search%20term&lang=en-US&page=1
```

> [!TIP] When working with URLs, always encode user inputs to prevent injection attacks and ensure proper URL formatting.

----

#### `crc`
calculate the CRC32 polynomial of given string
##### Arguments
- `value` (:string,:literal,:pathliteral)
##### Returns
:string,:nothing
#### `decode`
decode given value (default: base-64)
##### Arguments
- `value` (:string,:literal,:pathliteral)
##### Options
- `url` (:logical): decode URL based on RFC3986
##### Returns
:string,:nothing
#### `digest`
get digest for given value (default: MD5)
##### Arguments
- `value` (:string,:literal,:pathliteral)
##### Options
- `sha` (:logical): use SHA1
##### Returns
:string,:nothing
#### `encode`
encode given value (default: base-64)
##### Arguments
- `value` (:string,:literal,:pathliteral)
##### Options
- `url` (:logical): encode URL based on RFC3986
- `spaces` (:logical): also encode spaces
- `slashes` (:logical): also encode slashes
- `from` (:string): source character encoding (default: CP1252)
- `to` (:string): target character encoding (default: UTF-8)
##### Returns
:string,:nothing
#### `hash`
get hash for given value
##### Arguments
- `value` (:any)
##### Options
- `string` (:logical): get as a string
##### Returns
:integer,:string
### Databases
Functions for creating and query databases

----

The Databases module offers straightforward database operations with built-in SQLite support. It provides a simple yet powerful interface for managing databases directly from your Arturo code.

#### Key Concepts

- Native SQLite support
- Simple database connection management
- Parametrized queries
- Query results as blocks of rows

#### Basic Usage

##### Opening & Closing Connections

```arturo
; create/open database
db: open.sqlite "mydata.db"

; when done
close db
```

##### Simple Queries

```arturo
query db {!sql
    CREATE TABLE users (
        id INTEGER PRIMARY KEY, 
        name TEXT, 
        age INTEGER
    )
}

query db "INSERT INTO users (name, age) VALUES ('John', 25)"

; get results
users: query db "SELECT * FROM users"
print users   ; [1 John 25]
```

> [!TIP] If you are using a text editor that supports this syntax (e.g. VSCode), using `!sql` in front of `{..}`-enclosed blocks will enable proper SQL highlighting. Totally non-compulsory, but still very handy!

##### Parametrized Queries

```arturo
; safer way to insert data with parameters
age: 30
name: "Alice"
query.with: @[name age] db "INSERT INTO users (name, age) VALUES (?,?)" 

; parametrized select
minAge: 20
results: query.with: @[minAge] db "SELECT * FROM users WHERE age > ?"
loop results 'user ->
    print ["User:" user\1 "Age:" user\2]    
; User: Alice Age: 30 
```

> [!IMPORTANT] Always use parametrized queries when dealing with user input to prevent SQL injection attacks.

#### Common Patterns

##### Transaction Handling

```arturo
; do multiple operations
query db [
    "INSERT INTO users (name, age) VALUES ('Bob', 35)"
    "UPDATE users SET age = 31 WHERE name = 'Alice'"
]

> [!NOTE] This method of performing multiple operations is the equivalent of using `BEGIN TRANSACTION` blocks in SQL, although in much more... practical and Arturo-friendly way! ;-)

```

##### Getting Last Insert ID

```arturo
; insert and get the ID
query.id.with: ["Carol" 28] db {!sql 
    INSERT INTO users (name, age) VALUES (?,?)
}
```

----

#### `close`
close given database
##### Arguments
- `database` (:database)
##### Returns
:nothing
#### `open`
opens a new database connection and returns database
##### Arguments
- `name` (:string)
##### Options
- `sqlite` (:logical): support for SQLite databases
- `mysql` (:logical): support for MySQL databases
##### Returns
:database
#### `query`
execute command or block of commands in given database and get returned rows
##### Arguments
- `database` (:database)
- `commands` (:string,:block)
##### Options
- `id` (:logical): return last INSERT id
- `with` (:block): use arguments for parametrized statement
##### Returns
:null,:integer,:block
#### `store`
create or load a persistent store on disk
##### Arguments
- `path` (:string,:literal)
##### Options
- `deferred` (:logical): save to disk only on program termination
- `global` (:logical): save as global store
- `native` (:logical): force native/Arturo format
- `json` (:logical): force Json format
- `db` (:logical): force database/SQlite format
##### Returns
:range
### Dates
Functions for manipulating dates

----

The Dates module provides functionality for working with dates and times. Dates are handled as dictionary-like values, making it easy to access and work with individual components.

#### Key Concepts

- Dates are dictionary-like values with accessible components
- Easy date arithmetic with `before` and `after`
- Various time unit granularities (from nanoseconds to years)
- Convenient date checks (weekdays, past/future, leaps)

#### Basic Usage

##### Creating Dates

```arturo
; get current date/time
current: now
print current     ; 2024-12-13T14:30:45+01:00

; accessing components
print current\year              ; 2024
print current\month             ; 12
print current\day]              ; 13
print current\hour]             ; 14
print current\minute]           ; 30
print current\second]           ; 45
```

##### Date Arithmetic

```arturo
date: now

; moving forward in time
nextWeek: after.days:7 date 
nextMonth: after.months:1 date 
nextYear: after.years:1 date 

; moving backward in time
lastWeek: before.days:7 date 
lastMonth: before.months:1 date 
lastYear: before.years:1 date 

; combine different units
meeting: after .hours:2 .minutes:30 date
```

##### Date Checks

```arturo
today: now

; time comparison
future? after.days:1 today      ; => true
past? before.days:1 today       ; => true
today? today                    ; => true

; weekday checks
monday? today                   ; well... depends
friday? today                   ; on the
sunday? today                   ; actual date! :)

; year checks
print leap? 2024                ; true
print leap? today\year          ; true (if still 2024!)
```

#### Common Patterns

##### Working with Time Intervals

```arturo
start: now
deadline: after.days:10 start 

; calculate intermediate dates
loop 0..10 'day [
    checkpoint: after.days:day start 
    print ["Day" day ":" checkpoint\day]
]
; Day 0 : 13 
; Day 1 : 14 
; Day 2 : 15 
; Day 3 : 16 
; Day 4 : 17 
; Day 5 : 18 
; Day 6 : 19 
; Day 7 : 20 
; Day 8 : 21 
; Day 9 : 22 
; Day 10 : 23 
```

##### Date Formatting and Parsing

Converting dates to strings and parsing strings into dates is done using format patterns:

```arturo
dt: now

; format date to string
to :string .format:"yyyy-MM-dd HH:mm:ss" dt    
; => 2024-12-13 16:55:38


; parse string to date
meeting: to :date .format:"yyyy-MM-dd" "2024-03-15"
; 2024-03-15T00:00:00+01:00
```

> [!NOTE] When parsing dates from strings, make sure your format pattern matches exactly the structure of your input string.

###### Format Patterns

| Pattern | Description | Example |
|---------|-------------|---------|
| d | Day of month (1 or 2 digits) | 1, 21 |
| dd | Day of month (2 digits) | 01, 21 |
| ddd | Abbreviated weekday | Sat, Mon |
| dddd | Full weekday | Saturday, Monday |
| M | Month (1 or 2 digits) | 9, 12 |
| MM | Month (2 digits) | 09, 12 |
| MMM | Abbreviated month | Sep, Dec |
| MMMM | Full month | September, December |
| yy | Year (2 digits) | 12 |
| yyyy | Year (4+ digits, padded) | 2012, 0024 |
| H | Hour 0-23 (1 or 2 digits) | 5, 17 |
| HH | Hour 0-23 (2 digits) | 05, 17 |
| h | Hour 1-12 (1 or 2 digits) | 5, 11 |
| hh | Hour 1-12 (2 digits) | 05, 11 |
| m | Minute (1 or 2 digits) | 1, 30 |
| mm | Minute (2 digits) | 01, 30 |
| s | Second (1 or 2 digits) | 1, 45 |
| ss | Second (2 digits) | 01, 45 |
| tt | AM/PM indicator | AM, PM |
| z | UTC offset (basic) | +7, -5 |
| zzz | UTC offset with minutes | +07:00, -05:00 |
| fff | Milliseconds | 001 |

Common Format Examples:

```arturo
date: now

; different format examples
print to :string .format:"MM/dd/yyyy" date          ; 12/13/2024
print to :string .format:"d MMM yyyy" date          ; 13 Dec 2024
print to :string .format:"MMMM d, yyyy" date        ; December 13, 2024
print to :string .format:"HH:mm:ss.fff" date        ; 14:30:45.123
print to :string .format:"h:mm tt" date             ; 2:30 PM
```

> [!TIP] For common use cases, you might want to create helper functions with your preferred format patterns:
> ```arturo
> formatDate: function [dt][
>     to :string .format:"yyyy-MM-dd" dt
> ]
> ```

----

#### `after`
get date after given one using interval
##### Arguments
- `date` (:literal,:pathliteral,:date)
##### Options
- `nanoseconds` (:integer): add given number of nanoseconds
- `milliseconds` (:integer): add given number of milliseconds
- `seconds` (:integer): add given number of seconds
- `minutes` (:integer): add given number of minutes
- `hours` (:integer): add given number of hours
- `days` (:integer): add given number of days
- `weeks` (:integer): add given number of weeks
- `months` (:integer): add given number of months
- `years` (:integer): add given number of years
##### Returns
:date
#### `before`
get date before given one using interval
##### Arguments
- `date` (:literal,:pathliteral,:date)
##### Options
- `nanoseconds` (:integer): subtract given number of nanoseconds
- `milliseconds` (:integer): subtract given number of milliseconds
- `seconds` (:integer): subtract given number of seconds
- `minutes` (:integer): subtract given number of minutes
- `hours` (:integer): subtract given number of hours
- `days` (:integer): subtract given number of days
- `weeks` (:integer): subtract given number of weeks
- `months` (:integer): subtract given number of months
- `years` (:integer): subtract given number of years
##### Returns
:date
#### `friday?`
check if given date is a Friday
##### Arguments
- `date` (:date)
##### Returns
:logical
#### `future?`
check if given date is in the future
##### Arguments
- `date` (:date)
##### Returns
:logical
#### `leap?`
check if given year is a leap year
##### Arguments
- `year` (:integer,:date)
##### Returns
:logical
#### `monday?`
check if given date is a Monday
##### Arguments
- `date` (:date)
##### Returns
:logical
#### `now`
get date/time now
##### Returns
:date
#### `past?`
check if given date is in the past
##### Arguments
- `date` (:date)
##### Returns
:logical
#### `saturday?`
check if given date is a Saturday
##### Arguments
- `date` (:date)
##### Returns
:logical
#### `sunday?`
check if given date is a Sunday
##### Arguments
- `date` (:date)
##### Returns
:logical
#### `thursday?`
check if given date is a Thursday
##### Arguments
- `date` (:date)
##### Returns
:logical
#### `today?`
check if given date is today
##### Arguments
- `date` (:date)
##### Returns
:logical
#### `tuesday?`
check if given date is a Tuesday
##### Arguments
- `date` (:date)
##### Returns
:logical
#### `wednesday?`
check if given date is a Wednesday
##### Arguments
- `date` (:date)
##### Returns
:logical
### Exceptions
Exceptions and error handling

----

The Exceptions module provides error handling functionality and predefined error types. It enables robust error management and graceful failure handling in your applications.

> [!IMPORTANT] The error handling system in Arturo is still evolving. The functionality described in this module should be considered transitional and may change in future versions as the error handling system matures.

#### Key Concepts

- Error throwing and catching
- Predefined error types
- Error assertions
- Error testing capabilities

#### Basic Usage

##### Error Handling

```arturo
; basic try-catch pattern
if error? err: <= try [
    ; some risky operation
    result: 10 / 0
][
    print "something went wrong!"
    print err
]
```

##### Throwing Errors

```arturo
; throw generic error
throw "Something went wrong"

; throw with specific error type
throw.as:valueError "Invalid input provided"

; throw with custom message
throw "User not found: %id=123"
```

##### Error Testing

```arturo
; test if operation throws an error
if throws? [
    10 / 0
] -> print "Operation has thrown an error"
```

#### Predefined Error Types

```arturo
; available error types
nameError           ; when symbol not found
typeError           ; when type mismatch
valueError          ; when value is invalid
arithmeticError     ; for math operations
indexError          ; for invalid indices
syntaxError         ; for parsing issues
systemError         ; for OS-related errors
runtimeError        ; for general runtime issues
```

----

#### `arithmeticError`
an arithmetic error
#### `assertionError`
an assertion error
#### `conversionError`
a conversion error
#### `indexError`
an index error
#### `libraryError`
a library error
#### `nameError`
a name error
#### `packageError`
a package error
#### `runtimeError`
a generic runtime error
#### `syntaxError`
a syntax error
#### `systemError`
a system error
#### `throw`
throw an error with given message
##### Arguments
- `message` (:string,:errorkind)
##### Options
- `as` (:errorkind): consider the error as one of given subtype
##### Returns
:nothing
#### `throws?`
perform action, and return true if errors were thrown
##### Arguments
- `action` (:block,:bytecode)
##### Returns
:logical
#### `try`
perform action and catch possible errors
##### Arguments
- `action` (:block,:bytecode)
##### Options
- `verbose` (:logical): print all error messages as usual
##### Returns
:null,:error
#### `typeError`
a type error
#### `uiError`
a UI error
#### `valueError`
a value error
#### `vmError`
a VM error
### Files
Functions for reading, writing, and manipulating files

----

The Files module provides powerful functions for file operations, with intelligent handling of different data sources and formats. Its flexibility allows seamless interaction with local files, URLs, and direct content.

#### Key Concepts

- Smart source detection (URLs, files, direct content)
- Support for multiple file formats (JSON, CSV, XML, etc.)
- File system operations (copy, move, delete)
- Directory handling and path manipulation
- Automatic format detection and parsing

#### Basic Usage

##### Reading Content

`read` intelligently handles different types of sources:

```arturo
; reading from different sources
content: read "hello.txt"               ; read local file
content: read "https://api.com/data"    ; download from URL
content: read "some direct content"     ; use string directly

; force treating string as file path
content: read.file "some text.txt"      ; error if file doesn't exist
```

##### Writing Content

```arturo
; basic writing
write "some content" "output.txt"

; using the infix operator
"some content" >> "output.txt"

; append to existing file
write.append "more content" "output.txt"
```

##### Format Parsing & Generation

```arturo
; reading & parsing JSON from any source
data: read.json "data.json"              ; from local file
data: read.json "https://api.com/data"   ; from URL
data: read.json "{\"key\":\"value\"}"    ; from string

; writing data as JSON
write.json data "output.json"            ; to file
jsonStr: write.json data ø               ; to string

; other supported formats
content: read.csv "data.csv"             ; parse CSV
content: read.xml "data.xml"             ; parse XML
content: read.html "page.html"           ; parse HTML
content: read.markdown "doc.md"          ; convert to HTML
content: read.toml "config.toml"         ; parse TOML
```

> [!TIP] The format functions (like `.json`, `.csv`) work the same way regardless of source - local file, URL, or direct content.

##### File System Operations

```arturo
; check existence
print exists? "file.txt"      ; => true/false
print file? "file.txt"        ; => true/false
print directory? "folder"     ; => true/false

; file operations
copy "source.txt" "dest.txt"
move "old.txt" "new.txt"
delete "unwanted.txt"

; directory operations
copy.directory "src" "dest"
delete.directory "olddir"
```

#### Common Patterns

##### Working with Paths

```arturo
path: "photos/vacation/beach.jpg"

print extract.directory path    ; photos/vacation
print extract.filename path     ; beach.jpg
print extract.extension path    ; jpg

; normalize paths
print normalize "./folder/../file.txt"  ; file.txt
print normalize "~/documents"           ; expands home directory
```

##### Reading Files Safely

```arturo
; handle potential missing files
if exists? "config.json" [
    settings: read.json "config.json"
]

; force file reading (error if not found)
if throws? [
    data: read.file "important.txt"
]-> print "File not found!"
```

##### Bulk Operations

```arturo
; list files in directory
files: list "documents"
files: list.recursive "documents"    ; include subdirectories

; process multiple files
loop files 'file [
    if "txt" = extract.extension file ->
        print ["Found text file:" file]
]
```

----

#### `copy`
copy file at path to given destination
##### Arguments
- `file` (:string)
- `destination` (:string)
##### Options
- `directory` (:logical): path is a directory
##### Returns
:nothing
#### `delete`
delete file at given path
##### Arguments
- `file` (:string)
##### Options
- `directory` (:logical): path is a directory
##### Returns
:nothing
#### `directory?`
check if given path exists and corresponds to a directory
##### Arguments
- `path` (:string)
##### Returns
:logical
#### `exists?`
check if file/directory at given path exists
##### Arguments
- `path` (:string)
##### Returns
:logical
#### `file?`
check if given path exists and corresponds to a file
##### Arguments
- `path` (:string)
##### Returns
:logical
#### `hidden?`
check if file/folder at given path is hidden
##### Arguments
- `file` (:string)
##### Returns
:logical
#### `move`
move file at path to given destination
##### Arguments
- `file` (:string)
- `destination` (:string)
##### Options
- `directory` (:logical): path is a directory
##### Returns
:nothing
#### `permissions`
check permissions of given file
##### Arguments
- `file` (:string)
##### Options
- `set` (:dictionary): set using given file permissions
##### Returns
:null,:dictionary
#### `read` (alias: `<<` - infix: false)
read file from given path
##### Arguments
- `file` (:string)
##### Options
- `lines` (:logical): read file lines into block
- `json` (:logical): read Json into value
- `csv` (:logical): read CSV file into a block of rows
- `delimiter` (:char): read CSV file with a specific delimiter
- `withHeaders` (:logical): read CSV headers
- `html` (:logical): read HTML into node dictionary
- `xml` (:logical): read XML into node dictionary
- `markdown` (:logical): read Markdown and convert to HTML
- `toml` (:logical): read TOML into value
- `bytecode` (:logical): read file as Arturo bytecode
- `binary` (:logical): read as binary
- `file` (:logical): read as file (throws an error if not valid)
##### Returns
:string,:binary,:block
#### `rename`
rename file at path using given new path name
##### Arguments
- `file` (:string)
- `name` (:string)
##### Options
- `directory` (:logical): path is a directory
##### Returns
:nothing
#### `symlink`
create symbolic link of file to given destination
##### Arguments
- `file` (:string)
- `destination` (:string)
##### Options
- `hard` (:logical): create a hard link
##### Returns
:nothing
#### `symlink?`
check if given path exists and corresponds to a symlink
##### Arguments
- `path` (:string)
##### Returns
:logical
#### `timestamp`
get file timestamps
##### Arguments
- `file` (:string)
##### Returns
:null,:dictionary
#### `unzip`
unzip given archive to destination
##### Arguments
- `destination` (:string)
- `original` (:string)
##### Returns
:nothing
#### `volume`
get file size for given path
##### Arguments
- `file` (:string)
##### Returns
:quantity
#### `write` (alias: `>>` - infix: true)
write content to file at given path
##### Arguments
- `content` (:any)
- `file` (:null,:string)
##### Options
- `append` (:logical): append to given file
- `directory` (:logical): create directory at path
- `json` (:logical): write value as Json
- `compact` (:logical): produce compact, non-prettified Json code
- `binary` (:logical): write as binary
##### Returns
:nothing
#### `zip`
zip given files to file at destination
##### Arguments
- `destination` (:string)
- `files` (:block)
##### Returns
:nothing
### Io
Functions and utilities for using the terminal and standard input/output

----

The Io module provides functionality for terminal input/output operations, cursor manipulation, and console formatting. It offers both basic printing capabilities and advanced terminal controls.

#### Key Concepts

- Terminal input/output operations
- Colored text output
- Cursor manipulation
- Terminal information retrieval
- Multi-line input handling

#### Basic Usage

##### Output Operations

```arturo
; basic printing (with newline)
print "Hello world"
print ["Multiple" "values" "joined"]   ; Multiple values joined

; printing without newline
prints "Loading..."
print "."                             ; Loading....

; print items on separate lines
print.lines ["one" "two" "three"]
; one
; two
; three
```

##### Input Operations

```arturo
; basic input with prompt
name: input "What's your name? "

; single character input
ch: input ø    ; returns single character without echo

; REPL-style input with history
cmd: input.repl ">> "
```

##### Colored Output

```arturo
; using color function
print color #red "Error!"
print color.bold #blue "Important"
print color.underline #green "Success"

; keep color active
prints color.keep #red "This "
prints "and this "
print "all red"

; combining styles
print color.bold.underline #blue "Highlighted"
```

##### Cursor Control

```arturo
; hide/show cursor
cursor false      ; hide cursor
cursor true       ; show cursor

; move cursor to specific position
goto 10 5         ; move to x:10, y:5
print "X"
goto ø 10         ; move to current x, line 10
print "Y"
goto 5 ø          ; move to column 5, current line
print "Z"

; clear screen
clear
```

#### Common Patterns

##### Progress Indicators

```arturo
; simple progress indicator
loop 1..5 'i [
    prints "."
    pause 500    ; pause for 500ms
]
print ""

; animated spinner
spinner: ["⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏"]
loop 1..20 'i [
    prints "\b"        ; go back one character
    prints spinner\[i % size spinner]
    pause 100
]
print ""
```

##### Interactive Menus

```arturo
clearMenu: function [][
    clear
    cursor false
]

showMenu: function [options][
    selected: 0
    while [true][
        clearMenu
        
        loop options 'opt -> 
            print ["   " opt]
            
        goto 0 selected
        prints "→ "
        
        key: input ø
        case key [
            'w' -> if selected > 0 [dec 'selected]
            's' -> if selected < (size options)-1 [inc 'selected]
            '\r' [
                cursor true
                return selected
            ]
        ]
    ]
]

; usage
choice: showMenu ["Start" "Settings" "Exit"]
print ["Selection:" choice]
```

##### Status Updates

```arturo
; colorful status messages
printStatus: function [kind message][
    case kind [
        "info"    -> print [color #blue "ℹ" message]
        "success" -> print [color #green "✓" message]
        "warning" -> print [color #yellow "⚠" message]
        "error"   -> print [color #red "✗" message]
    ]
]

; usage
printStatus "info" "Loading configuration..."
printStatus "success" "Configuration loaded"
printStatus "warning" "Disk space low"
printStatus "error" "Connection failed"
```

> [!TIP] When working with colors, remember that not all terminals support all color features. You might want to check terminal capabilities first.

##### Terminal Information

```arturo
; get terminal information
print ["Width:" terminal\width]
print ["Height:" terminal\height]
```

----

#### `clear`
clear terminal
##### Returns
:nothing
#### `color`
get colored version of given string
##### Arguments
- `color` (:color)
- `string` (:string)
##### Options
- `bold` (:logical): bold font
- `underline` (:logical): show underlined
- `keep` (:logical): don't reset color at string end
##### Returns
:string
#### `cursor`
turn cursor visibility on/off
##### Arguments
- `visible` (:logical)
##### Returns
:nothing
#### `goto`
move cursor to given coordinates
##### Arguments
- `x` (:null,:integer)
- `y` (:null,:integer)
##### Returns
:nothing
#### `input`
print prompt and get user input. If the prompt is ø, get a single character
##### Arguments
- `prompt` (:null,:string)
##### Options
- `repl` (:logical): get input as if in a REPL
- `history` (:string): set path for saving history
- `complete` (:block): use given array for auto-completions
- `hint` (:dictionary): use given dictionary for typing hints
##### Returns
:char,:string
#### `print`
print given value to screen with newline
##### Arguments
- `value` (:any)
##### Options
- `lines` (:logical): print each value in block in a new line
##### Returns
:nothing
#### `prints`
print given value to screen
##### Arguments
- `value` (:any)
##### Returns
:nothing
#### `terminal`
get info about terminal
##### Returns
:dictionary
### Iterators
Functional helpers for easier block iteration (loops, filtering, mapping, etc)

----

The Iterators module provides functional programming tools for working with collections. From simple loops to complex transformations, it offers a consistent way to process collections with elegant, expressive code.

#### Key Concepts

- Collection iteration with various strategies
- Functional transformations (map, filter, fold)
- Collection analysis (every?, some?, enumerate)
- Consistent behavior across all collection types
- Support for block-based predicate conditions

#### Basic Usage

##### Looping Through Collections

```arturo
numbers: [1 2 3 4 5]

; basic iteration
loop numbers 'n ->
    print ["Number:" n]
; Number: 1 
; Number: 2 
; Number: 3 
; Number: 4 
; Number: 5 

; with index
loop.with:'i numbers 'n ->
    print ["Item" i ":" n]
; Item 0 : 1 
; Item 1 : 2 
; Item 2 : 3 
; Item 3 : 4 
; Item 4 : 5

; dictionary iteration
user: #[name: "John" age: 30]
loop user [key value]->
    print [key "->" value]
; name -> John 
; age -> 30 
```

> [!NOTE] Iterator functions work uniformly with all collection types:
> - Blocks: `loop [1 2 3] 'x [...]`
> - Dictionaries: `loop #[a:1 b:2] [k v] [...]`
> - Strings: `loop "hello" 'c [...]`
> - Ranges: `loop 1..5 'x [...]`
> - Numbers: `loop 3 'i [...]` (equivalent to `1..3`)

##### Transforming Collections

```arturo
numbers: 1..5

; transform each element
doubled: map numbers 'x -> x * 2
print doubled       ; 2 4 6 8 10

; using the => shorthand for simple transformations
squared: map numbers => [& ^ 2]
print squared       ; 1 4 9 16 25

; chaining transformations
result: map numbers 'x ->
    (to :string x) ++ "!"
; ["1!" "2!" "3!" "4!" "5!"]
```

##### Filtering Elements

```arturo
numbers: 1..10

; keep elements matching condition
evens: select numbers 'n -> even? n
print evens         ; 2 4 6 8 10

; remove elements matching condition
noEvens: filter numbers 'n -> even? n
print noEvens       ; 1 3 5 7 9

; shorthand for simple predicates
odds: select numbers => odd?
print odds          ; 1 3 5 7 9
```

#### Common Patterns

##### Testing Collections

```arturo
numbers: [2 4 6 8]

; check if all elements match
every? numbers => even?             ; => true

; check if any element matches
some? numbers => [& > 10]           ; => false

; count matching elements
enumerate numbers 'x -> x > 5       ; => 3
```

##### Collecting and Grouping

```arturo
data: ["apple" "banana" "apricot" "cherry"]

; group by first letter
byLetter: gather data 'word -> first word
print byLetter  
; [a:[apple apricot] b:[banana] c:[cherry]]

; collect elements while condition is true
ascending: collect [1 2 3 2 4 5] 'x -> 
    x < 4
print ascending     ; 1 2 3 2
```

##### Advanced Transformations

```arturo
; fold (reduce) a collection
sum: fold 1..5 [acc val]->
    acc + val
; 15

; with seed value
sumFrom100: fold.seed:100 1..5 [acc val]->
    acc + val
; 115

; arrange (sort) with custom predicate
users: @[
    #[name: "John"  score: 42]
    #[name: "Alice" score: 28]
    #[name: "Bob"   score: 35]
]

sorted: arrange users 'user -> user\score
print.lines map sorted 'u -> u\name     
; Alice
; Bob
; John
```

> [!TIP] The arrow operator (`=>`) is particularly useful with iterators for creating concise, readable code. For example: `map nums => [& * 2]` instead of `map nums 'x -> x * 2`

##### Working with Nested Data

```arturo
; cluster similar items
temps: [22 22 23 25 25 25 24 24]
clusters: cluster temps 'temp -> temp
; [[22 22] [23] [25 25 25] [24 24]]

; chunk using predicate
data: 1..6
chunks: chunk data => [& < 3]
[1 2] [3 4 5 6] 

; finding matches with collect
numbers: [1 2 3 2 1 4 5 4]
duplicates: collect.after numbers 'x ->
    not? contains? first.n:3 numbers x
; 4 5 4
```

##### Pipe-based Transformations

```arturo
; Sample data: list of orders
orders: @[
    #[id: 1 items: ["book" "pen"] total: 25.50 status: "pending"]
    #[id: 2 items: ["laptop"] total: 999.99 status: "completed"]
    #[id: 3 items: ["phone" "case" "charger"] total: 699.00 status: "pending"]
    #[id: 4 items: ["tablet"] total: 299.99 status: "cancelled"]
]

; Process orders using pipes for better readability
result: orders 
    | select 'order -> order\status = "pending"         ; get pending orders
    | map 'order -> #[                                  ; transform structure
        orderId: order\id
        itemCount: size order\items
        cost: order\total
    ]
    | arrange 'order -> order\cost                      ; sort by cost
    | map 'order -> ~{
        Order #|order\orderId|: |order\itemCount| 
        items @ $|order\cost|
     }

print.lines result    
; Order #1: 2 
; items @ $25.5
; Order #3: 3 
; items @ $699.0
```

> [!TIP] Using pipes (|) can make complex data transformations more readable by breaking them into clear, sequential steps.

----

#### `arrange`
sort items in collection using given action, in ascending order
##### Arguments
- `collection` (:integer,:string,:literal,:dictionary,:object,:inline,:block,:range)
- `params` (:null,:literal,:block)
- `condition` (:block,:bytecode)
##### Options
- `with` (:literal): use given index
- `descending` (:logical): sort in descending order
##### Returns
:block,:nothing
#### `chunk`
chunk together consecutive items in collection that abide by given predicate
##### Arguments
- `collection` (:integer,:string,:literal,:dictionary,:object,:inline,:block,:range)
- `params` (:null,:literal,:block)
- `condition` (:block,:bytecode)
##### Options
- `with` (:literal): use given index
- `value` (:logical): also include condition values
##### Returns
:block,:nothing
#### `cluster`
group together items in collection that abide by given predicate
##### Arguments
- `collection` (:integer,:string,:literal,:dictionary,:object,:inline,:block,:range)
- `params` (:null,:literal,:block)
- `condition` (:block,:bytecode)
##### Options
- `with` (:literal): use given index
- `value` (:logical): also include condition values
##### Returns
:block,:nothing
#### `collect`
collect items from given collection condition while is true
##### Arguments
- `collection` (:integer,:string,:literal,:dictionary,:object,:inline,:block,:range)
- `params` (:null,:literal,:block)
- `condition` (:block,:bytecode)
##### Options
- `with` (:literal): use given index
- `after` (:logical): start collecting after given condition becomes true
##### Returns
:block,:nothing
#### `enumerate`
calculate the number of given collection's items that satisfy condition
##### Arguments
- `collection` (:integer,:string,:dictionary,:object,:inline,:block,:range)
- `params` (:null,:literal,:block)
- `condition` (:block,:bytecode)
##### Options
- `with` (:literal): use given index
##### Returns
:integer
#### `every?`
check if every item in collection satisfies given condition
##### Arguments
- `collection` (:integer,:string,:dictionary,:object,:inline,:block,:range)
- `params` (:null,:literal,:block)
- `condition` (:block,:bytecode)
##### Options
- `with` (:literal): use given index
##### Returns
:logical
#### `filter`
get collection's items by filtering those that do not fulfil given condition
##### Arguments
- `collection` (:integer,:string,:literal,:dictionary,:object,:inline,:block,:range)
- `params` (:null,:literal,:block)
- `condition` (:block,:bytecode)
##### Options
- `with` (:literal): use given index
- `first` (:logical,:integer): only filter first element/s
- `last` (:logical,:integer): only filter last element/s
##### Returns
:block,:nothing,:any
#### `fold`
left-fold given collection returning accumulator
##### Arguments
- `collection` (:integer,:string,:dictionary,:object,:inline,:block,:range)
- `params` (:null,:block)
- `action` (:block,:bytecode)
##### Options
- `with` (:literal): use given index
- `seed` (:any): use specific seed value
- `right` (:logical): perform right folding
##### Returns
:null,:block,:nothing
#### `gather`
group items in collection by block result and return as dictionary
##### Arguments
- `collection` (:integer,:string,:literal,:dictionary,:object,:inline,:block,:range)
- `params` (:null,:literal,:block)
- `condition` (:block,:bytecode)
##### Options
- `with` (:literal): use given index
##### Returns
:dictionary,:nothing
#### `loop`
loop through collection, using given iterator and block
##### Arguments
- `collection` (:integer,:string,:dictionary,:object,:inline,:block,:range)
- `params` (:null,:literal,:block)
- `action` (:block,:bytecode)
##### Options
- `with` (:literal): use given index
- `forever` (:logical): cycle through collection infinitely
##### Returns
:nothing
#### `map`
map collection's items by applying given action
##### Arguments
- `collection` (:integer,:string,:literal,:dictionary,:object,:inline,:block,:range)
- `params` (:null,:literal,:block)
- `condition` (:block,:bytecode)
##### Options
- `with` (:literal): use given index
##### Returns
:block,:nothing
#### `maximum`
get maximum item from collection based on given predicate
##### Arguments
- `collection` (:integer,:string,:literal,:dictionary,:object,:inline,:block,:range)
- `params` (:null,:literal,:block)
- `condition` (:block,:bytecode)
##### Options
- `with` (:literal): use given index
- `value` (:logical): also include predicate values
##### Returns
:block,:nothing
#### `minimum`
get minimum item from collection based on given predicate
##### Arguments
- `collection` (:integer,:string,:literal,:dictionary,:object,:inline,:block,:range)
- `params` (:null,:literal,:block)
- `condition` (:block,:bytecode)
##### Options
- `with` (:literal): use given index
- `value` (:logical): also include predicate values
##### Returns
:block,:nothing
#### `select`
get collection's items that fulfil given condition
##### Arguments
- `collection` (:integer,:string,:literal,:dictionary,:object,:inline,:block,:range)
- `params` (:null,:literal,:block)
- `condition` (:block,:bytecode)
##### Options
- `with` (:literal): use given index
- `first` (:logical,:integer): only return first element/s
- `last` (:logical,:integer): only return last element/s
- `n` (:integer): only return n-th element
##### Returns
:block,:nothing,:any
#### `some?`
check if any of collection's items satisfy given condition
##### Arguments
- `collection` (:integer,:string,:dictionary,:object,:inline,:block,:range)
- `params` (:null,:literal,:block)
- `condition` (:block,:bytecode)
##### Options
- `with` (:literal): use given index
##### Returns
:logical
### Logic
Logical operations (AND, OR, XOR, etc), helpers and constants for boolean values

----

The Logic module provides boolean operations and logical value manipulation. Beyond traditional true/false operations, it includes support for ternary logic with `maybe` and optimized evaluation strategies.

#### Key Concepts

- Three-valued logic: `true`, `false`, and `maybe`
- Standard boolean operations (AND, OR, XOR, etc.)
- Short-circuit evaluation for improved performance

#### Basic Usage

##### Basic Logical Values

```arturo
print true?  true     ; true
print false? false    ; true
print true?  maybe    ; maybe
```

##### Logical Operations

```arturo
and? true true      ; true
or?  true false     ; true
xor? true true      ; false

; with maybe
and? true maybe     ; maybe
or?  true maybe     ; true
```

##### Short-Circuit Evaluation

```arturo
; if first block is false,
; the second one won't be evaluated 
if and? [1=2][print "never runs"] -> 
    print "not true"

; if first block is true,
; the second one won't be evaluated 
if or? [1=1][print "never runs"] -> 
    print "was true"

; was true
```

> [!NOTE] Using blocks with `and?` and `or?` enables short-circuit evaluation. In a few words: blocks are only evaluated when needed.

#### Common Patterns

##### Testing Multiple Conditions

```arturo
conditions: @[true false true true]

; check if all conditions are true
all? conditions     ; => false

; check if any condition is true
any? conditions     ; => true
```

> [!TIP] Combining conditions in blocks with `and?` and `or?` (or more than one condition inside `all?` or `any?` blocks) is more efficient than checking them separately!

##### Advanced Logical Operations

```arturo
a: true
b: false

print nand? a b    ; true  = not (a and b)
print nor? a b     ; false = not (a or b)
print xnor? a b    ; false = not (a xor b)
```

----

#### `all?`
check if all values in given block are true
##### Arguments
- `conditions` (:block)
##### Returns
:logical
#### `and?` (alias: `∧` - infix: true)
return the logical AND for the given values
##### Arguments
- `valueA` (:logical,:block)
- `valueB` (:logical,:block)
##### Returns
:logical
#### `any?`
check if any of the values in given block is true
##### Arguments
- `conditions` (:block)
##### Returns
:logical
#### `false`
the FALSE logical constant
#### `false?`
returns true if given value is false; otherwise, it returns false
##### Arguments
- `value` (:any)
##### Returns
:logical
#### `maybe`
the MAYBE logical constant
#### `nand?` (alias: `⊼` - infix: true)
return the logical NAND for the given values
##### Arguments
- `valueA` (:logical,:block)
- `valueB` (:logical,:block)
##### Returns
:logical
#### `nor?`
return the logical NOR for the given values
##### Arguments
- `valueA` (:logical,:block)
- `valueB` (:logical,:block)
##### Returns
:logical
#### `not?` (alias: `¬` - infix: false)
return the logical complement of the given value
##### Arguments
- `value` (:logical,:block)
##### Returns
:logical
#### `or?` (alias: `∨` - infix: true)
return the logical OR for the given values
##### Arguments
- `valueA` (:logical,:block)
- `valueB` (:logical,:block)
##### Returns
:logical
#### `true`
the TRUE logical constant
#### `true?`
returns true if given value is true; otherwise, it returns false
##### Arguments
- `value` (:any)
##### Returns
:logical
#### `xnor?`
return the logical XNOR for the given values
##### Arguments
- `valueA` (:logical,:block)
- `valueB` (:logical,:block)
##### Returns
:logical
#### `xor?` (alias: `⊻` - infix: true)
return the logical XOR for the given values
##### Arguments
- `valueA` (:logical,:block)
- `valueB` (:logical,:block)
##### Returns
:logical
### Net
Network-related functions and helpers

----

The Net module provides functionality for network operations, including HTTP requests, file downloads, mail sending, and web serving capabilities.

#### Key Concepts

- HTTP requests (GET, POST, PUT, PATCH, DELETE)
- File downloads
- Email sending
- Web server functionality
- Browser integration

#### Basic Usage

##### HTTP Requests

```arturo
; basic GET request
response: request "https://api.example.com/data" ø
print response\body

; POST with JSON data
data: #[name: "John" age: 30]
response: request.post.json "https://api.example.com/users" data

; custom headers
response: request "https://api.example.com/data" .headers: #[
    authorization: "Bearer abc123"
    accept: "application/json"
] ø

; other HTTP methods
response: request.put "https://api.example.com/users/1" data
response: request.patch "https://api.example.com/users/1" data
response: request.delete "https://api.example.com/users/1" ø
```

> [!IMPORTANT] When making HTTP requests, always handle potential network errors and timeouts appropriately.

##### File Downloads

```arturo
; download file
download "https://example.com/file.pdf"

; download with custom filename
download.as:"local.pdf" "https://example.com/file.pdf"
```

##### Sending Emails

```arturo
; basic email
mail "recipient@email.com" "Hello!" "This is the message body"

; with custom SMTP configuration
mail .using: #[
        server: "smtp.company.com"
        port: 587
        username: "sender@company.com"
        password: "secret"
] "recipient@email.com" "Meeting reminder" "Don't forget our meeting tomorrow!" 
```

##### Opening URLs

```arturo
; open URL in default browser
browse "https://arturo-lang.io"
```

#### Common Patterns

##### Simple REST API Client

```arturo
define :apiClient [
    init: constructor [baseUrl token]

    headers: method [][
        #[
            authorization: join ["Bearer " \token]
            content-type: "application/json"
        ]
    ]

    get: method.distinct [endpoint][
        request join @[\baseUrl endpoint] .headers: \headers ø
    ]

    post: function [endpoint data][
        request.post.json join @[\baseUrl endpoint] .headers: \headers data
    ]
]

; create a new API Client
apiClient: to :apiClient ["https://api.example.com" ""]!

; usage
response: apiClient\get "/users"
newUser: apiClient\post "/users" #[name: "John" email: "john@email.com"]
```

##### Mini Web Server

```arturo
; create a simple web server
; create a simple web server
serve.verbose [
    GET "/" [
        render.template {
            <html>
                <body>
                    <h1>Welcome!</h1>
                    <p>The time is: <||= now ||></p>
                </body>
            </html>
        }
    ]

    GET "/post/(?<id>.+)" $[id][
        render.template {
            This is post with id: <||= id ||>
        }
    ]

    GET "/styles/(?<file>.+)" $[file][
        ; serve static files
        read file
    ]
]
```

> [!TIP] The serve function can also open Chrome in app mode with `.chrome` for a more app-like experience.

----

#### `browse`
open given URL with default browser
##### Arguments
- `url` (:string)
##### Returns
:nothing
#### `download`
download file from url to disk
##### Arguments
- `url` (:string)
##### Options
- `as` (:string): set target file
##### Returns
:nothing
#### `mail`
send mail using given title and message to selected recipient
##### Arguments
- `recipient` (:string)
- `title` (:string)
- `message` (:string)
##### Options
- `using` (:dictionary): use given configuration
##### Returns
:nothing
#### `request`
perform HTTP request to url with given data and get response
##### Arguments
- `url` (:string)
- `data` (:null,:string,:dictionary)
##### Options
- `get` (:logical): perform a GET request (default)
- `post` (:logical): perform a POST request
- `patch` (:logical): perform a PATCH request
- `put` (:logical): perform a PUT request
- `delete` (:logical): perform a DELETE request
- `json` (:logical): send data as Json
- `headers` (:dictionary): send custom HTTP headers
- `agent` (:string): use given user agent
- `timeout` (:integer): set a timeout
- `proxy` (:string): use given proxy url
- `certificate` (:string): use SSL certificate at given path
- `raw` (:logical): return raw response without processing
##### Returns
:null,:dictionary
#### `serve`
start web server using given routes
##### Arguments
- `routes` (:block)
##### Options
- `port` (:integer): use given port
- `verbose` (:logical): print info log
- `chrome` (:logical): open in Chrome windows as an app
##### Returns
:nothing
### Numbers
Functions and helpers for more advanced math-related operations

----

The Numbers module extends Arturo's numerical capabilities beyond basic arithmetic, offering advanced mathematical functions, number theory operations, and trigonometric calculations.

#### Key Concepts

- Full support for complex numbers and mathematical constants
- Advanced mathematical functions (logarithms, exponentials)
- Comprehensive trigonometric operations
- Number theory functions (factors, primes)
- Random number generation

#### Basic Usage

##### Mathematical Constants

```arturo
pi              ; => 3.141592653589793
epsilon         ; => 2.718281828459045
tau             ; => 6.283185307179586
```

##### Mathematical Functions

```arturo
; exponentials and logarithms
exp 1           ; => 2.718281828459045
ln 10           ; => 2.302585092994046
log 100 10      ; => 2.0

; rounding & absolute values
ceil 3.14       ; => 4
floor 3.14      ; => 3
round 3.14      ; => 3.0
abs neg 42      ; => 42
```

##### Complex Numbers

```arturo
z: to :complex [3 4]    ; 3.0+4.0i
print abs z             ; 5.0
print angle z           ; 0.927295218001612

w: to :complex [1 1]    ; 1.0+1.0i
print z * w             ; -1.0+7.0i
```

> [!NOTE] Complex numbers are created using `to` with a block containing the real and imaginary parts.

##### Number Theory

```arturo
; prime numbers
prime? 17           ; => true

; factors
factors 12          ; => [1 2 3 4 6 12]
factors.prime 12    ; => [2 2 3]

; GCD and LCM
print gcd [24 36]   ; 12
print lcm [4 6]     ; 12
```

#### Common Patterns

##### Working with Angles

```arturo
ang: pi/6                       ; 30 degrees

; trigonometric functions
print round.to: 2 sin ang       ; 0.5
print cos ang                   ; 0.866025403784439
print tan ang                   ; 0.577350269189626

; inverse functions
print asin 0.5                  ; 0.523598775598299
```

##### Random Number Generation

```arturo
; random integer in range (inclusive)
print random 1 6    ; dice roll...

; random floating-point numbers
print random 0.0 1.0
```

----

#### `abs`
get the absolute value for given integer
##### Arguments
- `value` (:integer,:floating,:complex,:rational)
##### Returns
:integer,:floating
#### `acos`
calculate the inverse cosine of given angle
##### Arguments
- `angle` (:integer,:floating,:complex,:rational,:quantity)
##### Returns
:floating,:complex
#### `acosh`
calculate the inverse hyperbolic cosine of given angle
##### Arguments
- `angle` (:integer,:floating,:complex,:rational,:quantity)
##### Returns
:floating,:complex
#### `acsec`
calculate the inverse cosecant of given angle
##### Arguments
- `angle` (:integer,:floating,:complex,:rational,:quantity)
##### Returns
:floating,:complex
#### `acsech`
calculate the inverse hyperbolic cosecant of given angle
##### Arguments
- `angle` (:integer,:floating,:complex,:rational,:quantity)
##### Returns
:floating,:complex
#### `actan`
calculate the inverse cotangent of given angle
##### Arguments
- `angle` (:integer,:floating,:complex,:rational,:quantity)
##### Returns
:floating,:complex
#### `actanh`
calculate the inverse hyperbolic cotangent of given angle
##### Arguments
- `angle` (:integer,:floating,:complex,:rational,:quantity)
##### Returns
:floating,:complex
#### `angle`
calculate the phase angle of given number
##### Arguments
- `number` (:complex)
##### Returns
:floating
#### `asec`
calculate the inverse secant of given angle
##### Arguments
- `angle` (:integer,:floating,:complex,:rational,:quantity)
##### Returns
:floating,:complex
#### `asech`
calculate the inverse hyperbolic secant of given angle
##### Arguments
- `angle` (:integer,:floating,:complex,:rational,:quantity)
##### Returns
:floating,:complex
#### `asin`
calculate the inverse sine of given angle
##### Arguments
- `angle` (:integer,:floating,:complex,:rational,:quantity)
##### Returns
:floating,:complex
#### `asinh`
calculate the inverse hyperbolic sine of given angle
##### Arguments
- `angle` (:integer,:floating,:complex,:rational,:quantity)
##### Returns
:floating,:complex
#### `atan`
calculate the inverse tangent of given angle
##### Arguments
- `angle` (:integer,:floating,:complex,:rational,:quantity)
##### Returns
:floating,:complex
#### `atan2`
calculate the inverse tangent of y / x
##### Arguments
- `y` (:integer,:floating,:rational)
- `x` (:integer,:floating,:rational)
##### Returns
:floating,:complex
#### `atanh`
calculate the inverse hyperbolic tangent of given angle
##### Arguments
- `angle` (:integer,:floating,:complex,:rational,:quantity)
##### Returns
:floating,:complex
#### `ceil`
calculate the smallest integer not smaller than given value
##### Arguments
- `value` (:integer,:floating,:rational)
##### Returns
:integer
#### `clamp`
force value within given range
##### Arguments
- `number` (:integer,:floating,:rational)
- `range` (:block,:range)
##### Returns
:integer,:floating,:rational
#### `conj`
calculate the complex conjugate of given number
##### Arguments
- `number` (:complex)
##### Returns
:complex
#### `cos`
calculate the cosine of given angle
##### Arguments
- `angle` (:integer,:floating,:complex,:rational,:quantity)
##### Returns
:floating,:complex
#### `cosh`
calculate the hyperbolic cosine of given angle
##### Arguments
- `angle` (:integer,:floating,:complex,:rational,:quantity)
##### Returns
:floating,:complex
#### `csec`
calculate the cosecant of given angle
##### Arguments
- `angle` (:integer,:floating,:complex,:rational,:quantity)
##### Returns
:floating,:complex
#### `csech`
calculate the hyperbolic cosecant of given angle
##### Arguments
- `angle` (:integer,:floating,:complex,:rational,:quantity)
##### Returns
:floating,:complex
#### `ctan`
calculate the cotangent of given angle
##### Arguments
- `angle` (:integer,:floating,:complex,:rational,:quantity)
##### Returns
:floating,:complex
#### `ctanh`
calculate the hyperbolic cotangent of given angle
##### Arguments
- `angle` (:integer,:floating,:complex,:rational,:quantity)
##### Returns
:floating,:complex
#### `denominator`
get the denominator of given number
##### Arguments
- `number` (:integer,:floating,:rational)
##### Returns
:integer
#### `digits`
convert a number into an array of digits or an array of digits back into a number
##### Arguments
- `number` (:integer,:block)
##### Options
- `base` (:integer): use given based (default: 10)
##### Returns
:block
#### `epsilon`
the constant e, Euler's number
#### `even?`
check if given number is even
##### Arguments
- `number` (:integer)
##### Returns
:logical
#### `exp`
calculate the exponential function for given value
##### Arguments
- `value` (:integer,:floating,:complex,:rational)
##### Returns
:floating,:complex
#### `factorial`
calculate the factorial of given value
##### Arguments
- `value` (:integer)
##### Returns
:integer
#### `factors`
get list of factors for given integer
##### Arguments
- `number` (:integer)
##### Options
- `prime` (:logical): prime factorization
##### Returns
:block
#### `floor`
calculate the largest integer not greater than given value
##### Arguments
- `value` (:integer,:floating,:rational)
##### Returns
:integer
#### `gamma`
calculate the gamma function for given value
##### Arguments
- `value` (:integer,:floating,:rational)
##### Returns
:floating
#### `gcd`
calculate greatest common divisor for given collection of integers
##### Arguments
- `numbers` (:block)
##### Returns
:integer
#### `hypot`
calculate the hypotenuse of a right-angle triangle with given base and height
##### Arguments
- `base` (:integer,:floating,:rational)
- `height` (:integer,:floating,:rational)
##### Returns
:floating
#### `infinite`
the IEEE floating point value of positive infinity
#### `infinite?`
check whether given value is an infinite one
##### Arguments
- `value` (:any)
##### Returns
:logical
#### `lcm`
calculate least common multiplier for given collection of integers
##### Arguments
- `numbers` (:block)
##### Returns
:integer
#### `ln`
calculate the natural logarithm of given value
##### Arguments
- `value` (:integer,:floating,:complex,:rational)
##### Returns
:floating,:complex
#### `log`
calculate the logarithm of value using given base
##### Arguments
- `value` (:integer,:floating,:rational)
- `base` (:integer,:floating,:rational)
##### Returns
:floating
#### `negative?`
check if given number is negative
##### Arguments
- `number` (:integer,:floating,:complex,:rational)
##### Returns
:logical
#### `numerator`
get the numerator of given number
##### Arguments
- `number` (:integer,:floating,:rational)
##### Returns
:integer
#### `odd?`
check if given number is odd
##### Arguments
- `number` (:integer)
##### Returns
:logical
#### `pi`
the number pi, mathematical constant
#### `positive?`
check if given number is positive
##### Arguments
- `number` (:integer,:floating,:complex,:rational)
##### Returns
:logical
#### `powmod`
modular exponentation: calculate the result of (base^exponent) % divider
##### Arguments
- `base` (:integer)
- `exponent` (:integer)
- `divider` (:integer)
##### Returns
:null,:integer
#### `prime?`
check if given integer is prime
##### Arguments
- `number` (:integer)
##### Returns
:logical
#### `product` (alias: `∏` - infix: false)
calculate the product of all values in given list
##### Arguments
- `collection` (:block,:range)
##### Options
- `cartesian` (:logical): return the cartesian product of given sublists
##### Returns
:integer,:floating,:rational
#### `random`
get a random integer between given limits
##### Arguments
- `lowerLimit` (:integer,:floating,:rational)
- `upperLimit` (:integer,:floating,:rational)
##### Returns
:integer,:floating
#### `reciprocal`
calculate the reciprocal of given number
##### Arguments
- `value` (:integer,:floating,:rational)
##### Returns
:rational
#### `round`
round given value
##### Arguments
- `value` (:integer,:floating,:rational)
##### Options
- `to` (:integer): round to given decimal places
##### Returns
:floating
#### `sec`
calculate the secant of given angle
##### Arguments
- `angle` (:integer,:floating,:complex,:rational,:quantity)
##### Returns
:floating,:complex
#### `sech`
calculate the hyperbolic secant of given angle
##### Arguments
- `angle` (:integer,:floating,:complex,:rational,:quantity)
##### Returns
:floating,:complex
#### `sin`
calculate the sine of given angle
##### Arguments
- `angle` (:integer,:floating,:complex,:rational,:quantity)
##### Returns
:floating,:complex
#### `sinh`
calculate the hyperbolic sine of given angle
##### Arguments
- `angle` (:integer,:floating,:complex,:rational,:quantity)
##### Returns
:floating,:complex
#### `sqrt`
get square root of given value
##### Arguments
- `value` (:integer,:floating,:complex,:rational)
##### Options
- `integer` (:logical): get the integer square root
##### Returns
:floating
#### `sum` (alias: `∑` - infix: false)
calculate the sum of all values in given list
##### Arguments
- `collection` (:block,:range)
##### Returns
:integer,:floating,:rational
#### `tan`
calculate the tangent of given angle
##### Arguments
- `angle` (:integer,:floating,:complex,:rational,:quantity)
##### Returns
:floating,:complex
#### `tanh`
calculate the hyperbolic tangent of given angle
##### Arguments
- `angle` (:integer,:floating,:complex,:rational,:quantity)
##### Returns
:floating,:complex
#### `tau`
the number tau, mathematical constant
### Paths
Functions for path manipulation and information retrieval

----

The Paths module provides functionality for manipulating file system paths and extracting components from paths and URLs.

#### Key Concepts

- Path manipulation and normalization
- Path component extraction
- URL parsing
- Path type checking
- Relative path handling

#### Basic Usage

##### Path Components

```arturo
path: "photos/vacation/beach.jpg"

; extract components
extract.directory path          ; photos/vacation
extract.filename path           ; beach
extract.extension path          ; .jpg
extract.basename path           ; beach.jpg

; check path attributes
absolute? "/Users"              ; => true
absolute? "photos/img.jpg"      ; => false
```

##### URL Components

```arturo
url: "https://example.com:8080/path/page.html?q=term#section"

; extract URL parts
print extract.scheme url        ; https
print extract.host url          ; example.com
print extract.port url          ; 8080
print extract.path url          ; /path/page.html
print extract.query url         ; q=term
print extract.anchor url        ; section
```

##### Path Normalization

```arturo
; normalize paths (resolve . and ..)
print normalize "./folder/../file.txt"      ; file.txt

; force treating string as file
print normalize.executable "script"         ; ./script

; expand tildes
print normalize.tilde "~/code"              ; /home/user/code
```

##### Relative Paths

```arturo
; get path relative to current script
read relative "some/file.txt"           ; based on script location

; the exact same thing (and more natural-looking)
read ./"some/file.txt"
```

#### Common Patterns

##### Path Building

```arturo
pathBuilder: function [components][
    path: "/"
    loop components 'comp [
        normalized: normalize comp
        'path ++ normalized ++ "/"
    ]
    return normalize path
]

; usage
fullPath: pathBuilder ["home" "user" "documents" "file.txt"]

print fullPath
; /home/user/documents/file.txt
```

##### URL Parsing Helper

```arturo
parseUrl: function [url][
    extracted: extract url
    #[
        protocol: extracted\scheme
        domain: extracted\host
        port: extracted\port
        endpoint: extracted\path
        params: extracted\query
    ]
]

; usage
components: parseUrl "https://api.example.com:8080/v1/users?active=true"

print ["API Version:" components\endpoint]
; API Version: /v1/users 
```

##### Working with Extensions

```arturo
getFileType: function [filepath][
    ext: extract.extension filepath
    case ext [
        ".txt" -> "text file"
        ".jpg" -> "image file"
        ".mp3" -> "audio file"
        ".mp4" -> "video file"
        any    -> "unknown file type"
    ]
]

; usage
print getFileType "document.txt"    ; text file
```

##### Path Checks

```arturo
validatePath: function [filepath][
    p: filepath
    if not? absolute? p ->
        p: normalize relative p
    
    ensure exists? p
    ensure file? p
    
    return p
]

; usage
if error? try [
    file: validatePath "setting.cfg"
    print ["Valid file:" file]
][
    print "Invalid or missing file"
]
```

----

#### `absolute?`
check if given path is an absolute path
##### Arguments
- `path` (:string)
##### Returns
:logical
#### `extract`
extract components from path
##### Arguments
- `path` (:string,:color)
##### Options
- `directory` (:logical): get path directory
- `basename` (:logical): get path basename (filename+extension)
- `filename` (:logical): get path filename
- `extension` (:logical): get path extension
- `scheme` (:logical): get scheme field from URL
- `host` (:logical): get host field from URL
- `port` (:logical): get port field from URL
- `user` (:logical): get user field from URL
- `password` (:logical): get password field from URL
- `path` (:logical): get path field from URL
- `query` (:logical): get query field from URL
- `anchor` (:logical): get anchor field from URL
- `red` (:logical): get red component from color
- `green` (:logical): get green component from color
- `blue` (:logical): get blue component from color
- `alpha` (:logical): get alpha component from color
- `hsl` (:logical): get HSL representation from color
- `hsv` (:logical): get HSV representation from color
- `hue` (:logical): get hue component from color
- `saturation` (:logical): get saturation component from color
- `luminosity` (:logical): get luminosity component from color
##### Returns
:string,:dictionary
#### `list`
get files in given path
##### Arguments
- `path` (:string)
##### Options
- `recursive` (:logical): perform recursive search
- `relative` (:logical): get relative paths
##### Returns
:block
#### `normalize`
get normalized version of given path
##### Arguments
- `path` (:string,:literal,:pathliteral)
##### Options
- `executable` (:logical): treat path as executable
- `tilde` (:logical): expand tildes in path
##### Returns
:string,:nothing
#### `relative` (alias: `./` - infix: false)
get relative path for given path, based on current script's location
##### Arguments
- `path` (:string)
##### Returns
:string
### Quantities
Functions related to Quantities, physical units and constants

----

The Quantities module provides comprehensive support for physical quantities and units. It includes a wide range of physical properties, SI units, derived units, and constants, with automatic unit conversion and dimensional analysis.

#### Key Concepts

- Physical quantities with units (like "5 meters" or "72 kilometers per hour")
- Support for all SI base units and derived units
- Automatic unit conversion and compatibility checking
- Physical constants
- Dimensional analysis
- Support for currency units

#### Basic Usage

##### Creating Quantities

```arturo
; basic quantities
distance: 100`m         ; 100 meters
time: 9.5`s             ; 9.5 seconds
mass: 75`kg             ; 75 kilograms

; derived units
speed: 60`km/h          ; 60 kilometers per hour
force: 10`N             ; 10 newtons
energy: 50`kWh          ; 50 kilowatt-hours
```

##### Unit Conversions

```arturo
dist: 5`km
print convert dist `m           ; 5000 m

; or using the infix operator
print dist --> `m               ; 5000 m

speed: 90`km/h
print speed --> `m/s            ; 25 m/s

temp: 25`degC
print temp --> `degF            ; 77°F
```

##### Unit Compatibility

```arturo
length1: 5`m
length2: 3`km

; compatible units can be used in calculations
total: length1 + (length2 --> `m)
print total                    ; 3005 m

speed: 100`km/h
time: 2.5`h

; dimensional analysis works automatically
distance: speed * time
print distance                 ; 250 km
```

##### Working with Currencies

```arturo
price: 50`USD
euros: price --> `EUR
print euros                    ; 47.77 € (depends on the current
                               ;          exchange rate, obviously...)

salary: 5000`USD/mo
yearly: salary * 12
print yearly                   ; 60000 $/mo
```

#### Common Patterns

##### Complex Unit Calculations

```arturo
; calculating power
voltage: 220`V
current: 5`A
power: voltage * current
print power                    ; 1100 V·A

; calculating energy cost
time: 2`h
energy: power * time
price: 0.15`USD/kWh
cost: price * (energy --> `kWh)
print cost                     ; 0.33 $
```

##### Using Physical Constants

```arturo
; gravitational force
G: gravitationalConstant
m1: 5.97e24`kg                  ; mass of Earth
m2: 75`kg                       ; mass of a person
r: 6371000`m                    ; Earth's radius
force: G * m1 * m2 / (r * r)
print to :floating force        ; 736.2513565961324
```

#### Available Properties

Physical quantities in Arturo are classified by their properties. Here are some key properties and their dimensions:

| Property | Dimensions | Example |
|----------|------------|---------|
| Length | L | `5`m |
| Time | T | `10`s |
| Mass | M | `75`kg |
| Current | I | `5`A |
| Temperature | K | `20`degC |
| Amount | N | `2`mol |
| Luminosity | J | `100`cd |
| Speed | L·T⁻¹ | `60`km/h |
| Acceleration | L·T⁻² | `9.81`m/s2 |
| Force | L·M·T⁻² | `10`N |
| Energy | L²·M·T⁻² | `100`J |
| Power | L²·M·T⁻³ | `1000`W |

> [!NOTE] There are many more properties available. Use `property` to inspect any quantity's dimensional formula.

#### Prefixes

Metric prefixes are supported for most units:

| Prefix | Symbol | Factor |
|--------|--------|--------|
| atto | a | 10⁻¹⁸ |
| femto | f | 10⁻¹⁵ |
| pico | p | 10⁻¹² |
| nano | n | 10⁻⁹ |
| micro | μ | 10⁻⁶ |
| milli | m | 10⁻³ |
| kilo | k | 10³ |
| mega | M | 10⁶ |
| giga | G | 10⁹ |
| tera | T | 10¹² |
| peta | P | 10¹⁵ |
| exa | E | 10¹⁸ |

> [!NOTE] Most units that allow prefixes can use any SI prefix (from atto- to exa-). Prefixes change the unit by the corresponding power of 10.

#### Supported Units

##### Base SI Units
| Unit | Symbol | Property | Example |
|------|---------|----------|----------|
| meter | m | Length | `5`m |
| second | s | Time | `10`s |
| kelvin | K | Temperature | `300`K |
| gram | g | Mass | `500`g |
| ampere | A | Current | `2`A |
| mole | mol | Substance | `1`mol |
| candela | cd | Luminosity | `100`cd |

##### Length Units
| Unit | Symbol | Definition | Note |
|------|--------|------------|------|
| inch | in | 127/5000 m | |
| foot | ft | 12 in | |
| yard | yd | 3 ft | |
| mile | mi | 5280 ft | |
| nautical mile | nmi | 1852 m | |
| angstrom | Å | 10⁻¹⁰ m | |
| light year | ly | 9.461e15 m | |
| astronomical unit | au | 1.496e11 m | |
| pixel | px | 1/96 in | |
| point | pt | 1/72 in | |

##### Area Units
| Unit | Symbol | Definition |
|------|---------|------------|
| acre | ac | 4840 yd² |
| hectare | ha | 10000 m² |
| barn | b | 100 ftm² |

##### Volume Units
| Unit | Symbol | Definition |
|------|---------|------------|
| liter | L | 1000 cm³ |
| gallon | gal | 231 in³ |
| barrel | bbl | 42 gal |
| quart | qt | 1/4 gal |
| pint | p | 1/2 qt |
| cup | cup | 1/2 p |
| fluid ounce | floz | 1/8 cup |
| bushel | bu | 2150.42 in³ |
| cord | cord | 128 ft³ |

##### Mass Units
| Unit | Symbol | Definition |
|------|---------|------------|
| pound | lb | 0.45359237 kg |
| ounce | oz | 1/16 lb |
| stone | st | 14 lb |
| ton | ton | 2000 lb |
| metric ton | t | 1000 kg |
| carat | ct | 0.2 g |
| grain | gr | 64.79891 mg |

##### Time Units
| Unit | Symbol | Definition |
|------|---------|------------|
| minute | min | 60 s |
| hour | h | 60 min |
| day | day | 24 h |
| week | wk | 7 day |
| month | mo | 2629746 s |
| year | yr | 31556952 s |

##### Speed Units
| Unit | Symbol | Definition |
|------|---------|------------|
| kilometers per hour | km/h | 1000/3600 m/s |
| miles per hour | mph | 5280/3600 ft/s |
| knot | kn | 1852/3600 m/s |
| mach | mach | 340.29 m/s |

##### Force Units
| Unit | Symbol | Definition |
|------|---------|------------|
| newton | N | 1 kg·m/s² |
| dyne | dyn | 10⁻⁵ N |
| pound-force | lbf | 4.44822 N |

##### Pressure Units
| Unit | Symbol | Definition |
|------|---------|------------|
| pascal | Pa | 1 N/m² |
| bar | bar | 100000 Pa |
| atmosphere | atm | 101325 Pa |
| torr | Torr | 133.3224 Pa |
| psi | psi | 6894.76 Pa |

##### Energy Units
| Unit | Symbol | Definition |
|------|---------|------------|
| joule | J | 1 N·m |
| watt-hour | Wh | 3600 J |
| calorie | cal | 4.184 J |
| electron volt | eV | 1.602e-19 J |
| BTU | BTU | 1055.06 J |

##### Power Units
| Unit | Symbol | Definition |
|------|---------|------------|
| watt | W | 1 J/s |
| horsepower | hp | 745.7 W |

##### Electric Units
| Unit | Symbol | Definition |
|------|---------|------------|
| volt | V | 1 W/A |
| ohm | Ω | 1 V/A |
| farad | F | 1 C/V |
| henry | H | 1 V·s/A |
| weber | Wb | 1 V·s |
| tesla | T | 1 Wb/m² |

##### Angle Units
| Unit | Symbol | Definition |
|------|---------|------------|
| radian | rad | base unit |
| degree | ° | π/180 rad |
| arcminute | ' | π/10800 rad |
| arcsecond | " | π/648000 rad |

##### Radiation Units
| Unit | Symbol | Definition |
|------|---------|------------|
| becquerel | Bq | 1/s |
| gray | Gy | 1 J/kg |
| sievert | Sv | 1 J/kg |

##### Information Units
| Unit | Symbol | Definition |
|------|---------|------------|
| byte | B | base unit |
| bit | b | 1/8 B |
| kibibyte | KiB | 1024 B |
| mebibyte | MiB | 1024 KiB |
| gibibyte | GiB | 1024 MiB |
| tebibyte | TiB | 1024 GiB |

> [!TIP] Arturo supports many world currencies including: AED, ALL, ARS, AUD, BGN, BHD, BND, BOB, BRL, BWP, CAD, CHF, CLP, CNY, COP, CRC, CZK, DKK, DOP, DZD, EGP, ETB, EUR, FJD, GBP, HKD, HNL, HRK, HUF, IDR, ILS, INR, IRR, ISK, JMD, JOD, JPY, KES, KRW, KWD, KYD, KZT, LBP, LKR, MAD, MDL, MKD, MXN, MUR, MYR, NAD, NGN, NIO, NOK, NPR, NZD, OMR, PAB, PEN, PGK, PHP, PKR, PLN, PYG, QAR, RON, RSD, RUB, SAR, SCR, SEK, SGD, SLL, SOS, SVC, THB, TND, TRY, TTD, TWD, TZS, UAH, UGX, UYU, UZS, VES, VND, XAF, XOF, YER, ZAR, ZMW.
> 
> Cryptocurrency codes are also supported: BTC (Bitcoin), ETH (Ethereum), BNB (Binance Coin).

----

#### `alphaParticleMass`
the mass of an alpha particle
#### `angstromStar`
one ten-billionth of a meter
#### `atomicMass`
the mass of an atomic mass unit
#### `avogadroConstant`
the number of atoms in 12 grams of carbon-12
#### `bohrRadius`
the radius of the first Bohr orbit of the hydrogen atom
#### `boltzmannConstant`
the ratio of the universal gas constant to Avogadro's number
#### `classicalElectronRadius`
the radius of an electron
#### `conductanceQuantum`
the conductance of a superconductor
#### `conforms?` (alias: `:=` - infix: true)
check if given quantities/units are compatible
##### Arguments
- `a` (:unit,:quantity)
- `b` (:unit,:quantity)
##### Returns
:logical
#### `convert` (alias: `-->` - infix: true)
convert quantity to given unit
##### Arguments
- `value` (:integer,:floating,:rational,:quantity)
- `unit` (:string,:word,:literal,:unit)
##### Returns
:quantity
#### `deuteronMass`
the mass of a deuteron
#### `electronCharge`
the charge of an electron
#### `electronMass`
the mass of an electron
#### `electronMassEnergy`
the energy equivalent of the mass of an electron
#### `gravitationalConstant`
the gravitational constant
#### `hartreeEnergy`
the energy of the ground state of the hydrogen atom
#### `helionMass`
the mass of a helion
#### `impedanceOfVacuum`
the impedance of free space
#### `in`
convert quantity to given unit
##### Arguments
- `unit` (:string,:word,:literal,:unit)
- `value` (:integer,:floating,:rational,:quantity)
##### Returns
:quantity
#### `inverseConductanceQuantum`
the inverse of the conductance of a superconductor
#### `josephsonConstant`
The inverse of the flux quantum
#### `magneticFluxQuantum`
the magnetic flux of a superconductor
#### `molarGasConstant`
the universal gas constant
#### `muonMass`
the mass of a muon
#### `neutronMass`
the mass of a neutron
#### `planckConstant`
the ratio of the energy of a photon to its frequency
#### `planckLength`
the length of the Planck scale
#### `planckMass`
the mass of the Planck scale
#### `planckTemperature`
the temperature of the Planck scale
#### `planckTime`
the time of the Planck scale
#### `property`
get the described property of given quantity or unit
##### Arguments
- `quantity` (:unit,:quantity)
##### Options
- `hash` (:logical): get property as a hash
##### Returns
:integer,:literal
#### `protonMass`
the mass of a proton
#### `protonMassEnergy`
the energy equivalent of the mass of a proton
#### `reducedPlanckConstant`
the ratio of the energy of a photon to its frequency
#### `rydbergConstant`
the Rydberg constant
#### `scalar`
get quantity value in the appropriate numeric type
##### Arguments
- `value` (:quantity)
##### Returns
:integer,:floating,:rational
#### `specify`
define new user unit
##### Arguments
- `name` (:string,:literal)
- `value` (:unit,:quantity)
##### Options
- `symbol` (:string): define main unit symbol
- `describes` (:string): set corresponding property for new unit
- `property` (:logical): define a new property
##### Returns
:literal
#### `speedOfLight`
the speed of light in a vacuum
#### `standardGasVolume`
the volume of one mole of an ideal gas at standard temperature and pressure
#### `standardPressure`
the standard pressure
#### `standardTemperature`
the standard temperature
#### `tauMass`
the mass of a tau
#### `thomsonCrossSection`
the cross section of an electron
#### `tritonMass`
the mass of a triton
#### `units`
get the units of given quantity
##### Arguments
- `value` (:unit,:quantity)
##### Options
- `base` (:logical): get base units
##### Returns
:unit
#### `vacuumPermeability`
the permeability of free space
#### `vacuumPermittivity`
the permittivity of free space
#### `vonKlitzingConstant`
the resistance of a superconductor
### Reflection
Functions and helpers for retrieving runtime information about different objects, components, or types

----

The Reflection module provides tools for runtime introspection and program analysis. From inspecting variables to benchmarking code, it offers comprehensive capabilities for understanding and analyzing your program's behavior.

#### Key Concepts

- Runtime information retrieval
- Symbol and attribute inspection
- Performance measurement
- Stack examination

#### Basic Usage

##### Inspecting Values

```arturo
value: [1 2 #[name: "John"] [nested block]]

; detailed inspection
inspect value     ; shows full structure with types

; get information about function/symbol
info 'print      ; shows details about 'print function
info.get 'print  ; returns info as dictionary

; get current stack
print stack      ; shows current value stack (as a block)
```

##### Working with Attributes

```arturo
doSth function [x][
    ; check if attribute exists
    if attr? 'verbose -> 
        print "verbose mode on"

    ; get attribute value
    level: attr 'level    ; returns null if not set

    ; get all attributes
    options: attrs        ; returns dictionary of all set attributes
]
```

##### Symbol Management

```arturo
; get all defined symbols
syms: symbols       ; returns dictionary of all symbols

; check if symbol exists
print set? 'x       ; true if 'x is defined

; get function arity
funcs: arity        ; get dictionary of function arities

print arity\add     ; 2 (which is the number of parameters `add` takes ;-)) 
```

##### Performance Measurement

```arturo
; basic benchmarking
benchmark [
    loop 1..1000 'x [
        ; some operation
    ]
]

; with the .get attribute
elapsed: benchmark.get [
    ; some operation
]
print ["Operation took:" elapsed]

; multiple runs for better accuracy
total: 0
loop 1..100 'run [
    'total ++ benchmark.get [
        ; operation to measure
    ]
]
average: total / 100
```

#### Common Patterns

##### Function Analysis

```arturo
; get complete function information
analyzeFunction: function [funcName][
    info: info.get funcName
    
    print ["Function:" funcName]
    print ["Type:" info\type]
    print ["Arguments:" info\args]
    print ["Returns:" info\returns]
    if key? info 'options [
        print ["Options:" info\options]
    ]
]

analyzeFunction 'split
; Function: split 
; Type: :function 
; Arguments: [collection:[:string :literal :pathliteral :block]] 
; Returns: [:block :nothing] 
```

##### Performance Profiling

```arturo
; simple profiling helper
profile: function [label operation][
    print ["Profiling:" label]
    
    ; multiple runs for stability
    times: []
    loop 1..10 'run [
        'times ++ to :floating benchmark.get operation
    ]
    
    ; calculate statistics
    avg: average times
    dev: deviation times
    
    print ["Average:" avg "±" dev "seconds"]
]

; usage example
profile "array sorting" [
    sort [5 3 8 1 9 2 7 4 6 0]
]
```

> [!TIP] When benchmarking, always run multiple iterations to get stable results and consider system load variations.

##### Runtime Information

```arturo
; check execution context
if standalone? [
    ; very useful in the case of "importable" modules/packages
    ; or when you want to inject some tiny bit of testing code, etc...
    print "Running as standalone script"
]
```

----

#### `arity`
get index of function arities
##### Returns
:dictionary
#### `attr`
get given attribute, if it exists
##### Arguments
- `name` (:string,:literal)
##### Returns
:null,:any
#### `attr?`
check if given attribute exists
##### Arguments
- `name` (:string,:literal)
##### Returns
:logical
#### `attrs`
get dictionary of set attributes
##### Returns
:dictionary
#### `benchmark`
benchmark given code
##### Arguments
- `action` (:block,:bytecode)
##### Options
- `get` (:logical): get benchmark time
##### Returns
:floating,:nothing
#### `info`
print info for given symbol
##### Arguments
- `symbol` (:string,:word,:literal,:pathliteral,:symbolliteral)
##### Options
- `get` (:logical): get information as dictionary
##### Returns
:dictionary,:nothing
#### `inspect`
print full dump of given value to screen
##### Arguments
- `value` (:any)
##### Options
- `muted` (:logical): don't use color output
##### Returns
:nothing
#### `methods`
get list of methods for given object or module
##### Arguments
- `object` (:object,:module)
##### Returns
:block
#### `stack`
get current stack
##### Returns
:dictionary
#### `standalone?`
checks if current script runs from the command-line
##### Returns
:logical
#### `symbols`
get currently defined symbols
##### Returns
:dictionary
### Sets
Common functions and operations for sets (union, intersection, difference, etc)

----

The Sets module provides functions for performing set theory operations on blocks. It includes all standard set operations and set relationship tests.

#### Key Concepts

- Sets are represented using blocks (duplicate values are handled automatically)
- Standard set operations (union, intersection, difference)
- Set relationship tests (subset, superset)
- Support for powerset generation

#### Basic Usage

##### Basic Set Operations

```arturo
A: [1 2 3 4]
B: [3 4 5 6]

union A B               ; => [1 2 3 4 5 6]
intersection A B        ; => [3 4]
difference A B          ; => [1 2]
```

##### Set Relationships

```arturo
X: [1 2 3]
Y: [1 2 3 4]

subset? X Y             ; true
subset?.proper X Y      ; true
superset? Y X           ; true

; check if sets have common elements
intersect? X Y          ; true
disjoint? X Y           ; false
```

> [!NOTE] A proper subset/superset means that one set must be strictly smaller/larger than the other - they cannot be equal.

##### Powerset Generation

```arturo
print powerset [1 2 3]       
; [] [1] [2] [1 2] [3] [1 3] [2 3] [1 2 3] 
```

> [!NOTE] The powerset contains all possible subsets of a set, including the empty set and the set itself.

#### Common Patterns

##### Symmetric Difference

```arturo
A: [1 2 3 4]
B: [3 4 5 6]

; elements that are in either set but not in both
print difference.symmetric A B  ; 1 2 5 6
```

##### Set Operations with Multiple Sets

```arturo
sets: [[1 2] [2 3] [3 4]]

result: fold sets => intersection
; []

unionAll: fold sets => union  
; [1 2 3 4]
```

----

#### `difference`
return the difference of given sets
##### Arguments
- `setA` (:literal,:pathliteral,:block)
- `setB` (:block)
##### Options
- `symmetric` (:logical): get the symmetric difference
##### Returns
:block,:nothing
#### `disjoint?`
check if given sets are disjoint (they have no common elements)
##### Arguments
- `setA` (:block)
- `setB` (:block)
##### Returns
:logical
#### `intersect?`
check if given sets intersect (they have at least one common element)
##### Arguments
- `setA` (:block)
- `setB` (:block)
##### Returns
:logical
#### `intersection` (alias: `∩` - infix: true)
return the intersection of given sets
##### Arguments
- `setA` (:literal,:pathliteral,:block)
- `setB` (:block)
##### Returns
:block,:nothing
#### `powerset`
return the powerset of given set
##### Arguments
- `set` (:literal,:pathliteral,:block)
##### Returns
:block,:nothing
#### `subset?` (alias: `⊆` - infix: true)
check if given set is a subset of second set
##### Arguments
- `setA` (:block)
- `setB` (:block)
##### Options
- `proper` (:logical): check if proper subset
##### Returns
:logical
#### `superset?` (alias: `⊇` - infix: true)
check if given set is a superset of second set
##### Arguments
- `setA` (:block)
- `setB` (:block)
##### Options
- `proper` (:logical): check if proper superset
##### Returns
:logical
#### `union` (alias: `∪` - infix: true)
return the union of given sets
##### Arguments
- `setA` (:literal,:pathliteral,:block)
- `setB` (:block)
##### Returns
:block,:nothing
### Sockets
High-level socket interface and relevant socket communication methods

----

The Sockets module provides a straightforward way to handle network communication using TCP/UDP sockets. Rather than dealing with low-level details, you can focus on building networked applications with just a few simple functions.

#### Key Concepts

- Server sockets listen for incoming connections
- Client sockets connect to servers
- Messages can be sent/received as strings
- Both TCP (default) and UDP protocols are supported

#### Basic Usage

##### Creating a Server

```arturo
server: listen 8000
print "Server listening on port 8000..."
```

> [!IMPORTANT] Always remember to `unplug` your sockets when you're done with them to free up system resources.

##### Accepting Connections & Handling Messages

```arturo
; accept new client
client: accept server

; send a message
send client "hello!"

; receive a message
message: receive.timeout:1000 client    ; timeout after 1 second if no message
```

> [!CAUTION] Watch out for message sizes when using receive: for large ones, consider implementing a chunking strategy or using a protocol with clear message boundaries.

##### Using UDP

When you need faster, connectionless communication:

```arturo
server: listen.udp 8000
```

> [!WARNING] UDP messages may arrive out of order or not at all. Only use UDP when your application can handle message loss.

#### Common Patterns

##### Echo Server

A minimal TCP server that echoes back messages:

```arturo
; server.art
server: listen 8000

print "Server listening on port 8000..."
while [true][
    client: accept server
    message: receive client
    send client ~"got: |message|"
    unplug client    ; clean up when done
]
```

And its corresponding client:

```arturo
; client.art
client: connect.to:"localhost" 8000
send client "hello server!"
print receive client
unplug client
```

##### Multi-Client Chat Server

A more complete example showing how to handle multiple clients:

```arturo
server: listen 8000
clients: []

print "Chat server started..."
while [true][
    ; accept new connection
    client: accept server
    'clients ++ client
    
    ; broadcast arrival
    loop clients 'c [
        if c <> client ->
            send c "* new user joined *"
    ]
    
    ; handle messages
    ; note: in a real implementation, you'd want to handle
    ; client disconnections and cleanup as well
    while [true][
        message: receive client
        if empty? message -> break
        
        ; broadcast to all other clients
        loop clients 'c [
            if c <> client ->
                send c message
        ]
    ]
]
```

----

#### `accept`
accept incoming connection and return corresponding socket
##### Arguments
- `server` (:socket)
##### Returns
:socket
#### `connect`
create new socket connection to given server port
##### Arguments
- `port` (:integer)
##### Options
- `to` (:string): set socket address
- `udp` (:logical): use UDP instead of TCP
##### Returns
:socket
#### `listen`
start listening on given port and return new socket
##### Arguments
- `port` (:integer)
##### Options
- `udp` (:logical): use UDP instead of TCP
##### Returns
:socket
#### `receive`
receive line of data from selected socket
##### Arguments
- `origin` (:socket)
##### Options
- `size` (:integer): set maximum size of received data
- `timeout` (:integer): set timeout (in milliseconds)
##### Returns
:string
#### `send`
send given message to selected socket
##### Arguments
- `destination` (:socket)
- `message` (:string)
##### Options
- `chunk` (:logical): don't send data as a line of data
##### Returns
:nothing
#### `send?`
send given message to selected socket and return true if successful
##### Arguments
- `destination` (:socket)
- `message` (:string)
##### Returns
:logical
#### `unplug`
close given socket
##### Arguments
- `socket` (:socket)
##### Returns
:nothing
### Statistics
Functions and helpers for working with statistics and samples

----

The Statistics module provides essential functions for statistical analysis of numerical data. From basic averages to more complex statistical measures like variance and kurtosis, it offers everything you need for common statistical operations.

#### Key Concepts

- Works with collections of numbers (blocks and ranges)
- Supports both population and sample statistics
- All operations handle integer, floating and rational numbers
- Results are always returned as floating-point numbers for maximum precision

#### Basic Usage

##### Getting Averages and Medians

```arturo
data: [1 2 3 5 7]

avg: average data     ; => 3.6
med: median data      ; => 3

; works with ranges too!
print average 1..100  ; 50.5
```

> [!NOTE] `average` and `median` both require the data to be numeric. For mixed data types, make sure to filter non-numeric values first.

##### Calculating Variance and Standard Deviation

```arturo
numbers: [2 4 4 4 5 5 7 9]

; population statistics (default)
print deviation numbers      ; 2.0
print variance numbers       ; 4.0

; sample statistics
print deviation.sample numbers  ; 2.138089935299395
print variance.sample numbers   ; 4.571428571428571
```

> [!TIP] Use sample statistics (with the `.sample` attribute) when working with data that represents a subset of a larger population.

##### Distribution Analysis

```arturo
data: [1 2 2 3 3 3 4 4 5]

; check how the distribution leans
print round.to:3 skewness data         ; 0.0    (symmetric)
print round.to:3 kurtosis data         ; -0.75  (platykurtic)

; for sample data
print round.to:3 skewness.sample data  ; 0.0
print round.to:3 kurtosis.sample data  ; -0.286
```

#### Common Patterns

##### Basic Statistical Summary

A common task is getting a quick overview of your data:

```arturo
data: [12 15 18 22 25 28 32]

print ["Average:" average data]
print ["Deviation: ±" deviation data]
print ["Range:" min data ".." max data]
```

##### Outlier Detection

Using standard deviations to find potential outliers:

```arturo
scores: [75 78 82 85 85 86 89 91 92 97 98 135]
avg: average scores
dev: deviation scores

loop scores 'score [
    if (abs score - avg) > 2 * dev ->
        print ["Possible outlier:" score]
]
```

----

#### `average`
get average from given collection of numbers
##### Arguments
- `collection` (:block,:range)
##### Returns
:floating
#### `deviation`
get population standard deviation of given collection of numbers
##### Arguments
- `collection` (:block)
##### Options
- `sample` (:logical): calculate the sample standard deviation
##### Returns
:floating
#### `kurtosis`
get population kurtosis of given collection of numbers
##### Arguments
- `collection` (:block)
##### Options
- `sample` (:logical): calculate the sample kurtosis
##### Returns
:floating
#### `median`
get median from given collection of numbers
##### Arguments
- `collection` (:block)
##### Returns
:null,:integer,:floating
#### `skewness`
get population skewness of given collection of numbers
##### Arguments
- `collection` (:block)
##### Options
- `sample` (:logical): calculate the sample skewness
##### Returns
:floating
#### `variance`
get population variance of given collection of numbers
##### Arguments
- `collection` (:block)
##### Options
- `sample` (:logical): calculate the sample variance
##### Returns
:floating
### Strings
Functions and helpers for manipulating and dealing with strings or character blocks

----

The Strings module provides comprehensive functionality for string manipulation, from basic operations to advanced templating. It handles strings as Unicode character collections and offers powerful pattern matching capabilities.

#### Key Concepts

- Full Unicode support
- String interpolation and templating
- Multiple string creation syntaxes
- Pattern matching and substitution
- Case conversion and manipulation

#### Basic Usage

##### String Creation

```arturo
; basic strings
str: "hello world"

; multi-line strings
text: {
    This is a multi-line string
    that preserves formatting
    but strips common indentation
}

; verbatim strings (keep exact formatting)
code: {:
    def main():
        print("hello")
:}

; right smart-quote strings (everything until end of line)
message: « This is a single line string

; heredoc-style
data: 
------
Everything after the dashes
until the end of the file
is part of the string
------
```

##### Basic Operations

```arturo
; concatenation
full: "hello " ++ "world"    ; hello world

; case conversion
upper "hello"               ; HELLO
lower "WORLD"               ; world
capitalize "john"           ; John

; checking content
prefix? "hello" "he"        ; => true
suffix? "hello" "lo"        ; => true
contains? "hello" "ll"      ; => true

; whitespace handling
strip " hello  "            ; hello
strip.start "  hi"          ; hi
strip.end "hi  "            ; hi
```

##### Pattern Matching

```arturo
text: "hello world"

; using regex
match text {/o(.+)d/}    ; "o world"

; capturing matches
match.capture text {/([wrl]+)o/} 
; => ["ll" "w"]

; replace patterns
final: replace "hi there" "hi" "hello"
print final                  ; hello there

; with regex
result: replace "Date: 2024" {/\d+/} "2025"
print result                ; Date: 2025
```

#### Common Patterns

##### String Manipulation

```arturo
; word wrapping
text: "This is a very long line that needs to be wrapped"
print wordwrap.at:20 text
; This is a very long
; line that needs to
; be wrapped

; truncating
print truncate "Hello World" 5      ; Hello...
print truncate.with:"..." "Hello World" 5  ; Hello...

; padding
print pad.right "Price:" 10         ; Price:    
print pad.center "Title" 20         ; -------Title--------
```

##### Working with Parts

```arturo
text: "hello world"

; splitting
words: split.words text            
; ["hello" "world"]
chars: split text                  
; ["h" "e" "l" "l" "o" " " "w" "o" "r" "l" "d"]

; joining
print join.with:", " ["a" "b" "c"]      ; a, b, c

; slicing
print slice text 0 4                    ; hello
```

#### String Templates

Arturo's templating system uses pipe characters (`|...|`) for interpolation:

##### Simple Interpolation

```arturo
name: "Bill"
age: 38

; basic interpolation
print ~"Hello |name|!"                  ; Hello Bill!
print ~"I am |age| years old"           ; I am 38 years old

; with expressions
print ~"Next year I'll be |age + 1|"    ; Next year I'll be 39
```

##### Conditional Templates

```arturo
age: 30
template: {
    <||= (age > 21)? [ ||>
        You can enter the club
    <||][||>
        Sorry, too young
    <||]||>
}

print render.template template    
; You can enter the club
```

##### Loops in Templates

```arturo
items: ["apple" "banana" "orange"]
template: {
    <ul>
        <|| loop items 'item [||>
            <li>
                <||= item ||>
            </li>
        <||]||>
    </ul>
}

print render.template template
; <ul>
;     <li>
;         apple
;     </li>
;     <li>
;         banana
;     </li>
;     <li>
;         orange
;     </li>
; </ul>
```

##### Advanced Template Features

```arturo
users: @[
    #[name: "John" role: "admin"]
    #[name: "Alice" role: "user"]
]

template: {
    Users:
    <|| loop users 'user [||>
        * <||= user\name ||> 
          <||= user\role = "admin" [||>
            (Administrator)
          <||]||>
    <||]||>
}

print render.template template
; Users:
;     * John 
;       true
;     * Alice 
;       false
```

----

#### `alphabet`
get dictionary-index charset for given locale
##### Arguments
- `locale` (:string,:literal)
##### Options
- `lower` (:logical): return lowercase characters (default)
- `upper` (:logical): return uppercase characters
- `all` (:logical): also return non-dictionary characters
##### Returns
:null,:block
#### `ascii?`
check if given character/string is in ASCII
##### Arguments
- `string` (:char,:string)
##### Returns
:logical
#### `capitalize`
convert given string to capitalized
##### Arguments
- `string` (:char,:string,:literal,:pathliteral)
##### Returns
:char,:string,:nothing
#### `escape`
escape given string
##### Arguments
- `string` (:string,:literal,:pathliteral)
##### Options
- `json` (:logical): for literal use in JSON strings
- `regex` (:logical): for literal use in regular expression
- `shell` (:logical): for use in a shell command
- `xml` (:logical): for use in an XML document
##### Returns
:string,:nothing
#### `indent`
indent each line of given text
##### Arguments
- `text` (:string,:literal,:pathliteral)
##### Options
- `n` (:integer): pad by given number of spaces (default: 4)
- `with` (:string): use given padding
##### Returns
:string,:nothing
#### `jaro`
calculate Jaro distance/similarity between given strings
##### Arguments
- `stringA` (:string)
- `stringB` (:string)
##### Returns
:floating
#### `join`
join collection of values into string
##### Arguments
- `collection` (:literal,:pathliteral,:block)
##### Options
- `with` (:char,:string): use given separator
- `path` (:logical): join as path components
##### Returns
:string,:nothing
#### `levenshtein`
calculate Levenshtein distance/similarity between given strings
##### Arguments
- `stringA` (:string)
- `stringB` (:string)
##### Options
- `align` (:logical): return aligned strings
- `with` (:char): use given filler for alignment (default: -)
##### Returns
:integer,:block
#### `lower`
convert given string to lowercase
##### Arguments
- `string` (:char,:string,:literal,:pathliteral)
##### Returns
:char,:string,:nothing
#### `lower?`
check if given string is lowercase
##### Arguments
- `string` (:char,:string)
##### Returns
:logical
#### `match`
get matches within string, using given regular expression
##### Arguments
- `string` (:string)
- `regex` (:char,:string,:regex)
##### Options
- `once` (:logical): get just the first match
- `count` (:logical): just get number of matches
- `capture` (:logical): get capture groups only
- `named` (:logical): get named capture groups as a dictionary
- `bounds` (:logical): get match bounds only
- `in` (:range): get matches within given range
- `full` (:logical): get results as an array of match results
##### Returns
:integer,:dictionary,:block
#### `match?`
check if string matches given regular expression
##### Arguments
- `string` (:string)
- `regex` (:string,:regex)
##### Options
- `in` (:range): get matches within given range
##### Returns
:logical
#### `numeric?`
check if given string is numeric
##### Arguments
- `string` (:char,:string)
##### Returns
:logical
#### `outdent`
outdent each line of given text, by using minimum shared indentation
##### Arguments
- `text` (:string,:literal,:pathliteral)
##### Options
- `n` (:integer): unpad by given number of spaces
- `with` (:string): use given padding
##### Returns
:string,:nothing
#### `pad`
align string by adding given padding
##### Arguments
- `string` (:string,:literal,:pathliteral)
- `padding` (:integer)
##### Options
- `center` (:logical): add padding to both sides
- `right` (:logical): add right padding
- `with` (:char): pad with given character
##### Returns
:string
#### `prefix?`
check if string starts with given prefix
##### Arguments
- `string` (:string)
- `prefix` (:string,:regex)
##### Returns
:logical
#### `render` (alias: `~` - infix: false)
render template with |string| interpolation
##### Arguments
- `template` (:string,:literal,:pathliteral)
##### Options
- `once` (:logical): don't render recursively
- `template` (:logical): render as a template
##### Returns
:string,:nothing
#### `replace`
replace every matched substring/s by given replacement string and return result
##### Arguments
- `string` (:string,:literal,:pathliteral)
- `match` (:string,:regex,:block)
- `replacement` (:string,:block)
##### Returns
:string,:nothing
#### `strip`
strip whitespace from given string
##### Arguments
- `string` (:string,:literal,:pathliteral)
##### Options
- `start` (:logical): strip leading whitespace
- `end` (:logical): strip trailing whitespace
##### Returns
:string,:nothing
#### `suffix?`
check if string ends with given suffix
##### Arguments
- `string` (:string)
- `suffix` (:string,:regex)
##### Returns
:logical
#### `translate`
takes a dictionary of translations and replaces each instance sequentially
##### Arguments
- `string` (:string,:literal,:pathliteral)
- `translations` (:dictionary)
##### Returns
:string,:nothing
#### `truncate`
truncate string at given length
##### Arguments
- `string` (:string,:literal,:pathliteral)
- `cutoff` (:integer)
##### Options
- `with` (:string): use given filler
- `preserve` (:logical): preserve word boundaries
##### Returns
:string,:nothing
#### `upper`
convert given string to uppercase
##### Arguments
- `string` (:char,:string,:literal,:pathliteral)
##### Returns
:char,:string,:nothing
#### `upper?`
check if given string is uppercase
##### Arguments
- `string` (:char,:string)
##### Returns
:logical
#### `whitespace?`
check if given string consists only of whitespace
##### Arguments
- `string` (:string)
##### Returns
:logical
#### `wordwrap`
word wrap a given string
##### Arguments
- `string` (:string,:literal,:pathliteral)
##### Options
- `at` (:integer): use given max line width (default: 80)
##### Returns
:string
### System
Functions and helpers for interacting with the operation system and shell

----

The System module provides access to operating system functionality, environment variables, process management, and system information.

#### Key Concepts

- Environment variable access
- System information retrieval
- Process execution and management
- Command-line argument handling
- Configuration management

#### Basic Usage

##### System Information

```arturo
; get system information
print ["OS:" sys\os]              
print ["CPU Arch:" sys\cpu\arch]
print ["CPU Cores:" sys\cpu\cores]
print ["Endianness:" sys\cpu\endian]
print ["Hostname:" sys\hostname]
; OS: macos 
; CPU Arch: amd64 
; CPU Cores: 8 
; Endianness: little
; Hostname: drkameleons-MBP.home 

; get process information
proc: process
print ["PID:" proc\id]
; PID: 92123 
```

##### Environment Variables

```arturo
; access environment variables
vars: env
print ["PATH:" env\PATH]
print ["HOME:" env\HOME]

; check specific variable
if key? env 'ARTURO_HOME -> 
    print ["Arturo home:" env\ARTURO_HOME]
```

##### Command Execution

```arturo
; simple command execution
result: execute "ls -l"
print result

; with arguments as block
files: execute.args:["-l" "-a"] "ls"

; get exit code
status: execute.code "some_command"
if status <> 0 -> 
    print "Command failed!"

; asynchronous execution
pid: execute.async "long_running_process"
print ["Started process:" pid]

; direct shell execution
execute.directly "echo 'hello' > output.txt"
```

> [!TIP] Use `execute.code` when you need to check if a command succeeded, and `execute.async` for long-running processes that shouldn't block.

##### Command-line Arguments

```arturo
; access command line arguments
arg ; get raw arguments list as a block
    ; arg\0 -> first argument
    ; arg\1 -> second argument, etc...

inspect args
; with:  -a --boom --c:123 "one"
;
; [ :dictionary
;         a       :        true :logical
;         boom    :        true :logical
;         c       :        123 :integer
;         values  :        [ :block
;                  one :string
;         ]
; ]
```

#### Common Patterns

##### Process Management

```arturo
define :processManager [
    start: function [command][
        pid: execute.async command
        print ["Started process:" pid]
        return pid
    ]

    stop: function [pid][
        terminate pid
        print ["Terminated process:" pid]
    ]

    stopWithCode: function [pid code][
        terminate.code:code pid 
        print ["Terminated process:" pid "with code:" code]
    ]
]

processManager: to :processManager []!

; let's start another Arturo process
pid: processManager\start sys\binary
pause 1000
processManager\stop pid
```

##### Configuration Management

```arturo
; example configuration helper
getConfig: function [key defaultValue][
    if key? config key -> 
        return config\[key]
    
    return defaultValue
]

; usage
port: getConfig 'server_port 8080
host: getConfig 'server_host "localhost"
```

##### Path Management

```arturo
; get path information
print ["Current dir:" path\current]
print ["Home dir:" path\home]
print ["Temp dir:" path\temp]
```

##### System Checks

```arturo
; check for administrator/root privileges
if superuser? -> 
    print "Running with elevated privileges"

; check if running as standalone script
if standalone? -> 
    print "Running as standalone script"

; forcefully exit
exit
```

----

#### `arg`
get command-line arguments as a list
##### Returns
:block
#### `args`
get all command-line arguments parsed as a dictionary
##### Returns
:dictionary
#### `config`
get local or global configuration
##### Returns
:store
#### `env`
get environment variables
##### Returns
:dictionary
#### `execute`
execute given shell command
##### Arguments
- `command` (:string)
##### Options
- `args` (:block): use given command arguments
- `async` (:logical): execute asynchronously as a process and return id
- `code` (:logical): return process exit code
- `directly` (:logical): execute command directly, as a shell command
##### Returns
:string,:dictionary
#### `exit`
exit program
##### Returns
:nothing
#### `panic`
exit program with error message
##### Arguments
- `message` (:string)
##### Options
- `code` (:integer): return given exit code (default: 1)
- `unstyled` (:logical): don't use default error template
##### Returns
:logical
#### `path`
get path information
##### Returns
:dictionary
#### `pause`
pause program's execution~for the given amount of time
##### Arguments
- `time` (:integer,:quantity)
##### Returns
:nothing
#### `process`
get information on current process/program
##### Returns
:dictionary
#### `script`
get embedded information about the current script
##### Returns
:dictionary
#### `superuser?`
check if current user has administrator/root privileges
##### Returns
:logical
#### `sys`
get current system information
##### Returns
:dictionary
#### `terminate`
kill process with given id
##### Arguments
- `id` (:integer)
##### Options
- `code` (:integer): use given error code
##### Returns
:nothing
### Types
Built-in types, custom user types/objects and related helpers

----

The Types module provides the foundation for Arturo's type system, including type checking, custom type definitions, and object-oriented programming capabilities.

#### Key Concepts

- Basic type checking
- Custom type definitions
- Object creation and manipulation
- Type conversion
- Magic methods for operator overloading
- Inheritance and composition

#### Basic Usage

##### Type Checking

```arturo
; basic type checks
print type 42               ; :integer
print type "hello"          ; :string
print type [1 2 3]          ; :block

; check specific type
print integer? 42           ; true
print string? 42            ; false

; check if value is of type
print is? :integer 42       ; true
print is? :string "hi"      ; true
```

##### Custom Types

```arturo
; define new type
define :person [
    ; constructor
    init: method [name age][
        this\name: name
        this\age: age
    ]

    ; string representation
    string: method [][
        ~{|this\name| (|this\age| years old)}
    ]
]

; create instance
john: to :person ["John" 38]!

print john        
; John (38 years old)
```

> [!TIP] Within methods, you can use `\field` as a shortcut for `this\field`. This makes code more concise and readable. For example:
> ```arturo
> string: method [][
>     ; these are equivalent:
>     print this\name        ; explicit
>     print \name           ; shortcut
> ]
> ```

##### Inheritance

```arturo
; base type
define :animal [
    init: method [species][
        \species: species
    ]
    
    speak: method [][
        print "..."
    ]
]

; derived type
define :dog is :animal [
    init: method [name][
        ; call parent constructor
        super "canis"
        \name: name
    ]
    
    speak: method [][
        print "woof!"
    ]
]

; usage
fido: to :dog ["Fido"]!

print fido\species    ; canis
fido\speak           ; woof!
```

##### Type Conversions

```arturo
; basic conversions
str: to :string 42          ; "42"
num: to :integer "42"       ; 42
flt: to :floating "3.14"    ; 3.14

; with custom format
date: to :date .format:"yyyy-MM-dd" "2024-01-15"
```

#### Magic Methods

Magic methods allow you to customize how your types behave with various operations.

| Method | Arguments | Description | Example Use |
|--------|-----------|-------------|-------------|
| `init` | any | Constructor | Object initialization |
| `get` | field | Field access | `obj\field` |
| `set` | field, value | Field assignment | `obj\field: value` |
| `changing` | - | Before change hook | Pre-modification |
| `changed` | - | After change hook | Post-modification |
| `compare` | that | Custom comparison | Sort ordering |
| `equal?` | that | Equality check | `obj1 = obj2` |
| `less?` | that | Less than | `obj1 < obj2` |
| `greater?` | that | Greater than | `obj1 > obj2` |
| `add` | that | Addition | `obj1 + obj2` |
| `sub` | that | Subtraction | `obj1 - obj2` |
| `mul` | that | Multiplication | `obj1 * obj2` |
| `div` | that | Division | `obj1 / obj2` |
| `fdiv` | that | Float division | `obj1 // obj2` |
| `mod` | that | Modulo | `obj1 % obj2` |
| `pow` | that | Power | `obj1 ^ obj2` |
| `inc` | - | Increment | `inc 'obj` |
| `dec` | - | Decrement | `dec 'obj` |
| `neg` | - | Negation | `neg obj` |
| `key?` | key | Key existence | `key? obj "field"` |
| `contains?` | what | Contains check | `contains? obj item` |
| `append` | value | Add item | `'obj ++ value` |
| `remove` | value | Remove item | `'obj -- value` |
| `string` | - | String conversion | `to :string obj` |
| `integer` | - | Integer conversion | `to :integer obj` |
| `floating` | - | Float conversion | `to :floating obj` |
| `rational` | - | Rational conversion | `to :rational obj` |
| `complex` | - | Complex conversion | `to :complex obj` |
| `quantity` | - | Quantity conversion | `to :quantity obj` |
| `logical` | - | Logical conversion | `to :logical obj` |
| `block` | - | Block conversion | `to :block obj` |
| `dictionary` | - | Dictionary conversion | `to :dictionary obj` |

> [!TIP] Magic methods are optional - implement only those that make sense for your type's behavior. Also, remember that when implementing magic methods, they affect how your type behaves with standard operators and functions throughout Arturo.

#### Common Patterns

##### Implementing Comparable Objects

```arturo
define :score [
    init: method [value][
        \value: value
    ]

    ; custom comparison
    compare: method [that][
        if \value < that\value -> return neg 1
        if \value > that\value -> return 1
        return 0
    ]
]

; usage
scores: @[
    to :score [42]!
    to :score [18]!
    to :score [73]!
]

print sort scores
; [value:18] [value:42] [value:73] 
```

> [!TIP] For simple comparisons based on a single field, you can use the sortable helper instead of implementing a full `compare` method. In the above example, for instance:
> ```arturo
> ;...
> compare: sortable 'value
> ;...
> ```

##### Custom Collections

```arturo
define :stack [
    init: method [][
        \items: []
    ]

    push: method [item][
        'this\items ++ item
    ]

    pop: method [][
        if empty? \items -> return null
        return pop 'this\items
    ]

    ; custom conversion
    string: method [][
        ~{Stack(|size \items| items)}
    ]

    ; support iteration
    contains?: method [item][
        contains? \items item
    ]
]

; usage
s: to :stack []!
s\push 1
s\push 2
print s\pop     ; 2
```

##### Property Change Notifications

```arturo
define :observable [
    init: method [value][
        \value: value
        \observers: []
    ]

    changing: method [][
        loop \observers 'obs [
            obs\beforeChange \value
        ]
    ]

    changed: method [][
        loop observers 'obs [
            obs\afterChange \value
        ]
    ]

    addObserver: method [observer][
        'this\observers ++ observer
    ]
]

; usage
value: to :observable [42]!
value\addObserver #[
    beforeChange: function [val][
        print ["About to change from:" val]
    ]
    afterChange: function [val][
        print ["Changed to:" val]
    ]
]
```

----

#### `attribute?`
checks if given value is of type :attribute
##### Arguments
- `value` (:any)
##### Returns
:logical
#### `attributeLabel?`
checks if given value is of type :attributeLabel
##### Arguments
- `value` (:any)
##### Returns
:logical
#### `binary?`
checks if given value is of type :binary
##### Arguments
- `value` (:any)
##### Returns
:logical
#### `block?`
checks if given value is of type :block
##### Arguments
- `value` (:any)
##### Returns
:logical
#### `bytecode?`
checks if given value is of type :bytecode
##### Arguments
- `value` (:any)
##### Returns
:logical
#### `char?`
checks if given value is of type :char
##### Arguments
- `value` (:any)
##### Returns
:logical
#### `color?`
checks if given value is of type :color
##### Arguments
- `value` (:any)
##### Returns
:logical
#### `complex?`
checks if given value is of type :complex
##### Arguments
- `value` (:any)
##### Returns
:logical
#### `constructor`
create a type constructor method automatically using given arguments
##### Arguments
- `arguments` (:literal,:block)
##### Returns
:method
#### `database?`
checks if given value is of type :database
##### Arguments
- `value` (:any)
##### Returns
:logical
#### `date?`
checks if given value is of type :date
##### Arguments
- `value` (:any)
##### Returns
:logical
#### `define`
define new type with given prototype
##### Arguments
- `type` (:type)
- `prototype` (:type,:dictionary,:block)
##### Returns
:nothing
#### `defined?`
checks if given type is defined
##### Arguments
- `type` (:type,:string,:word,:literal)
##### Returns
:logical
#### `dictionary?`
checks if given value is of type :dictionary
##### Arguments
- `value` (:any)
##### Returns
:logical
#### `error?`
checks if given value is of type :error
##### Arguments
- `value` (:any)
##### Returns
:logical
#### `errorKind?`
checks if given value is of type :errorKind
##### Arguments
- `value` (:any)
##### Returns
:logical
#### `floating?`
checks if given value is of type :floating
##### Arguments
- `value` (:any)
##### Returns
:logical
#### `function?`
checks if given value is of type :function
##### Arguments
- `value` (:any)
##### Options
- `builtin` (:logical): check if, internally, it's a built-in
##### Returns
:logical
#### `inline?`
checks if given value is of type :inline
##### Arguments
- `value` (:any)
##### Returns
:logical
#### `integer?`
checks if given value is of type :integer
##### Arguments
- `value` (:any)
##### Options
- `big` (:logical): check if, internally, it's a bignum
##### Returns
:logical
#### `is`
get derivative type with given prototype
##### Arguments
- `type` (:type)
- `prototype` (:dictionary,:block)
##### Returns
:type
#### `is?`
check whether value is of given type
##### Arguments
- `type` (:type,:block)
- `value` (:any)
##### Returns
:logical
#### `label?`
checks if given value is of type :label
##### Arguments
- `value` (:any)
##### Returns
:logical
#### `literal?`
checks if given value is of type :literal
##### Arguments
- `value` (:any)
##### Returns
:logical
#### `logical?`
checks if given value is of type :logical
##### Arguments
- `value` (:any)
##### Returns
:logical
#### `method?`
checks if given value is of type :method
##### Arguments
- `value` (:any)
##### Returns
:logical
#### `null?`
checks if given value is of type :null
##### Arguments
- `value` (:any)
##### Returns
:logical
#### `object?`
checks if given value is a custom-type object
##### Arguments
- `value` (:any)
##### Returns
:logical
#### `path?`
checks if given value is of type :path
##### Arguments
- `value` (:any)
##### Returns
:logical
#### `pathLabel?`
checks if given value is of type :pathLabel
##### Arguments
- `value` (:any)
##### Returns
:logical
#### `pathLiteral?`
checks if given value is of type :pathLiteral
##### Arguments
- `value` (:any)
##### Returns
:logical
#### `quantity?`
checks if given value is of type :quantity
##### Arguments
- `value` (:any)
##### Options
- `big` (:logical): check if, internally, it's a bignum
##### Returns
:logical
#### `range?`
checks if given value is of type :range
##### Arguments
- `value` (:any)
##### Returns
:logical
#### `rational?`
checks if given value is of type :rational
##### Arguments
- `value` (:any)
##### Options
- `big` (:logical): check if, internally, it's a bignum
##### Returns
:logical
#### `regex?`
checks if given value is of type :regex
##### Arguments
- `value` (:any)
##### Returns
:logical
#### `socket?`
checks if given value is of type :socket
##### Arguments
- `value` (:any)
##### Returns
:logical
#### `sortable`
create a sort descriptor method automatically using given type field
##### Arguments
- `field` (:literal)
##### Returns
:method
#### `store?`
checks if given value is of type :store
##### Arguments
- `value` (:any)
##### Returns
:logical
#### `string?`
checks if given value is of type :string
##### Arguments
- `value` (:any)
##### Returns
:logical
#### `symbol?`
checks if given value is of type :symbol
##### Arguments
- `value` (:any)
##### Returns
:logical
#### `symbolLiteral?`
checks if given value is of type :symbolLiteral
##### Arguments
- `value` (:any)
##### Returns
:logical
#### `to`
convert value to given type
##### Arguments
- `type` (:type,:block)
- `value` (:any)
##### Options
- `format` (:string): use given format (for dates or floating-point numbers)
- `unit` (:string,:literal): use given unit (for quantities)
- `intrepid` (:logical): convert to bytecode without error-line tracking
- `hsl` (:logical): convert HSL block to color
- `hsv` (:logical): convert HSV block to color
##### Returns
:any
#### `type`
get type of given value
##### Arguments
- `value` (:any)
##### Returns
:type
#### `type?`
checks if given value is of type :type
##### Arguments
- `value` (:any)
##### Returns
:logical
#### `unit?`
checks if given value is of type :unit
##### Arguments
- `value` (:any)
##### Returns
:logical
#### `version?`
checks if given value is of type :version
##### Arguments
- `value` (:any)
##### Returns
:logical
#### `word?`
checks if given value is of type :word
##### Arguments
- `value` (:any)
##### Returns
:logical
### Ui
UI- and webview-related helpers

----

The UI module provides functionality for creating basic desktop interactions, managing clipboard content, and displaying web-based user interfaces through webviews.

#### Key Concepts

- System dialogs and alerts
- Clipboard operations
- Web-based interfaces via webview
- File selection dialogs
- User notifications

#### Basic Usage

##### System Dialogs

```arturo
; basic popup
result: popup "Warning" "Are you sure?"

; different dialog types
popup.info "Info" "Operation complete"
popup.warning "Warning" "Low disk space"
popup.error "Error" "Connection failed"

; with different buttons
response: popup.yesNo "Question" "Save changes?"
response: popup.okCancel "Confirm" "Proceed?"
response: popup.retryCancel "Failed" "Try again?"
```

##### System Notifications

```arturo
; basic notification
alert "Title" "Message"

; with different types
alert.info "Info" "Download complete"
alert.warning "Warning" "Battery low"
alert.error "Error" "Update failed"
```

##### File Selection

```arturo
; select file
file: dialog "Select file"

; select folder
folder: dialog.folder "Select folder"

; with starting path
config: dialog .path: "~/Documents" "Select config"
```

##### Clipboard Operations

```arturo
; set clipboard content
clip "text to copy"

; get clipboard content
text: unclip
print ["Clipboard contains:" text]
```

##### WebView Interface

```arturo
; basic webview with HTML content
webview {
    <html>
        <body>
            <h1>Hello World</h1>
        </body>
    </html>
}

; with custom window properties
webview
    .title:"My App"
    .width: 800
    .height: 600
    .fixed: true 
    .debug
{!html
    <html>
        <body>
            <h1>Custom Window</h1>
        </body>
    </html>
}
```

> [!TIP] If you are using a text editor that supports this syntax (e.g. VSCode), using `!html` in front of `{..}`-enclosed blocks will enable proper HTML highlighting.

> [!TIP] WebView's `.debug` attribute opens Chrome's DevTools for easier development and debugging.


#### Common Patterns

##### Interactive Dialog Flow

```arturo
getUserInput: function [default][
    response: popup.okCancel "Input needed" "Use default settings?"
    if response -> 
        return default
    
    file: dialog "Select custom config"
    if empty? file ->
        return default
        
    return file
]

; usage
config: getUserInput "config.ini"
```

> [!NOTE] Dialog or popup buttons, behavior and general look'n'feel might vary slightly depending on the operating system.

##### Clipboard Manager

```arturo
define :clipboardManager [
    history: []
    
    save: method [text][
        clip text
        \history: \history ++ text
    ]
    
    last: method [][
        if empty? \history -> 
            return null
            
        return last \history
    ]
    
    clear: method [][
        clip ""
        \history: []
    ]
]

; usage
clipboardManager: to :clipboardManager []!

clipboardManager\save "important text"
previous: clipboardManager\last
```

----

#### `alert`
show notification with given title and message
##### Arguments
- `title` (:string)
- `message` (:string)
##### Options
- `info` (:logical): show informational notification
- `warning` (:logical): show notification as a warning
- `error` (:logical): show notification as an error
##### Returns
:nothing
#### `clip`
set clipboard content to given text
##### Arguments
- `content` (:string)
##### Returns
:nothing
#### `dialog`
show a file selection dialog and return selection
##### Arguments
- `title` (:string)
##### Options
- `folder` (:logical): select folders instead of files
- `path` (:string): use given starting path
##### Returns
:string
#### `popup`
show popup dialog with given title and message and return result
##### Arguments
- `title` (:string)
- `message` (:string)
##### Options
- `info` (:logical): show informational popup
- `warning` (:logical): show popup as a warning
- `error` (:logical): show popup as an error
- `question` (:logical): show popup as a question
- `ok` (:logical): show an OK dialog (default)
- `okCancel` (:logical): show an OK/Cancel dialog
- `yesNo` (:logical): show a Yes/No dialog
- `yesNoCancel` (:logical): show a Yes/No/Cancel dialog
- `retryCancel` (:logical): show a Retry/Cancel dialog
- `retryAbortIgnore` (:logical): show an Abort/Retry/Ignore dialog
- `literal` (:logical): return the literal value of the pressed button
##### Returns
:logical,:literal
#### `unclip`
get clipboard content
##### Returns
:string
#### `webview`
show webview window with given url or html source
##### Arguments
- `content` (:string,:literal)
##### Options
- `title` (:string): set window title
- `width` (:integer): set window width
- `height` (:integer): set window height
- `fixed` (:logical): window shouldn't be resizable
- `maximized` (:logical): start in maximized mode
- `fullscreen` (:logical): start in fullscreen mode
- `borderless` (:logical): show as borderless window
- `topmost` (:logical): set window as always-on-top
- `debug` (:logical): add inspector console
- `on` (:dictionary): execute code on specific events
- `inject` (:string): inject JS code on webview initialization
##### Returns
:nothing
