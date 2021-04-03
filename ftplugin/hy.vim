" Vim filetype plugin file
" Language:     Clojure
" Author:       Meikel Brandmeyer <mb@kotka.de>
"
" Maintainer:   Sung Pae <self@sungpae.com>
" URL:          https://github.com/guns/vim-clojure-static
" License:      Same as Vim
" Last Change:  %%RELEASE_DATE%%

if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo&vim

let b:undo_ftplugin = 'setlocal iskeyword< define< formatoptions< comments< commentstring< lispwords<'

setlocal iskeyword+=?,-,*,!,+,/,=,<,>,.,:,$

" There will be false positives, but this is better than missing the whole set
" of user-defined def* definitions.
setlocal define=\\v[(/]def(ault)@!\\S*

" Remove 't' from 'formatoptions' to avoid auto-wrapping code.
setlocal formatoptions-=t

" Lisp comments are routinely nested (e.g. ;;; SECTION HEADING)
setlocal comments=n:;
setlocal commentstring=;\ %s

" -*- LISPWORDS -*-

" hyConstant
setlocal lispwords+=null,nil,NaN,Inf

" hyBoolean
setlocal lispwords+=false,true

" hySpecial
setlocal lispwords+=macro-error,defmacro-alias,let,if-python2,def,setv,fn,fn/a,lambda
setlocal lispwords+=self

" hyException
setlocal lispwords+=throw,raise,try,except,catch,else,finally

" hyCond
setlocal lispwords+=cond,if-not,lisp-if,lif,lif-not,when,unless

" hyRepeat
setlocal lispwords+=loop,for*,while,lfor,sfor,dfor,gfor,for/a,recur

" hyDefine
setlocal lispwords+=defmacro/g!,defmain,defn-alias,defun-alias,defmulti,defnc
setlocal lispwords+=defclass,defmacro,defmacro!,defreader,defn,defun,defn/a
setlocal lispwords+=defsharp,deftag

" hyMacro
setlocal lispwords+=,->,->>,ap-dotimes,ap-each,ap-each-while,ap-filter,ap-first,ap-pipe
setlocal lispwords+=ap-compse,xi,ap-if,ap-last,ap-map,ap-map-when,ap-reduce,ap-reject,car,cdr
setlocal lispwords+=defnc,delete-route,fnc,fnr,for,for*,macroexpand-all,post-route
setlocal lispwords+=postwalk,prewalk,profile/calls,profile/cpu,put-route,route
setlocal lispwords+=route-with-methods,walk,with,with/a,with-gensyms

" hyFunc
setlocal lispwords+=,!=,%,%=,&,&=,*,**,**=,*=,+,+=,\,,-,--trampoline--,-=,.,/
setlocal lispwords+=,//,//=,/=,<,<<,<<=,<=,=,>,>=,>>,>>=,HyComplex,HyCons
setlocal lispwords+=HyExpression,HyFloat,HyInteger,HyKeyword,HyList,HyString
setlocal lispwords+=HySymbol,^,^=,_flatten,_numeric-check,and,kwapply,apply,assert,assoc

setlocal lispwords+=break,return,*map,accumulate,butlast,calling-module-name,chain
setlocal lispwords+=combinations,comp,complement,compress,constantly,count,cut
setlocal lispwords+=cycle,mangle,unmable,doto,drop-last,drop-while,filter,fraction
setlocal lispwords+=interleave,interpose,is_not,islice,juxt,keyword,last,merge-with
setlocal lispwords+=multicombinations,name,partition,permutations,product,range
setlocal lispwords+=read,read-str,reduce,repeat,symbol?,tee,xor,zip,zip-longest

setlocal lispwords+=coll?,cons,cons?,continue,curry
setlocal lispwords+=dec,del,dict-comp,disassemble,dispatch-reader-macro,distinct,do,drop
setlocal lispwords+=empty?,eval,eval-and-compile,eval-when-compile,even?,every?
setlocal lispwords+=fake-source-positions,first,flatten,float?,from
setlocal lispwords+=genexpr,gensym,get,global,nonlocal
setlocal lispwords+=identity,if,if*,import,in,inc,instance?,integer,integer-char?,integer?,is,is-not
setlocal lispwords+=iterable?,iterate,iterator?
setlocal lispwords+=keyword?
setlocal lispwords+=list,list*,list-comp
setlocal lispwords+=macroexpand,macroexpand-1,map
setlocal lispwords+=neg?,nil?,none?,not,not-in,nth,numeric?
setlocal lispwords+=odd?,or,pos?,progn,quasiquote,quote
setlocal lispwords+=recursive-replace,remove,repeatedly,require,rest
setlocal lispwords+=second,set-comp,slice,some,string,string?
setlocal lispwords+=take,take-nth,take-while
setlocal lispwords+=unquote,unquote-splicing,unquote-splice
setlocal lispwords+=with*,with-decorator
setlocal lispwords+=yield,yield-from,zero?,\|=,~,\|
setlocal lispwords+=print



" Provide insert mode completions for special forms and clojure.core. As
" 'omnifunc' is set by popular Clojure REPL client plugins, we also set
" 'completefunc' so that the user has some form of completion available when
" 'omnifunc' is set and no REPL connection exists.
for s:setting in ['omnifunc', 'completefunc']
    if exists('&' . s:setting) && empty(eval('&' . s:setting))
        execute 'setlocal ' . s:setting . '=clojurecomplete#Complete'
        let b:undo_ftplugin .= ' | setlocal ' . s:setting . '<'
    endif
endfor


" Skip brackets in ignored syntax regions when using the % command
if exists('loaded_matchit')
    let b:match_words = &matchpairs
    let b:match_skip = 's:comment\|string\|regex\|character'
    let b:undo_ftplugin .= ' | unlet! b:match_words b:match_skip'
endif


let &cpo = s:cpo_save

unlet! s:cpo_save s:setting s:dir

" vim:sts=8:sw=8:ts=8:noet
