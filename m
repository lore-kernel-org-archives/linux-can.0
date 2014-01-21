From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v5 5/5] include: Move includes copied from the Linux
 kernel into include/linux
Date: Tue, 21 Jan 2014 10:53:37 +0100
Message-ID: <20140121095337.GR25911@pengutronix.de>
References: <1389888754-23013-1-git-send-email-mkl@pengutronix.de>
 <1389888754-23013-6-git-send-email-mkl@pengutronix.de>
 <20140116192818.GC25911@pengutronix.de>
 <52D85910.8000200@pengutronix.de>
 <20140117133709.GD25911@pengutronix.de>
 <52D93885.5040109@pengutronix.de>
 <20140117203605.GF25911@pengutronix.de>
 <52DA7106.5000300@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37464 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613AbaAUJxk (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 21 Jan 2014 04:53:40 -0500
Content-Disposition: inline
In-Reply-To: <52DA7106.5000300@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On Sat, Jan 18, 2014 at 01:18:14PM +0100, Oliver Hartkopp wrote:
> On 17.01.2014 21:36, Uwe Kleine-K=F6nig wrote:
>=20
> >>
> >> https://gitorious.org/linux-can/can-modules
> > Is it a possibility to merge can-modules and can-utils?
>=20
> NO!
Did I hit another red button? If so I'm sorry, that was not my
intention.

> > Then there would
> > only a single instance of isotp.h be needed.=20
>=20
> NO!
?? If can-modules and can-utils were merged both the kernel module and
the userspace stuff could use the same header. I don't understand you
"NO!" here.

> [...]
I don't see a real reason here, but I read between the lines that you
prefer isotp to go into the kernel directly instead of into can-utils
first.
Anyhow, what I care for is to be able to package can-utils for Debian.
That's what I can do once the updated headers hit can-utils so IMO we
can stop arguing even if we don't agree 100%.

@Marc or Oliver: Can you please give me a ping as soon as the headers
hit your public repo. Thanks.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
