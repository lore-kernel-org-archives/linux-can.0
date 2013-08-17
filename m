From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: license issues of can-utils
Date: Sat, 17 Aug 2013 21:05:21 +0200
Message-ID: <20130817190521.GK30496@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60165 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754138Ab3HQTFX (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 17 Aug 2013 15:05:23 -0400
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Robert Haddon <robert.haddon@verari.com>, Oliver Hartkopp <socketcan@hartkopp.net>

Hello,

I started to create a Debian package for can-utils and while looking
through the source files to collect their copyright and license
information, I noticed two things that probably need fixing before a
can-utils package can enter Debian.

a) slcand.c claims to be licensed under both GPL and GFDL-NIV. These tw=
o
licenses are not compatible though (according to some Debian people in
#debian-ftp) and so are not distributable.
Obvious solutions are:

	- rm slcand.c (and optionally rewrite it); or
	- find out which parts are affected by GFDL-NIV and just
	  substitute these; or
	- look at the wikipedia template and judge it to be that little
	  creative to allow dropping GFDL-NIV (IANAL, but I guess that
	  is hardly possible, looking at
	  https://en.wikipedia.org/w/index.php?title=3DDaemon_%28computing%29&=
oldid=3D280005270#Sample_Program_in_C_on_Linux)

b) several headers below include/socketcan/can have a copyright but no
license. I think the best approach here (as also suggested by Marc in a
private discussion) is to fix the original headers in the kernel and
then copy these back into can-utils. I assume the standard boilerplate
with BSD-3-Clause + GPL-2 is the desired addition? If yes I can prepare
a patch.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
