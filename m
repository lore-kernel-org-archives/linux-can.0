From: "Schmitt, Sven (EVM/8)" <Sven.Schmitt@volkswagen.de>
Subject: AW: [PATCH 2/2] can: sja1000_platform: fix wrong flag IRQF_SHARED for interrupt sharing
Date: Fri, 10 Aug 2012 11:11:56 +0200
Message-ID: <6C5A3B79888A804CAB605257CD26D37703955BD4@vwagwox00032.vw.vwg>
References: <1344588862-26470-1-git-send-email-mkl@pengutronix.de> <1344588862-26470-3-git-send-email-mkl@pengutronix.de> <1901872510.399.1344589036713.JavaMail.trustmail@VW2BWOSEVG04>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mr1.volkswagen.de ([194.114.62.75]:34417 "EHLO
	mr1.volkswagen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758012Ab2HJJMA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 10 Aug 2012 05:12:00 -0400
Content-class: urn:content-classes:message
In-Reply-To: <1901872510.399.1344589036713.JavaMail.trustmail@VW2BWOSEVG04>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

I prefer the simple one:
Sven Schmitt <sven.schmitt@volkswagen.de>

i am checking if my mail client allows me to use this simple one.

Sven


-----Urspr=FCngliche Nachricht-----
Von: linux-can-owner@vger.kernel.org [mailto:linux-can-owner@vger.kerne=
l.org] Im Auftrag von Marc Kleine-Budde
Gesendet: Freitag, 10. August 2012 10:57
An: Marc Kleine-Budde
Cc: linux-can@vger.kernel.org; Schmitt, Sven (EVM/8)
Betreff: Re: [PATCH 2/2] can: sja1000_platform: fix wrong flag IRQF_SHA=
RED for interrupt sharing

Hello Sven,

On 08/10/2012 10:54 AM, Marc Kleine-Budde wrote:
> From: "Schmitt, Sven (EVM/8)" <Sven.Schmitt@volkswagen.de>
>=20
> The sja1000 platform driver wrongly assumes that a shared IRQ is indi=
cated
> with the IRQF_SHARED flag in irq resource flags. This patch changes t=
he
> driver to handle the correct flag IORESOURCE_IRQ_SHAREABLE instead.
>=20
> There are no mainline users of the platform driver which wrongly make=
 use
> of IRQF_SHARED.
>=20
> Signed-off-by: Sven Schmitt <sven.schmitt@volkswagen.de>
> Acked-by: Yegor Yefremov <yegorslists@googlemail.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

I just noticed that your email addresses are slightly different, which
do you prefer?

    "Schmitt, Sven (EVM/8)" <Sven.Schmitt@volkswagen.de>
    Sven Schmitt <sven.schmitt@volkswagen.de>

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

