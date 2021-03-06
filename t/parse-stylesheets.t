#!/usr/bin/env perl6

use Test;
use CSS::Grammar::Test :parse-tests;
use CSS::Grammar::CSS1;
use CSS::Grammar::CSS21;
use CSS::Grammar::CSS3;

# sample taken from http://www.w3.org/TR/REC-CSS1/#appendix-b

my $tiny = 'H1 { color: blue; }';
my $small = 'A:link IMG { border: 2px solid blue !important}';

my $body = 'BODY {
  margin: 1em;
  font-family: serif;
  line-height: 1.1;
  background: white;
  color: black;
}
';

my $sample = q:to/END_SAMPLE/;

H1, H2, H3, H4, H5, H6, P, UL, OL, DIR, MENU, DIV,
DT, DD, ADDRESS, BLOCKQUOTE, PRE, BR, HR, FORM, DL {
  display: block }
B, STRONG, I, EM, CITE, VAR, TT, CODE, KBD, SAMP,
IMG, SPAN { display: inline }

LI { display: list-item }

H1, H2, H3, H4 { margin-top: 1em; margin-bottom: 1em }
H5, H6 { margin-top: 1em }
H1 { text-align: center }
H1, H2, H4, H6 { font-weight: bold }
H3, H5 { font-style: italic }

H1 { font-size: xx-large }
H2 { font-size: x-large }
H3 { font-size: large }

B, STRONG { font-weight: bolder }  /* relative to the parent */
I, CITE, EM, VAR, ADDRESS, BLOCKQUOTE { font-style: italic }
PRE, TT, CODE, KBD, SAMP { font-family: monospace }

PRE { white-space: pre }

ADDRESS { margin-left: 3em }
BLOCKQUOTE { margin-left: 3em; margin-right: 3em }

UL, DIR { list-style: disc }
OL { list-style: decimal }
MENU { margin: 0 }              /* tight formatting */
LI { margin-left: 3em }

DT { margin-bottom: 0 }
DD { margin-top: 0; margin-left: 3em }

HR { border-top: solid }        /* 'border-bottom' could also have been used */

A:link { color: blue }          /* unvisited link */
A:visited { color: red }        /* visited links */
A:active { color: lime }        /* active links */

/* setting the anchor border around IMG elements
   requires contextual selectors */

A:link IMG { border: 2px solid blue }
A:visited IMG { border: 2px solid red }
A:active IMG { border: 2px solid lime }
END_SAMPLE

my Pair @tests = :$tiny, :$small, :$body, :sample[$body ~ $sample];

for @tests {
    my ($test, $input) = .kv;

    for css1  => CSS::Grammar::CSS1,
        css21 => CSS::Grammar::CSS21,
        css3  => CSS::Grammar::CSS3 {
	    my ($level, $class) = .kv;

	    parse-tests( $class, $input,
			 :suite($level),
			 :rule<stylesheet> );
    }
}

done-testing;
