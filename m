From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 2/2] net: flexcan: add transceiver switch gpios support
Date: Thu, 28 Jun 2012 20:40:10 +0800
Message-ID: <20120628124008.GB23422@S2101-09.ap.freescale.net>
References: <1340853701-4488-1-git-send-email-shawn.guo@linaro.org>
 <1340853701-4488-3-git-send-email-shawn.guo@linaro.org>
 <20120628113327.GJ6406@shlinux2.ap.freescale.net>
 <20120628114559.GE22990@S2101-09.ap.freescale.net>
 <4FEC487A.2050901@pengutronix.de>
 <20120628121817.GA5755@shlinux2.ap.freescale.net>
 <20460.20182.552394.407578@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from va3ehsobe004.messaging.microsoft.com ([216.32.180.14]:38855
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753557Ab2F1Mjy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 28 Jun 2012 08:39:54 -0400
Content-Disposition: inline
In-Reply-To: <20460.20182.552394.407578@ipc1.ka-ro>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: Dong Aisheng <aisheng.dong@freescale.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Hui Wang <jason77.wang@gmail.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Dong Aisheng-B29396 <B29396@freescale.com>, "David S. Miller" <davem@davemloft.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Jun 28, 2012 at 02:32:22PM +0200, Lothar Wa=DFmann wrote:
> I have created a 'gpio-switch' driver in my private tree that can be
> used for exactly this purpose. It takes care of the pin polarity and
> initial state of the pins and can handle shared pins like in this
> case. The client driver does not even need to care whether an actual
> GPIO exists for the current platform.
>=20
> I could prepare a patch and post it here.
>=20
That would be great.

--=20
Regards,
Shawn

