From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 2/2] net: flexcan: add transceiver switch gpios support
Date: Thu, 28 Jun 2012 20:13:04 +0800
Message-ID: <20120628121302.GI22990@S2101-09.ap.freescale.net>
References: <1340853701-4488-1-git-send-email-shawn.guo@linaro.org>
 <1340853701-4488-3-git-send-email-shawn.guo@linaro.org>
 <4FEC329C.7070004@pengutronix.de>
 <20120628112111.GC22990@S2101-09.ap.freescale.net>
 <4FEC400F.8010506@pengutronix.de>
 <20120628114108.GD22990@S2101-09.ap.freescale.net>
 <20460.18717.17688.965250@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:39084
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752126Ab2F1MMv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 28 Jun 2012 08:12:51 -0400
Content-Disposition: inline
In-Reply-To: <20460.18717.17688.965250@ipc1.ka-ro>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Hui Wang <jason77.wang@gmail.com>, "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org

On Thu, Jun 28, 2012 at 02:07:57PM +0200, Lothar Wa=DFmann wrote:
> Hi,
>=20
> Shawn Guo writes:
> > On Thu, Jun 28, 2012 at 01:29:19PM +0200, Marc Kleine-Budde wrote:
> > > I mean which name is more precise, do these gpio enable/standy a =
"phy"
> > > or a "transceiver". For example:
> > > http://www.nxp.com/documents/application_note/AN00094.pdf, this d=
ocument
> > > says: TJA1041/1041A high speed CAN transceiver.
> > >=20
> > Isn't term "phy" (physical interface) generally meant to be the sam=
e
> > thing as "transceiver"?  I just happened to like the shorter one as
> > what Hui did in his patch.
> >=20
> > But it does not really matter to me, will change the name since you
> > care about it.
> >=20
> A transceiver is just a dumb piece of hardware, while a PHY contains
> some intelligence of its own.
>=20
Then, it sounds more like a PHY than transceiver, since it's an IC
chip with some control over it.

--=20
Regards,
Shawn

