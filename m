From: Richard Andrysek <richard.andrysek@rg-mechatronics.com>
Subject: Re: [PATCH v6] can: sja1000: fix =?utf-8?b?e3ByZSxwb3N0fV9pcnEoKQ==?= handling and IRQ handler return value
Date: Thu, 5 Dec 2013 15:50:33 +0000 (UTC)
Message-ID: <loom.20131205T164221-222@post.gmane.org>
References: <1385334220-31887-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:52085 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751545Ab3LEPzF (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 5 Dec 2013 10:55:05 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1VobGZ-0006wG-Df
	for linux-can@vger.kernel.org; Thu, 05 Dec 2013 16:55:03 +0100
Received: from apollon.rg-mechatronics.com ([62.225.122.120])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 05 Dec 2013 16:55:03 +0100
Received: from richard.andrysek by apollon.rg-mechatronics.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 05 Dec 2013 16:55:03 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Marc Kleine-Budde <mkl <at> pengutronix.de> writes:

>=20
> From: Oliver Hartkopp <socketcan <at> hartkopp.net>
>=20
> It has been reported that on PREEMPT_RT enabled system the peak SJA10=
00
> hardware can trigger "irq X: nobody cared" errors.
>=20
> This patch fixes the issue that the sja1000_interrupt() function may =
have
> returned IRQ_NONE without processing the optional pre_irq() and post_=
irq()
> function before. Further the irq processing counter 'n' is moved to t=
he end of
> the while statement to return correct IRQ_[NONE|HANDLED] values at er=
ror
> conditions.
>=20
> Reported-by: Wolfgang Grandegger <wg <at> grandegger.com>
> Acked-by: Wolfgang Grandegger <wg <at> grandegger.com>
> Signed-off-by: Oliver Hartkopp <socketcan <at> hartkopp.net>
> Signed-off-by: Marc Kleine-Budde <mkl <at> pengutronix.de>
> ---
> Changes since v5: make it one patch again.
>=20
>  drivers/net/can/sja1000/sja1000.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/net/can/sja1000/sja1000.c
b/drivers/net/can/sja1000/sja1000.c
> index 7164a99..f17c301 100644
> --- a/drivers/net/can/sja1000/sja1000.c
> +++ b/drivers/net/can/sja1000/sja1000.c
>  <at>  <at>  -494,20 +494,20  <at>  <at>  irqreturn_t
sja1000_interrupt(int irq, void *dev_id)
>  	uint8_t isrc, status;
>  	int n =3D 0;
>=20
> -	/* Shared interrupts and IRQ off? */
> -	if (priv->read_reg(priv, SJA1000_IER) =3D=3D IRQ_OFF)
> -		return IRQ_NONE;
> -
>  	if (priv->pre_irq)
>  		priv->pre_irq(priv);
>=20
> +	/* Shared interrupts and IRQ off? */
> +	if (priv->read_reg(priv, SJA1000_IER) =3D=3D IRQ_OFF)
> +		goto out;
> +
>  	while ((isrc =3D priv->read_reg(priv, SJA1000_IR)) &&
>  	       (n < SJA1000_MAX_IRQ)) {
> -		n++;
> +
>  		status =3D priv->read_reg(priv, SJA1000_SR);
>  		/* check for absent controller due to hw unplug */
>  		if (status =3D=3D 0xFF && sja1000_is_absent(priv))
> -			return IRQ_NONE;
> +			goto out;
>=20
>  		if (isrc & IRQ_WUI)
>  			netdev_warn(dev, "wakeup interrupt\n");
>  <at>  <at>  -535,7 +535,7  <at>  <at>  irqreturn_t sja1000_interrupt=
(int
irq, void *dev_id)
>  				status =3D priv->read_reg(priv, SJA1000_SR);
>  				/* check for absent controller */
>  				if (status =3D=3D 0xFF && sja1000_is_absent(priv))
> -					return IRQ_NONE;
> +					goto out;
>  			}
>  		}
>  		if (isrc & (IRQ_DOI | IRQ_EI | IRQ_BEI | IRQ_EPI | IRQ_ALI)) {
>  <at>  <at>  -543,8 +543,9  <at>  <at>  irqreturn_t sja1000_interrupt=
(int
irq, void *dev_id)
>  			if (sja1000_err(dev, isrc, status))
>  				break;
>  		}
> +		n++;
>  	}
> -
> +out:
>  	if (priv->post_irq)
>  		priv->post_irq(priv);
>=20

I've used a patch and now I see an another effect.
I see with a dmesg like this: [16773.935134] peak_pci 0000:03:0b.0 can0=
:
data overrun interrupt
=C2=A0
	1)Why there are reported as a frame error, by calling ifconfig =E2=80=93=
a?
        $ sudo dmesg | grep "data overrun interrupt" | wc
          17     136    1122

        ~$ sudo ifconfig can0
         can0      Link encap:UNSPEC  HWaddr
00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
          UP RUNNING NOARP  MTU:16  Metric:1
          RX packets:12711052 errors:17 dropped:0 overruns:0 frame:17
          TX packets:15023217 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:10
          RX bytes:101688416 (96.9 MiB)  TX bytes:109206486 (104.1 MiB)
          Interrupt:19


          Rx errors:17  =3D=3D wc over "data overrun interrupt": 17 =3D=
=3D RX frame
: 17.
=C2=A0
	2) How the data overrun can happen, if the can bus load =C2=A0is ~25%?
	=C2=A0
	$ sudo cat /proc/net/can/stats
	[sudo] password for ran:
=C2=A0
=C2=A0 1421819 transmitted frames (TXF)
=C2=A0 2606493 received frames (RXF)
=C2=A0=C2=A0 473873 matched frames (RXMF)
=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 18 % total match ratio (RXMR)
=C2=A0=C2=A0=C2=A0=C2=A0 2400 frames/s total tx rate (TXR)
=C2=A0=C2=A0=C2=A0=C2=A0 4400 frames/s total rx rate (RXR)
=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 18 % current match ratio (CRXMR)
=C2=A0=C2=A0=C2=A0=C2=A0 2400 frames/s current tx rate (CTXR)
=C2=A0=C2=A0=C2=A0=C2=A0 4400 frames/s current rx rate (CRXR)
=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 18 % max match ratio (MRXMR)
=C2=A0=C2=A0=C2=A0=C2=A0 2427 frames/s max tx rate (MTXR)
=C2=A0=C2=A0=C2=A0=C2=A0 4427 frames/s max rx rate (MRXR)
=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4 current receive list entri=
es (CRCV)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 9 maximum receive list entri=
es (MRCV)
=C2=A0
	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2 statistic resets (STR)





