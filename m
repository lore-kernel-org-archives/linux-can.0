From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH can-utils v2 1/3] headers: use include/linux only for
 Linux kernel headers
Date: Mon, 13 Jan 2014 22:37:43 +0100
Message-ID: <20140113213743.GN29475@pengutronix.de>
References: <1389481823-8379-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1389561879-16729-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1389561879-16729-2-git-send-email-u.kleine-koenig@pengutronix.de>
 <52D3867B.6090108@hartkopp.net>
 <20140113072049.GB29475@pengutronix.de>
 <52D42F90.7080005@hartkopp.net>
 <20140113204531.GI29475@pengutronix.de>
 <52D4580C.5030602@hartkopp.net>
 <20140113212658.GL29475@pengutronix.de>
 <52D45B4C.3070009@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41574 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752292AbaAMVhp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 13 Jan 2014 16:37:45 -0500
Content-Disposition: inline
In-Reply-To: <52D45B4C.3070009@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, Yegor Yefremov <yegorslists@googlemail.com>

Hello Oliver,

On Mon, Jan 13, 2014 at 10:31:56PM +0100, Oliver Hartkopp wrote:
> >> Please let it stay in the current place.
> > To late for v3, only read your mail when I sent it out.
> >=20
>=20
> Sorry that I did not was faster.
>=20
> But it's never too late for my NACK for the "[PATCH can-utils v3 2/5]=
 Move
> isotp.h into the project root" :-)
>=20
> To all the other stuff you may add my Acked-by: in the next attempt.
>=20
> Btw. did you test the stuff on the 'old' system as you mentioned?
No, but I didn't sync the kernel headers, so everything should still
work. I will drop patch 2 as you insist and I don't care much. Then I
can test on the old system.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
