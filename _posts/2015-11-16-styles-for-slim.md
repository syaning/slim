---
layout: post
title:  Styles for slim
date:   2015-11-16  00:00:00
---

slim is a simple and beautiful jekyll theme, it has only the essential functions
so that you can concentrate on the content of your blog.

Now, let's have a glance at the basic styles: [link](http://github.com/syaning/vida),
**strong**, *italic*, <del>deletion</del>, <ins>insertion</ins>.

<hr>

# Header 1

## Header 2

### Header 3

#### Header 4

##### Header 5

###### Header 6

- list item 1
- list item 2
- list item 3

1. list item 1
2. list item 2
3. list item 3

> Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

![]({{site.baseurl}}/images/image.png)

<table>
    <thead>
        <tr>
            <th>Name</th>
            <th>Age</th>
            <th>Fruit</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Alex</td>
            <td>22</td>
            <td>Apple</td>
        </tr>
        <tr>
            <td>Bran</td>
            <td>20</td>
            <td>Orange</td>
        </tr>
        <tr>
            <td>Mike</td>
            <td>21</td>
            <td>Waltermelon</td>
        </tr>
    </tbody>
</table>

```javascript
// index.js
var arr = [1, 2, 3, 4, 5];
var b = arr.map(x => x * x);
console.log(b);
```