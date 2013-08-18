From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH can-utils] Don't overwrite PREFIX and DESTDIR when provided
 via the environment
Date: Sun, 18 Aug 2013 13:02:29 +0200
Message-ID: <5210A9C5.5070309@hartkopp.net>
References: <1376767690-8472-1-git-send-email-u.kleine-koenig@pengutronix.de> <520FCFDD.7010308@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:25029 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755091Ab3HRLCc (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 18 Aug 2013 07:02:32 -0400
In-Reply-To: <520FCFDD.7010308@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>, linux-can@vger.kernel.org

On 17.08.2013 21:32, Marc Kleine-Budde wrote:
> On 08/17/2013 09:28 PM, Uwe Kleine-K=C3=B6nig wrote:
>> For creating a Debian package providing PREFIX and DESTDIR via the
>> environment is the easiest option. So use ?=3D to assign these two
>> variables to honor the values in the environment.
>=20
> I suggest to use autotools.
>=20
> ./configure && make && make install
>=20

Today i like the possibility to use autotools or just to say 'make && m=
ake
install' without autotools.

You may choose for the Debian package the build process which is more a=
ppropriate.

>
> -DESTDIR =3D
> -PREFIX =3D /usr/local
> +DESTDIR ?=3D
> +PREFIX ?=3D /usr/local
>

1. good idea - I already pushed it to the git tree

2. I wonder if we should doublecheck the target directories when making=
 it a
real Debian package

e.g. the majority of tools should go into /usr/bin then

But some tools that require root rights should go to /usr/sbin like can=
gw,
isotptun, slcan_attach, slcand

Or should they stay in /usr/bin and lead to an error when the admin rig=
hts are
not granted??

BR,
Oliver



