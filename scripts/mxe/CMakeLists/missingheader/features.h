<html><head>
<meta http-equiv="content-type" content="text/html; charset=windows-1252">
<title>features.h</title>
<meta name="generator" content="c2html 0.9.6">
<meta name="date" content="2011-01-23T20:25:23+00:00">
</head>

<body bgcolor="#FFFFFF">
<pre width="80"><font color="#B22222">/* Copyright (C) 1991-1993,1995-2006,2007,2009 Free Software Foundation, Inc.
   This file is part of the GNU C Library.

   The GNU C Library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version.

   The GNU C Library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with the GNU C Library; if not, write to the Free
   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
   02111-1307 USA.  */</font>

<font color="#A020F0">#ifndef        _FEATURES_H</font>
<strong><font color="#228B22">#define        _FEATURES_H        1</font></strong>

<font color="#B22222">/* These are defined by the user (or the compiler)
   to specify the desired environment:

   __STRICT_ANSI__        ISO Standard C.
   _ISOC99_SOURCE        Extensions to ISO C89 from ISO C99.
   _POSIX_SOURCE        IEEE Std 1003.1.
   _POSIX_C_SOURCE        If ==1, like _POSIX_SOURCE; if &gt;=2 add IEEE Std 1003.2;
                        if &gt;=199309L, add IEEE Std 1003.1b-1993;
                        if &gt;=199506L, add IEEE Std 1003.1c-1995;
                        if &gt;=200112L, all of IEEE 1003.1-2004
                        if &gt;=200809L, all of IEEE 1003.1-2008
   _XOPEN_SOURCE        Includes POSIX and XPG things.  Set to 500 if
                        Single Unix conformance is wanted, to 600 for the
                        sixth revision, to 700 for the seventh revision.
   _XOPEN_SOURCE_EXTENDED XPG things and X/Open Unix extensions.
   _LARGEFILE_SOURCE        Some more functions for correct standard I/O.
   _LARGEFILE64_SOURCE        Additional functionality from LFS for large files.
   _FILE_OFFSET_BITS=N        Select default filesystem interface.
   _BSD_SOURCE                ISO C, POSIX, and 4.3BSD things.
   _SVID_SOURCE                ISO C, POSIX, and SVID things.
   _ATFILE_SOURCE        Additional *at interfaces.
   _GNU_SOURCE                All of the above, plus GNU extensions.
   _REENTRANT                Select additionally reentrant object.
   _THREAD_SAFE                Same as _REENTRANT, often used by other systems.
   _FORTIFY_SOURCE        If set to numeric value &gt; 0 additional security
                        measures are defined, according to level.

   The `-ansi' switch to the GNU C compiler defines __STRICT_ANSI__.
   If none of these are defined, the default is to have _SVID_SOURCE,
   _BSD_SOURCE, and _POSIX_SOURCE set to one and _POSIX_C_SOURCE set to
   200112L.  If more than one of these are defined, they accumulate.
   For example __STRICT_ANSI__, _POSIX_SOURCE and _POSIX_C_SOURCE
   together give you ISO C, 1003.1, and 1003.2, but nothing else.

   These are defined by this file and are used by the
   header files to decide what to declare or define:

   __USE_ISOC99                Define ISO C99 things.
   __USE_ISOC95                Define ISO C90 AMD1 (C95) things.
   __USE_POSIX                Define IEEE Std 1003.1 things.
   __USE_POSIX2                Define IEEE Std 1003.2 things.
   __USE_POSIX199309        Define IEEE Std 1003.1, and .1b things.
   __USE_POSIX199506        Define IEEE Std 1003.1, .1b, .1c and .1i things.
   __USE_XOPEN                Define XPG things.
   __USE_XOPEN_EXTENDED        Define X/Open Unix things.
   __USE_UNIX98                Define Single Unix V2 things.
   __USE_XOPEN2K        Define XPG6 things.
   __USE_XOPEN2K8       Define XPG7 things.
   __USE_LARGEFILE        Define correct standard I/O things.
   __USE_LARGEFILE64        Define LFS things with separate names.
   __USE_FILE_OFFSET64        Define 64bit interface as default.
   __USE_BSD                Define 4.3BSD things.
   __USE_SVID                Define SVID things.
   __USE_MISC                Define things common to BSD and System V Unix.
   __USE_ATFILE                Define *at interfaces and AT_* constants for them.
   __USE_GNU                Define GNU extensions.
   __USE_REENTRANT        Define reentrant/thread-safe *_r functions.
   __USE_FORTIFY_LEVEL        Additional security measures used, according to level.
   __FAVOR_BSD                Favor 4.3BSD things in cases of conflict.

   The macros `__GNU_LIBRARY__', `__GLIBC__', and `__GLIBC_MINOR__' are
   defined by this file unconditionally.  `__GNU_LIBRARY__' is provided
   only for compatibility.  All new code should use the other symbols
   to test for features.

   All macros listed above as possibly being defined by this file are
   explicitly undefined if they are not explicitly defined.
   Feature-test macros that are not defined by the user or compiler
   but are implied by the other feature-test macros defined (or by the
   lack of any definitions) are defined by the file.  */</font>


<font color="#B22222">/* Undefine everything, so we get a clean slate.  */</font>
<strong><font color="#228B22">#undef        __USE_ISOC99</font></strong>
<strong><font color="#228B22">#undef        __USE_ISOC95</font></strong>
<strong><font color="#228B22">#undef        __USE_POSIX</font></strong>
<strong><font color="#228B22">#undef        __USE_POSIX2</font></strong>
<strong><font color="#228B22">#undef        __USE_POSIX199309</font></strong>
<strong><font color="#228B22">#undef        __USE_POSIX199506</font></strong>
<strong><font color="#228B22">#undef        __USE_XOPEN</font></strong>
<strong><font color="#228B22">#undef        __USE_XOPEN_EXTENDED</font></strong>
<strong><font color="#228B22">#undef        __USE_UNIX98</font></strong>
<strong><font color="#228B22">#undef        __USE_XOPEN2K</font></strong>
<strong><font color="#228B22">#undef        __USE_XOPEN2K8</font></strong>
<strong><font color="#228B22">#undef        __USE_LARGEFILE</font></strong>
<strong><font color="#228B22">#undef        __USE_LARGEFILE64</font></strong>
<strong><font color="#228B22">#undef        __USE_FILE_OFFSET64</font></strong>
<strong><font color="#228B22">#undef        __USE_BSD</font></strong>
<strong><font color="#228B22">#undef        __USE_SVID</font></strong>
<strong><font color="#228B22">#undef        __USE_MISC</font></strong>
<strong><font color="#228B22">#undef        __USE_ATFILE</font></strong>
<strong><font color="#228B22">#undef        __USE_GNU</font></strong>
<strong><font color="#228B22">#undef        __USE_REENTRANT</font></strong>
<strong><font color="#228B22">#undef        __USE_FORTIFY_LEVEL</font></strong>
<strong><font color="#228B22">#undef        __FAVOR_BSD</font></strong>
<strong><font color="#228B22">#undef        __KERNEL_STRICT_NAMES</font></strong>

<font color="#B22222">/* Suppress kernel-name space pollution unless user expressedly asks
   for it.  */</font>
<font color="#A020F0">#ifndef _LOOSE_KERNEL_NAMES</font>
<font color="#A020F0"># define __KERNEL_STRICT_NAMES</font>
<font color="#A020F0">#endif</font>

<font color="#B22222">/* Always use ISO C things.  */</font>
<strong><font color="#228B22">#define        __USE_ANSI        1</font></strong>

<font color="#B22222">/* Convenience macros to test the versions of glibc and gcc.
   Use them like this:
   #if __GNUC_PREREQ (2,8)
   ... code requiring gcc 2.8 or later ...
   #endif
   Note - they won't work for gcc1 or glibc1, since the _MINOR macros
   were not defined then.  */</font>
<font color="#A020F0">#if defined __GNUC__ &amp;&amp; defined __GNUC_MINOR__</font>
<font color="#A020F0"># define __GNUC_PREREQ(maj, min) \</font>
        ((__GNUC__ &lt;&lt; 16) + __GNUC_MINOR__ &gt;= ((maj) &lt;&lt; 16) + (min))
<font color="#A020F0">#else</font>
<font color="#A020F0"># define __GNUC_PREREQ(maj, min) 0</font>
<font color="#A020F0">#endif</font>


<font color="#B22222">/* If _BSD_SOURCE was defined by the user, favor BSD over POSIX.  */</font>
<font color="#A020F0">#if defined _BSD_SOURCE &amp;&amp; \</font>
    !(defined _POSIX_SOURCE || defined _POSIX_C_SOURCE || \
      defined _XOPEN_SOURCE || defined _XOPEN_SOURCE_EXTENDED || \
      defined _GNU_SOURCE || defined _SVID_SOURCE)
<font color="#A020F0"># define __FAVOR_BSD        1</font>
<font color="#A020F0">#endif</font>

<font color="#B22222">/* If _GNU_SOURCE was defined by the user, turn on all the other features.  */</font>
<font color="#A020F0">#ifdef _GNU_SOURCE</font>
<font color="#A020F0"># undef  _ISOC99_SOURCE</font>
<font color="#A020F0"># define _ISOC99_SOURCE        1</font>
<font color="#A020F0"># undef  _POSIX_SOURCE</font>
<font color="#A020F0"># define _POSIX_SOURCE        1</font>
<font color="#A020F0"># undef  _POSIX_C_SOURCE</font>
<font color="#A020F0"># define _POSIX_C_SOURCE        200809L</font>
<font color="#A020F0"># undef  _XOPEN_SOURCE</font>
<font color="#A020F0"># define _XOPEN_SOURCE        700</font>
<font color="#A020F0"># undef  _XOPEN_SOURCE_EXTENDED</font>
<font color="#A020F0"># define _XOPEN_SOURCE_EXTENDED        1</font>
<font color="#A020F0"># undef         _LARGEFILE64_SOURCE</font>
<font color="#A020F0"># define _LARGEFILE64_SOURCE        1</font>
<font color="#A020F0"># undef  _BSD_SOURCE</font>
<font color="#A020F0"># define _BSD_SOURCE        1</font>
<font color="#A020F0"># undef  _SVID_SOURCE</font>
<font color="#A020F0"># define _SVID_SOURCE        1</font>
<font color="#A020F0"># undef  _ATFILE_SOURCE</font>
<font color="#A020F0"># define _ATFILE_SOURCE        1</font>
<font color="#A020F0">#endif</font>

<font color="#B22222">/* If nothing (other than _GNU_SOURCE) is defined,
   define _BSD_SOURCE and _SVID_SOURCE.  */</font>
<font color="#A020F0">#if (!defined __STRICT_ANSI__ &amp;&amp; !defined _ISOC99_SOURCE &amp;&amp; \</font>
     !defined _POSIX_SOURCE &amp;&amp; !defined _POSIX_C_SOURCE &amp;&amp; \
     !defined _XOPEN_SOURCE &amp;&amp; !defined _XOPEN_SOURCE_EXTENDED &amp;&amp; \
     !defined _BSD_SOURCE &amp;&amp; !defined _SVID_SOURCE)
<font color="#A020F0"># define _BSD_SOURCE        1</font>
<font color="#A020F0"># define _SVID_SOURCE        1</font>
<font color="#A020F0">#endif</font>

<font color="#B22222">/* This is to enable the ISO C99 extension.  Also recognize the old macro
   which was used prior to the standard acceptance.  This macro will
   eventually go away and the features enabled by default once the ISO C99
   standard is widely adopted.  */</font>
<font color="#A020F0">#if (defined _ISOC99_SOURCE || defined _ISOC9X_SOURCE \</font>
     || (defined __STDC_VERSION__ &amp;&amp; __STDC_VERSION__ &gt;= 199901L))
<font color="#A020F0"># define __USE_ISOC99        1</font>
<font color="#A020F0">#endif</font>

<font color="#B22222">/* This is to enable the ISO C90 Amendment 1:1995 extension.  */</font>
<font color="#A020F0">#if (defined _ISOC99_SOURCE || defined _ISOC9X_SOURCE \</font>
     || (defined __STDC_VERSION__ &amp;&amp; __STDC_VERSION__ &gt;= 199409L))
<font color="#A020F0"># define __USE_ISOC95        1</font>
<font color="#A020F0">#endif</font>

<font color="#B22222">/* If none of the ANSI/POSIX macros are defined, use POSIX.1 and POSIX.2
   (and IEEE Std 1003.1b-1993 unless _XOPEN_SOURCE is defined).  */</font>
<font color="#A020F0">#if ((!defined __STRICT_ANSI__ || (_XOPEN_SOURCE - 0) &gt;= 500) &amp;&amp; \</font>
     !defined _POSIX_SOURCE &amp;&amp; !defined _POSIX_C_SOURCE)
<font color="#A020F0"># define _POSIX_SOURCE        1</font>
<font color="#A020F0"># if defined _XOPEN_SOURCE &amp;&amp; (_XOPEN_SOURCE - 0) &lt; 500</font>
<font color="#A020F0">#  define _POSIX_C_SOURCE        2</font>
<font color="#A020F0"># elif defined _XOPEN_SOURCE &amp;&amp; (_XOPEN_SOURCE - 0) &lt; 600</font>
<font color="#A020F0">#  define _POSIX_C_SOURCE        199506L</font>
<font color="#A020F0"># elif defined _XOPEN_SOURCE &amp;&amp; (_XOPEN_SOURCE - 0) &lt; 700</font>
<font color="#A020F0">#  define _POSIX_C_SOURCE        200112L</font>
<font color="#A020F0"># else</font>
<font color="#A020F0">#  define _POSIX_C_SOURCE        200809L</font>
<font color="#A020F0"># endif</font>
<font color="#A020F0"># define __USE_POSIX_IMPLICITLY        1</font>
<font color="#A020F0">#endif</font>

<font color="#A020F0">#if defined _POSIX_SOURCE || _POSIX_C_SOURCE &gt;= 1 || defined _XOPEN_SOURCE</font>
<font color="#A020F0"># define __USE_POSIX        1</font>
<font color="#A020F0">#endif</font>

<font color="#A020F0">#if defined _POSIX_C_SOURCE &amp;&amp; _POSIX_C_SOURCE &gt;= 2 || defined _XOPEN_SOURCE</font>
<font color="#A020F0"># define __USE_POSIX2        1</font>
<font color="#A020F0">#endif</font>

<font color="#A020F0">#if (_POSIX_C_SOURCE - 0) &gt;= 199309L</font>
<font color="#A020F0"># define __USE_POSIX199309        1</font>
<font color="#A020F0">#endif</font>

<font color="#A020F0">#if (_POSIX_C_SOURCE - 0) &gt;= 199506L</font>
<font color="#A020F0"># define __USE_POSIX199506        1</font>
<font color="#A020F0">#endif</font>

<font color="#A020F0">#if (_POSIX_C_SOURCE - 0) &gt;= 200112L</font>
<font color="#A020F0"># define __USE_XOPEN2K                1</font>
<font color="#A020F0"># undef __USE_ISOC99</font>
<font color="#A020F0"># define __USE_ISOC99                1</font>
<font color="#A020F0">#endif</font>

<font color="#A020F0">#if (_POSIX_C_SOURCE - 0) &gt;= 200809L</font>
<font color="#A020F0"># define __USE_XOPEN2K8                1</font>
<font color="#A020F0"># undef  _ATFILE_SOURCE</font>
<font color="#A020F0"># define _ATFILE_SOURCE        1</font>
<font color="#A020F0">#endif</font>

<font color="#A020F0">#ifdef        _XOPEN_SOURCE</font>
<font color="#A020F0"># define __USE_XOPEN        1</font>
<font color="#A020F0"># if (_XOPEN_SOURCE - 0) &gt;= 500</font>
<font color="#A020F0">#  define __USE_XOPEN_EXTENDED        1</font>
<font color="#A020F0">#  define __USE_UNIX98        1</font>
<font color="#A020F0">#  undef _LARGEFILE_SOURCE</font>
<font color="#A020F0">#  define _LARGEFILE_SOURCE        1</font>
<font color="#A020F0">#  if (_XOPEN_SOURCE - 0) &gt;= 600</font>
<font color="#A020F0">#   if (_XOPEN_SOURCE - 0) &gt;= 700</font>
<font color="#A020F0">#    define __USE_XOPEN2K8        1</font>
<font color="#A020F0">#   endif</font>
<font color="#A020F0">#   define __USE_XOPEN2K        1</font>
<font color="#A020F0">#   undef __USE_ISOC99</font>
<font color="#A020F0">#   define __USE_ISOC99                1</font>
<font color="#A020F0">#  endif</font>
<font color="#A020F0"># else</font>
<font color="#A020F0">#  ifdef _XOPEN_SOURCE_EXTENDED</font>
<font color="#A020F0">#   define __USE_XOPEN_EXTENDED        1</font>
<font color="#A020F0">#  endif</font>
<font color="#A020F0"># endif</font>
<font color="#A020F0">#endif</font>

<font color="#A020F0">#ifdef _LARGEFILE_SOURCE</font>
<font color="#A020F0"># define __USE_LARGEFILE        1</font>
<font color="#A020F0">#endif</font>

<font color="#A020F0">#ifdef _LARGEFILE64_SOURCE</font>
<font color="#A020F0"># define __USE_LARGEFILE64        1</font>
<font color="#A020F0">#endif</font>

<font color="#A020F0">#if defined _FILE_OFFSET_BITS &amp;&amp; _FILE_OFFSET_BITS == 64</font>
<font color="#A020F0"># define __USE_FILE_OFFSET64        1</font>
<font color="#A020F0">#endif</font>

<font color="#A020F0">#if defined _BSD_SOURCE || defined _SVID_SOURCE</font>
<font color="#A020F0"># define __USE_MISC        1</font>
<font color="#A020F0">#endif</font>

<font color="#A020F0">#ifdef        _BSD_SOURCE</font>
<font color="#A020F0"># define __USE_BSD        1</font>
<font color="#A020F0">#endif</font>

<font color="#A020F0">#ifdef        _SVID_SOURCE</font>
<font color="#A020F0"># define __USE_SVID        1</font>
<font color="#A020F0">#endif</font>

<font color="#A020F0">#ifdef        _ATFILE_SOURCE</font>
<font color="#A020F0"># define __USE_ATFILE        1</font>
<font color="#A020F0">#endif</font>

<font color="#A020F0">#ifdef        _GNU_SOURCE</font>
<font color="#A020F0"># define __USE_GNU        1</font>
<font color="#A020F0">#endif</font>

<font color="#A020F0">#if defined _REENTRANT || defined _THREAD_SAFE</font>
<font color="#A020F0"># define __USE_REENTRANT        1</font>
<font color="#A020F0">#endif</font>

<font color="#A020F0">#if defined _FORTIFY_SOURCE &amp;&amp; _FORTIFY_SOURCE &gt; 0 \</font>
    &amp;&amp; __GNUC_PREREQ (4, 1) &amp;&amp; defined __OPTIMIZE__ &amp;&amp; __OPTIMIZE__ &gt; 0
<font color="#A020F0"># if _FORTIFY_SOURCE &gt; 1</font>
<font color="#A020F0">#  define __USE_FORTIFY_LEVEL 2</font>
<font color="#A020F0"># else</font>
<font color="#A020F0">#  define __USE_FORTIFY_LEVEL 1</font>
<font color="#A020F0"># endif</font>
<font color="#A020F0">#else</font>
<font color="#A020F0"># define __USE_FORTIFY_LEVEL 0</font>
<font color="#A020F0">#endif</font>

<font color="#B22222">/* Define __STDC_IEC_559__ and other similar macros.  */</font>
<font color="#A020F0">#include &lt;bits/predefs.h&gt;</font>

<font color="#B22222">/* wchar_t uses ISO 10646-1 (2nd ed., published 2000-09-15) / Unicode 3.1.  */</font>
<strong><font color="#228B22">#define __STDC_ISO_10646__                200009L</font></strong>

<font color="#B22222">/* This macro indicates that the installed library is the GNU C Library.
   For historic reasons the value now is 6 and this will stay from now
   on.  The use of this variable is deprecated.  Use __GLIBC__ and
   __GLIBC_MINOR__ now (see below) when you want to test for a specific
   GNU C library version and use the values in &lt;gnu/lib-names.h&gt; to get
   the sonames of the shared libraries.  */</font>
<strong><font color="#228B22">#undef  __GNU_LIBRARY__</font></strong>
<strong><font color="#228B22">#define __GNU_LIBRARY__ 6</font></strong>

<font color="#B22222">/* Major and minor version number of the GNU C library package.  Use
   these macros to test for features in specific releases.  */</font>
<strong><font color="#228B22">#define        __GLIBC__        2</font></strong>
<strong><font color="#228B22">#define        __GLIBC_MINOR__        11</font></strong>

<strong><font color="#228B22">#define __GLIBC_PREREQ(maj, min) \
        ((__GLIBC__ &lt;&lt; 16) + __GLIBC_MINOR__ &gt;= ((maj) &lt;&lt; 16) + (min))</font></strong>

<font color="#B22222">/* Decide whether a compiler supports the long long datatypes.  */</font>
<font color="#A020F0">#if defined __GNUC__ \</font>
    || (defined __PGI &amp;&amp; defined __i386__ ) \
    || (defined __INTEL_COMPILER &amp;&amp; (defined __i386__ || defined __ia64__)) \
    || (defined __STDC_VERSION__ &amp;&amp; __STDC_VERSION__ &gt;= 199901L)
<font color="#A020F0"># define __GLIBC_HAVE_LONG_LONG        1</font>
<font color="#A020F0">#endif</font>

<font color="#B22222">/* This is here only because every header file already includes this one.  */</font>
<font color="#A020F0">#ifndef __ASSEMBLER__</font>
<font color="#A020F0"># ifndef _SYS_CDEFS_H</font>
<font color="#A020F0">#  include &lt;sys/cdefs.h&gt;</font>
<font color="#A020F0"># endif</font>

<font color="#B22222">/* If we don't have __REDIRECT, prototypes will be missing if
   __USE_FILE_OFFSET64 but not __USE_LARGEFILE[64]. */</font>
<font color="#A020F0"># if defined __USE_FILE_OFFSET64 &amp;&amp; !defined __REDIRECT</font>
<font color="#A020F0">#  define __USE_LARGEFILE        1</font>
<font color="#A020F0">#  define __USE_LARGEFILE64        1</font>
<font color="#A020F0"># endif</font>

<font color="#A020F0">#endif        </font><font color="#B22222">/* !ASSEMBLER */</font><font color="#A020F0"></font>

<font color="#B22222">/* Decide whether we can define 'extern inline' functions in headers.  */</font>
<font color="#A020F0">#if __GNUC_PREREQ (2, 7) &amp;&amp; defined __OPTIMIZE__ \</font>
    &amp;&amp; !defined __OPTIMIZE_SIZE__ &amp;&amp; !defined __NO_INLINE__ \
    &amp;&amp; defined __extern_inline
<font color="#A020F0"># define __USE_EXTERN_INLINES        1</font>
<font color="#A020F0">#endif</font>

<font color="#B22222">/* There are some functions that must be declared 'extern inline' even with
   -Os when building LIBC, or they'll end up undefined.  */</font>
<font color="#A020F0">#if __GNUC_PREREQ (2, 7) &amp;&amp; defined __OPTIMIZE__ \</font>
    &amp;&amp; (defined _LIBC || !defined __OPTIMIZE_SIZE__) &amp;&amp; !defined __NO_INLINE__ \
    &amp;&amp; defined __extern_inline
<font color="#A020F0"># define __USE_EXTERN_INLINES_IN_LIBC        1</font>
<font color="#A020F0">#endif</font>


<font color="#B22222">/* This is here only because every header file already includes this one.
   Get the definitions of all the appropriate `__stub_FUNCTION' symbols.
   &lt;gnu/stubs.h&gt; contains `#define __stub_FUNCTION' when FUNCTION is a stub
   that will always return failure (and set errno to ENOSYS).  */</font>
<font color="#A020F0">#include &lt;gnu/stubs.h&gt;</font>


<font color="#A020F0">#endif        </font><font color="#B22222">/* features.h  */</font><font color="#A020F0"></font>
</pre>



</body></html>