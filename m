From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v4 4/5] can: flexcan: put TX mailbox into TX_INACTIVE
 mode after tx-complete
Date: Tue, 16 Sep 2014 17:28:46 +0200
Message-ID: <5418572E.2090304@pengutronix.de>
References: <1410877234-29751-1-git-send-email-mkl@pengutronix.de>	<1410877234-29751-4-git-send-email-mkl@pengutronix.de> <20140916171848.7aca14ed@archvile>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="wseNLaFnhmhSkD07LE9h1TvQjf60NAvru"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49418 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540AbaIPP2w (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 16 Sep 2014 11:28:52 -0400
In-Reply-To: <20140916171848.7aca14ed@archvile>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wseNLaFnhmhSkD07LE9h1TvQjf60NAvru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/16/2014 05:18 PM, David Jander wrote:
> On Tue, 16 Sep 2014 16:20:33 +0200
> Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>=20
>> After sending a RTR frame the TX mailbox becomes a RX_EMPTY mailbox. T=
o avoid
>> side effects when the RX-FIFO is full, this patch puts the TX mailbox =
into
>> TX_INACTIVE mode after the transmission has been completed.
>>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>>
>> Changes since v3:
>> - new
>>
>>  drivers/net/can/flexcan.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
>> index 54061c4..c17ae9e 100644
>> --- a/drivers/net/can/flexcan.c
>> +++ b/drivers/net/can/flexcan.c
>> @@ -765,6 +765,9 @@ static irqreturn_t flexcan_irq(int irq, void *dev_=
id)
>>  		stats->tx_bytes +=3D can_get_echo_skb(dev, 0);
>>  		stats->tx_packets++;
>>  		can_led_event(dev, CAN_LED_EVENT_TX);
>> +		/* after sending a RTR frame mailbox is in RX mode */
>> +		flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
>> +			      &regs->cantxfg[FLEXCAN_TX_BUF_ID].can_ctrl);
>>  		flexcan_write((1 << FLEXCAN_TX_BUF_ID), &regs->iflag1);
>>  		netif_wake_queue(dev);
>>  	}
>=20
> Good one. I hadn't notice that case yet.

Just stumbled over it, the reference manual is a bit vague, it this
mailbox will receive any CAN frame or just a CAN frame with the same ID.

> Since you do this in the IRQ, I assume the expected race-condition wind=
ow is
> minimal, but AFAICS there is stil a (very) small chance of a race if an=


Yes, there's a race window.

> overflow message arrives before this code in the IRQ handler is reached=
=2E
> Both chance of occurring and impact is so small that it will not likely=
 be a
> problem ever... besides the fact that it cannot be avoided. Should this=
 be
> mentioned?

Good point, I'll add a comment to the code.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--wseNLaFnhmhSkD07LE9h1TvQjf60NAvru
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlQYVy4ACgkQjTAFq1RaXHP2qQCfcCte4Tb98iMHLC/a7aoaZS49
9VMAn386liDX7lgUzpivCgmyFVCwYFWN
=B/7B
-----END PGP SIGNATURE-----

--wseNLaFnhmhSkD07LE9h1TvQjf60NAvru--
