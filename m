From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH can-utils 3/3] slcand: remove program as it is undistributable
Date: Sun, 12 Jan 2014 11:57:28 +0100
Message-ID: <52D27518.5040202@hartkopp.net>
References: <20130817190521.GK30496@pengutronix.de> <1389481823-8379-1-git-send-email-u.kleine-koenig@pengutronix.de> <1389481823-8379-4-git-send-email-u.kleine-koenig@pengutronix.de> <CAGm1_ksVCPftbN_9BzS6tJ+-WWmfckegSQ9h_8USnNdKKfW01w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:11993 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156AbaALK5a (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 12 Jan 2014 05:57:30 -0500
In-Reply-To: <CAGm1_ksVCPftbN_9BzS6tJ+-WWmfckegSQ9h_8USnNdKKfW01w@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Yegor Yefremov <yegorslists@googlemail.com>, =?UTF-8?B?VXdlIEtsZWluZS0=?= =?UTF-8?B?S8O2bmln?= <u.kleine-koenig@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>



On 12.01.2014 00:38, Yegor Yefremov wrote:
> On Sun, Jan 12, 2014 at 12:10 AM, Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
>> The source file specifies slcand to be licensed under both GPL-2+ an=
d GFDL.
>> These two licenses are incompatible which makes this file undistribu=
table.
>> The clean way to fix this is to remove the file and reimplement its
>> functionality under a valid license when need arises.
>=20
> There is need for this daemon. I'm using it in production tests.
>=20

Oh, yes. There was so much effort put into this slcand.
We should better look how we might fix the license issues.

The original thread where slcand comes from was here:

http://socket-can.996257.n3.nabble.com/slcan-attach-and-resetting-line-=
disciplines-td1396.html

And here was the original commit to the SVN:
http://svn.berlios.de/wsvn/socketcan/trunk/can-utils/slcand.c?rev=3D973=
&peg=3D973

The code has been removed from Wikipedia in October 2009
http://en.wikipedia.org/w/index.php?title=3DDaemon_%28computing%29&diff=
=3D321383226&oldid=3D320644717
(not a textbook. these examples are completely opaque to non-experts)

And it has been added here (wihout any license information):
http://en.wikipedia.org/w/index.php?title=3DDaemon_%28computing%29&diff=
=3D273831207&oldid=3D273016660

I assume we need to rewrite the daemon-specific code, e.g. use the
other reference in Wikipedia:

	http://www-theorie.physik.unizh.ch/~dpotter/howto/daemonize

which is public domain - and I assume this to be the original source ..=
=2E

Oh well :-(

Regards,
Oliver


