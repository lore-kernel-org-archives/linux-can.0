From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH RFC] Large file support (LFS) for can-utils
Date: Fri, 21 Feb 2014 22:37:01 +0100
Message-ID: <20140221213701.GP6988@pengutronix.de>
References: <5307B530.4010505@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35823 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756579AbaBUVhD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 21 Feb 2014 16:37:03 -0500
Content-Disposition: inline
In-Reply-To: <5307B530.4010505@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello Oliver,

On Fri, Feb 21, 2014 at 09:21:04PM +0100, Oliver Hartkopp wrote:
> yesterday I tried to create a really big CAN logfile with
>=20
> 	candump -l any
>=20
> logging 9 CAN interfaces.
>=20
> But unfortunately the length of the log file on my 32 bit i686 machin=
e was
> limited to 2147483647 =3D=3D 0x7FFFFFFF =3D=3D int32 max ...
>=20
> I did some investigation and there's some kind of large file support =
(LFS) in
> recent gnu libraries that allow 32 bit applications to create large f=
iles with
> file length values > 0x7FFFFFFF when the filesystem supports it.
>=20
> When applying the patch below my candump was able to create a large l=
og file.
>=20
> Alternatively
>=20
> 	candump -L any > filename
>=20
> did the job too as obviously 'cat' has large file support ;-)
<pedantic>
There is no cat involved, > is handled by your shell.
</pedantic>
Doesn't really make a difference though.

> What do you think about LFS?
> Would this be the correct way to add the LFS support?
Maybe:

	CFLAGS +=3D $(getconf LFS_CFLAGS)
	LDFLAGS +=3D $(getconf LFS_LDFLAGS)

but on the other hand autoconf does it differently, they set

	_FILE_OFFSET_BITS=3D64
=20
only if it's needed (assuming I understood that autoconf m4 stuff
correctly). Also LDFLAGS are not handled at all by autoconf.

> diff --git a/Makefile b/Makefile
> index ab99746..a926177 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -45,6 +45,7 @@ MAKEFLAGS =3D -k
>=20
>  CFLAGS    =3D -O2 -Wall -Wno-parentheses -Iinclude \
>  	    -fno-strict-aliasing \
> +	    -D_FILE_OFFSET_BITS=3D64 \
>  	    -DSO_RXQ_OVFL=3D40 \
>  	    -DPF_CAN=3D29 \
>  	    -DAF_CAN=3DPF_CAN
>=20
-DVAR=3DVAL should better go into CPPFLAGS.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
