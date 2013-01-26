use v6;

use CSS::Grammar;

grammar CSS::Grammar::CSS1 is CSS::Grammar {

# as defined in w3c Appendix B: CSS1 Grammar
# http://www.w3.org/TR/REC-CSS1/#appendix-b

    rule TOP {^ <stylesheet> $}

    # productions

    rule stylesheet {<import>* <ruleset>*}
 
    rule import { \@import [<string>|<url>] ';' }

    rule unary_operator {'-'|'+'}

    rule operator {'/'|','}

    rule ruleset {
	<selector> [',' <selector>]*
	    '{' <declaration> [';' <declaration> ]* ';'? '}'
    }

    rule property {<ident>}

    rule declaration {
	 <property> ':' <expr> <prio>?
    }

    rule expr { <term> [ <operator>? <term> ]* }

    rule term { <unary_operator>?
		    [ <length> | <string> | <percentage>
		      | <num> | $<ems>='em' | $<exs>='ex' | <ident> | <hexcolor> | <url> | <rgb> ]}

    rule hexcolor {<id>}

    rule rgb{ 'rgb' '(' <num>('%'?) ','  <num>('%'?) ','  <num>('%'?) ')' }

    rule prio {\!important}

    regex selector {<simple_selector>[<ws><simple_selector>]* <pseudo_element>?}

    regex simple_selector { <element_name> <id>? <class>? <pseudo_class>?
	    | <id> <class>? <pseudo_class>?
	    | <class> <pseudo_class>?
	    | <pseudo_class> }

    rule element_name {<ident>}

    rule  pseudo_class      {':'(link|visited|active)}
    rule  pseudo_element    {':'(first\-[line|letter])}

    rule url  { 'url(' <text> ')' }

}
