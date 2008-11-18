p5-css-prepare
==============

Perl 5 module for preprocessing CSS (normally as part of a deployment process).

Should:

* optimise the file size by removing comments, redundant rules, unnecessary
  whitespace and by rewriting the remaining code so that it takes the minimum
  amount of bytes necessary.
* concatenate multiple files safely
* support some useful pre-processing declarations
