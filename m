From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH v3] can/sja1000: add support for PEAK-System PCMCIA card
Date: Tue, 14 Feb 2012 11:16:51 +0100
Message-ID: <4F3A3493.8010900@peak-system.com>
References: <1328543779-9209-1-git-send-email-s.grosjean@peak-system.com>
 <4F38D46D.5010406@pengutronix.de> <4F38DF75.3040000@peak-system.com>
 <4F38E274.4050304@grandegger.com> <4F38E8DA.9060000@hartkopp.net>
 <4F38EDB1.7080209@grandegger.com> <4F38EEAD.3060607@pengutronix.de>
 <4F38EF3A.7040907@grandegger.com> <4F396AC9.8090308@hartkopp.net>
 <4F397145.8040007@grandegger.com> <4F3A307C.1050706@hartkopp.net>
Reply-To: Stephane Grosjean <s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:39549 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759879Ab2BNKQ7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 14 Feb 2012 05:16:59 -0500
In-Reply-To: <4F3A307C.1050706@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can Mailing List <linux-can@vger.kernel.org>


Le 14/02/2012 10:59, Oliver Hartkopp a =C3=A9crit :

> @@ -492,6 +492,9 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_=
id)
>   	while ((isrc =3D priv->read_reg(priv, REG_IR))&&  (n<  SJA1000_MAX=
_IRQ)) {
>   		n++;
>   		status =3D priv->read_reg(priv, REG_SR);
> +		/* check for absent controller due to hw unplug */
> +		if (status =3D=3D 0xFF&&  !sja1000_probe_chip(dev))
> +			break;
>
>   		if (isrc&  IRQ_WUI)
>   			netdev_warn(dev, "wakeup interrupt\n");
> @@ -508,6 +511,9 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_=
id)
>   			while (status&  SR_RBS) {
>   				sja1000_rx(dev);
>   				status =3D priv->read_reg(priv, REG_SR);
> +				/* check for absent controller */
> +				if (status =3D=3D 0xFF&&  !sja1000_probe_chip(dev))
> +					break;
>   			}
>   		}
>   		if (isrc&  (IRQ_DOI | IRQ_EI | IRQ_BEI | IRQ_EPI | IRQ_ALI)) {
>
> The big advantage is, that we do not need another expensive register =
read nor
> another loop counter variable in the case everything is working fine.
>
> Only when the _already_ read status variable becomes 0xFF we check in=
 the
> mode register if the device is still present.
>
> And finally there's a very little chance left to create rubbish data.


Quite perfect, except that we will push a "rubbish" error frame before=20
exiting, and we will return IRQ_HANDLED while I would prefer IRQ_NONE..=
=2E
But does it matter?

Moreover, regarding to this patch, should the peak_pcmcia custom isr=20
always test for the card presence? I mean, this costs at least 2xtwo=20
ioread8 for each hw irq!


St=C3=A9phane

--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
