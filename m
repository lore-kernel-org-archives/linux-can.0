From: David Jander <david@protonic.nl>
Subject: Re: [PATCH 02/14] can: rx-fifo: Increase MB size limit from 32 to
 64
Date: Fri, 7 Nov 2014 11:28:11 +0100
Message-ID: <20141107112811.04a1faa9@archvile>
References: <1415262853-22907-1-git-send-email-david@protonic.nl>
	<1415262853-22907-3-git-send-email-david@protonic.nl>
	<545B3457.9030207@pengutronix.de>
	<20141106170330.54b6ed7e@archvile>
	<545B9C3E.1010002@pengutronix.de>
	<20141106172052.6299c1d1@archvile>
	<545C8584.8000104@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:1740 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151AbaKGK1f (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 7 Nov 2014 05:27:35 -0500
In-Reply-To: <545C8584.8000104@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, Alexander Stein <alexander.stein@systec-electronic.com>

On Fri, 07 Nov 2014 09:40:36 +0100
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> On 11/06/2014 05:20 PM, David Jander wrote:
> >>> Btw, there is a subtle bug in the line you linked to:
> >>>
> >>>> #define GENMASK_ULL(h, l)       (((U64_C(1) << ((h) - (l) + 1)) - 1) <<
> >>>> (l))
> >>>
> >>> The _ULL in the name of the macro seems to hint to "unsigned long long",
> >>> while the implementation seems to assume that it means U64_C. This is
> >>> obviously wrong, although for most platforms that are currently capable
> >>> of running Linux, those are probably equivalent...
> >>
> >> #define U64_C(x) x ## ULL
> > 
> > This line:
> > 
> > http://lxr.free-electrons.com/source/include/asm-generic/int-ll64.h#L4
> > 
> > ...seems to indicate, that it may not always be the case :-)
> > AFAIK, C99 specifies that "long long" should at _least_ have 64 bit length,
> > but says nothing about when it may be larger.
> > OTOH, I have yet to find a machine/compiler combination that defines "long
> > long" as more than 64bit... at least not running Linux.
> > A correct definition should be trivial though:
> > 
> > #define GENMASK_ULL(h, l)       (((1ULL << ((h) - (l) + 1)) - 1) << (l))
> 
> That's what it does:
> 
> $ cat << EOF | gcc -xc -E -
> #define U64_C(x) x ## ULL
> #define GENMASK_ULL(h, l)   (((U64_C(1) << ((h) - (l) + 1)) - 1) << (l))
> GENMASK_ULL(foo, bar)
> EOF
> 
> Results in:
> (((1ULL << ((foo) - (bar) + 1)) - 1) << (bar))

Yes of course! I am not questioning that.
The problem is that although right now asm-generic/int-ll64.h is the only
place where U64_C is defined, this may not be the case in the future. In the
same way as in C99 an "unsigned long" can be either 32bit or 64bit wide, there
is also no guarantee that an "unsigned long long" will always be 64bits. If
tomorrow we add support for another arch in Linux that happens to define
"unsigned long long" as 128bit for example, on that platform we will have
another version arch/foo/include/asm/int-ll64.h that defines...

#define U64_C(x) x ## UL

On that platform one would assume that something called "GENMASK_ULL" is
supposed to support 128bit masks, which is not true because the definition is
wrong. Of course you can say that in that case one should also re-define
GENMASK_ULL, but why do that when fixing the current definition (replace
U64_C(1) with 1ULL) would always be correct? The point is, that in "C" mixing
type definitions between C-types (int, long, long long, char, etc...) with
fixed-size types (int32_t, int64_t, int8_t, etc...) is semantically wrong,
platform-dependent and should be avoided. That's what stdint.h is for in
user-land.
Btw, on some 16-bit DSP processors, the C-type "char" is 16-bit wide... how
many issues do you think this can cause if one is not careful with type
naming? Not that I intend to run Linux on such a DSP, but you get the idea...

Now, can we please get back on-topic ;-)

I am going to use this macro (although it is semantically slightly broken) in
the next version.

Best regards,

-- 
David Jander
Protonic Holland.
