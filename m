From: =?utf-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: Re: [PATCH v2 2/2] net: flexcan: add transceiver switch gpios support
Date: Thu, 28 Jun 2012 14:24:32 +0200
Message-ID: <20460.19712.158996.397146@ipc1.ka-ro>
References: <1340853701-4488-1-git-send-email-shawn.guo@linaro.org>
	<1340853701-4488-3-git-send-email-shawn.guo@linaro.org>
	<4FEC329C.7070004@pengutronix.de>
	<20120628112111.GC22990@S2101-09.ap.freescale.net>
	<4FEC400F.8010506@pengutronix.de>
	<20120628114108.GD22990@S2101-09.ap.freescale.net>
	<20460.18717.17688.965250@ipc1.ka-ro>
	<20120628121302.GI22990@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:64302 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752726Ab2F1MYq (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 28 Jun 2012 08:24:46 -0400
In-Reply-To: <20120628121302.GI22990@S2101-09.ap.freescale.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Hui Wang <jason77.wang@gmail.com>, "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org

Hi,

Shawn Guo writes:
> On Thu, Jun 28, 2012 at 02:07:57PM +0200, Lothar Wa=C3=9Fmann wrote:
> > Hi,
> >=20
> > Shawn Guo writes:
> > > On Thu, Jun 28, 2012 at 01:29:19PM +0200, Marc Kleine-Budde wrote=
:
> > > > I mean which name is more precise, do these gpio enable/standy =
a "phy"
> > > > or a "transceiver". For example:
> > > > http://www.nxp.com/documents/application_note/AN00094.pdf, this=
 document
> > > > says: TJA1041/1041A high speed CAN transceiver.
> > > >=20
> > > Isn't term "phy" (physical interface) generally meant to be the s=
ame
> > > thing as "transceiver"?  I just happened to like the shorter one =
as
> > > what Hui did in his patch.
> > >=20
> > > But it does not really matter to me, will change the name since y=
ou
> > > care about it.
> > >=20
> > A transceiver is just a dumb piece of hardware, while a PHY contain=
s
> > some intelligence of its own.
> >=20
> Then, it sounds more like a PHY than transceiver, since it's an IC
> chip with some control over it.
>=20
The 'I' in 'IC' does not stand for 'intelligent', but for
'integrated'. ;)
A can transceiver is usually merely a switchable buffer. There are no
registers to configure it or an internal processor that does some
magic.


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
