From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v6] can: sja1000: fix {pre,post}_irq() handling and IRQ
 handler return value
Date: Thu, 05 Dec 2013 18:50:17 +0100
Message-ID: <52A0BCD9.4090309@grandegger.com>
References: <1385334220-31887-1-git-send-email-mkl@pengutronix.de> <loom.20131205T164221-222@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:38637 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757414Ab3LERuW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 5 Dec 2013 12:50:22 -0500
In-Reply-To: <loom.20131205T164221-222@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Richard Andrysek <richard.andrysek@rg-mechatronics.com>, linux-can@vger.kernel.org

Hi Richard,

On 12/05/2013 04:50 PM, Richard Andrysek wrote:
> Marc Kleine-Budde <mkl <at> pengutronix.de> writes:
>=20
>>
>> From: Oliver Hartkopp <socketcan <at> hartkopp.net>
>>
>> It has been reported that on PREEMPT_RT enabled system the peak SJA1=
000
>> hardware can trigger "irq X: nobody cared" errors.
>>
>> This patch fixes the issue that the sja1000_interrupt() function may=
 have
>> returned IRQ_NONE without processing the optional pre_irq() and post=
_irq()
>> function before. Further the irq processing counter 'n' is moved to =
the end of
>> the while statement to return correct IRQ_[NONE|HANDLED] values at e=
rror
>> conditions.
>>
>> Reported-by: Wolfgang Grandegger <wg <at> grandegger.com>
>> Acked-by: Wolfgang Grandegger <wg <at> grandegger.com>
>> Signed-off-by: Oliver Hartkopp <socketcan <at> hartkopp.net>
>> Signed-off-by: Marc Kleine-Budde <mkl <at> pengutronix.de>
>> ---
>> Changes since v5: make it one patch again.
>>
>>  drivers/net/can/sja1000/sja1000.c | 17 +++++++++--------
>>  1 file changed, 9 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/net/can/sja1000/sja1000.c
> b/drivers/net/can/sja1000/sja1000.c
>> index 7164a99..f17c301 100644
>> --- a/drivers/net/can/sja1000/sja1000.c
>> +++ b/drivers/net/can/sja1000/sja1000.c
>>  <at>  <at>  -494,20 +494,20  <at>  <at>  irqreturn_t
> sja1000_interrupt(int irq, void *dev_id)
>>  	uint8_t isrc, status;
>>  	int n =3D 0;
>>
>> -	/* Shared interrupts and IRQ off? */
>> -	if (priv->read_reg(priv, SJA1000_IER) =3D=3D IRQ_OFF)
>> -		return IRQ_NONE;
>> -
>>  	if (priv->pre_irq)
>>  		priv->pre_irq(priv);
>>
>> +	/* Shared interrupts and IRQ off? */
>> +	if (priv->read_reg(priv, SJA1000_IER) =3D=3D IRQ_OFF)
>> +		goto out;
>> +
>>  	while ((isrc =3D priv->read_reg(priv, SJA1000_IR)) &&
>>  	       (n < SJA1000_MAX_IRQ)) {
>> -		n++;
>> +
>>  		status =3D priv->read_reg(priv, SJA1000_SR);
>>  		/* check for absent controller due to hw unplug */
>>  		if (status =3D=3D 0xFF && sja1000_is_absent(priv))
>> -			return IRQ_NONE;
>> +			goto out;
>>
>>  		if (isrc & IRQ_WUI)
>>  			netdev_warn(dev, "wakeup interrupt\n");
>>  <at>  <at>  -535,7 +535,7  <at>  <at>  irqreturn_t sja1000_interrup=
t(int
> irq, void *dev_id)
>>  				status =3D priv->read_reg(priv, SJA1000_SR);
>>  				/* check for absent controller */
>>  				if (status =3D=3D 0xFF && sja1000_is_absent(priv))
>> -					return IRQ_NONE;
>> +					goto out;
>>  			}
>>  		}
>>  		if (isrc & (IRQ_DOI | IRQ_EI | IRQ_BEI | IRQ_EPI | IRQ_ALI)) {
>>  <at>  <at>  -543,8 +543,9  <at>  <at>  irqreturn_t sja1000_interrup=
t(int
> irq, void *dev_id)
>>  			if (sja1000_err(dev, isrc, status))
>>  				break;
>>  		}
>> +		n++;
>>  	}
>> -
>> +out:
>>  	if (priv->post_irq)
>>  		priv->post_irq(priv);
>>
>=20
> I've used a patch and now I see an another effect.

You mean, the data overruns do not happen without the pach above?

> I see with a dmesg like this: [16773.935134] peak_pci 0000:03:0b.0 ca=
n0:
> data overrun interrupt
> =20
> 	1)Why there are reported as a frame error, by calling ifconfig =96a?
>         $ sudo dmesg | grep "data overrun interrupt" | wc
>           17     136    1122
>=20
>         ~$ sudo ifconfig can0
>          can0      Link encap:UNSPEC  HWaddr
> 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
>           UP RUNNING NOARP  MTU:16  Metric:1
>           RX packets:12711052 errors:17 dropped:0 overruns:0 frame:17
>           TX packets:15023217 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:10
>           RX bytes:101688416 (96.9 MiB)  TX bytes:109206486 (104.1 Mi=
B)
>           Interrupt:19
>=20
>=20
>           Rx errors:17  =3D=3D wc over "data overrun interrupt": 17 =3D=
=3D RX frame
> : 17.
> =20
> 	2) How the data overrun can happen, if the can bus load  is ~25%?

If a bunch of messages is sent in a short time. The 25% is an average
load, I assume.

> 	=20
> 	$ sudo cat /proc/net/can/stats
> 	[sudo] password for ran:
> =20
>   1421819 transmitted frames (TXF)
>   2606493 received frames (RXF)
>    473873 matched frames (RXMF)
> =20
>        18 % total match ratio (RXMR)
>      2400 frames/s total tx rate (TXR)
>      4400 frames/s total rx rate (RXR)
> =20
>        18 % current match ratio (CRXMR)
>      2400 frames/s current tx rate (CTXR)
>      4400 frames/s current rx rate (CRXR)
> =20
>        18 % max match ratio (MRXMR)
>      2427 frames/s max tx rate (MTXR)
>      4427 frames/s max rx rate (MRXR)
> =20
>         4 current receive list entries (CRCV)
>         9 maximum receive list entries (MRCV)
> =20
> 	        2 statistic resets (STR)

  # ip -d -s link show can0

will list the CAN statistics.

Wolfgang.

