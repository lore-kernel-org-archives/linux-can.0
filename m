From: =?utf-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: Re: [PATCH v2 2/2] net: flexcan: add transceiver switch gpios support
Date: Thu, 28 Jun 2012 14:07:57 +0200
Message-ID: <20460.18717.17688.965250@ipc1.ka-ro>
References: <1340853701-4488-1-git-send-email-shawn.guo@linaro.org>
	<1340853701-4488-3-git-send-email-shawn.guo@linaro.org>
	<4FEC329C.7070004@pengutronix.de>
	<20120628112111.GC22990@S2101-09.ap.freescale.net>
	<4FEC400F.8010506@pengutronix.de>
	<20120628114108.GD22990@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:62919 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752177Ab2F1MIS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 28 Jun 2012 08:08:18 -0400
In-Reply-To: <20120628114108.GD22990@S2101-09.ap.freescale.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Hui Wang <jason77.wang@gmail.com>, "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org

Hi,

Shawn Guo writes:
> On Thu, Jun 28, 2012 at 01:29:19PM +0200, Marc Kleine-Budde wrote:
> > I mean which name is more precise, do these gpio enable/standy a "p=
hy"
> > or a "transceiver". For example:
> > http://www.nxp.com/documents/application_note/AN00094.pdf, this doc=
ument
> > says: TJA1041/1041A high speed CAN transceiver.
> >=20
> Isn't term "phy" (physical interface) generally meant to be the same
> thing as "transceiver"?  I just happened to like the shorter one as
> what Hui did in his patch.
>=20
> But it does not really matter to me, will change the name since you
> care about it.
>=20
A transceiver is just a dumb piece of hardware, while a PHY contains
some intelligence of its own.


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
