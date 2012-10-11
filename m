From: Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
Subject: Re: [PATCH] can: ti_hecc: fix rx wrong sequence issue
Date: Thu, 11 Oct 2012 14:01:53 +0200
Message-ID: <1349956913.3513.30.camel@coredoba.hi.pengutronix.de>
References: <1349678436-747-1-git-send-email-anilkumar@ti.com>
	 <1349687547.3444.7.camel@coredoba.hi.pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43077 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750924Ab2JKMB4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 11 Oct 2012 08:01:56 -0400
In-Reply-To: <1349687547.3444.7.camel@coredoba.hi.pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: AnilKumar Ch <anilkumar@ti.com>
Cc: wg@grandegger.com, mkl@pengutronix.de, swarren@wwwdotorg.org, linux-can@vger.kernel.org, anantgole@ti.com, nsekhar@ti.com

Hi,

On Mon, 2012-10-08 at 11:12 +0200, Jan L=C3=BCbbe wrote:
> On Mon, 2012-10-08 at 12:10 +0530, AnilKumar Ch wrote:
> > Fix "received wrong sequence count. expected: x, got: y" errors
> > reported by cansequence in a stress test (--verbose).
>=20
> I tested this on a AM3505 with cansequence 4.0.6. For 500kbit, I see =
no
> reordering anymore.
>=20
> When testing at 1Mbit, it seems to be worse than before:
*snip*
> Here we can see that after the initial frames, most frames are receiv=
ed
> twice (some even thrice).

Do you have some idea on the cause of this problem, so we could do some
more focused debugging?

Regards,
Jan
--=20
Pengutronix e.K.                           |                           =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0  =
  |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |

