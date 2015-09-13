From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [linux-sunxi] [PATCH v5 2/2] can: Allwinner A10/A20 CAN
 Controller support - controller code
Date: Sun, 13 Sep 2015 14:50:34 +0200
Message-ID: <55F5711A.6030002@pengutronix.de>
References: <1442144632-4541-1-git-send-email-info@gerhard-bertelsmann.de>
 <1442144632-4541-3-git-send-email-info@gerhard-bertelsmann.de>
 <20150913124501.GS9885@lukather>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="PeC060g1Oplt0kb87RuBhfvInLBdCJucQ"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40213 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095AbbIMMun (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 13 Sep 2015 08:50:43 -0400
In-Reply-To: <20150913124501.GS9885@lukather>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Maxime Ripard <maxime.ripard@free-electrons.com>, Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
Cc: linux-can@vger.kernel.org, linux-sunxi@googlegroups.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PeC060g1Oplt0kb87RuBhfvInLBdCJucQ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/13/2015 02:45 PM, Maxime Ripard wrote:
>> > +static irqreturn_t sunxi_can_interrupt(int irq, void *dev_id)
>> > +{
>> > +	struct net_device *dev =3D (struct net_device *)dev_id;
>> > +	struct sunxican_priv *priv =3D netdev_priv(dev);
>> > +	struct net_device_stats *stats =3D &dev->stats;
>> > +	u8 isrc, status;
>> > +	int n =3D 0;
>> > +
>> > +	while ((isrc =3D readl(priv->base + SUNXI_REG_INT_ADDR)) &&
>> > +	       (n < SUNXI_CAN_MAX_IRQ)) {
>> > +		n++;
>> > +		status =3D readl(priv->base + SUNXI_REG_STA_ADDR);
>> > +
>> > +		if (isrc & SUNXI_INT_WAKEUP)
>> > +			netdev_warn(dev, "wakeup interrupt\n");
>> > +
>> > +		if (isrc & SUNXI_INT_TBUF_VLD) {
>> > +			/* transmission complete interrupt */
>> > +			stats->tx_bytes +=3D
>> > +			    readl(priv->base +
>> > +				  SUNXI_REG_RBUF_RBACK_START_ADDR) & 0xf;
>> > +			stats->tx_packets++;
>> > +			can_get_echo_skb(dev, 0);
>> > +			netif_wake_queue(dev);
>> > +			can_led_event(dev, CAN_LED_EVENT_TX);
>> > +		}
>> > +		if (isrc & SUNXI_INT_RBUF_VLD) {
>> > +			/* receive interrupt */
>> > +			while (status & SUNXI_STA_RBUF_RDY) {
>> > +				/* RX buffer is not empty */
>> > +				sunxi_can_rx(dev);
>> > +				status =3D readl(priv->base + SUNXI_REG_STA_ADDR);
>> > +			}
>> > +		}
>> > +		if (isrc &
>> > +		    (SUNXI_INT_DATA_OR | SUNXI_INT_ERR_WRN | SUNXI_INT_BUS_ERR |
>> > +		     SUNXI_INT_ERR_PASSIVE | SUNXI_INT_ARB_LOST)) {
>> > +			/* error interrupt */
>> > +			if (sunxi_can_err(dev, isrc, status))
>> > +				break;
>> > +		}
>> > +		/* clear interrupts */
>> > +		writel(isrc, priv->base + SUNXI_REG_INT_ADDR);
>> > +		readl(priv->base + SUNXI_REG_INT_ADDR);
>> > +	}
> Why not simply handle whatever you have in the status register, and
> let the interrupt retrigger if there's something new?

Latency. On CAN Networks you can have an interrupt rate of sevel KHz.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--PeC060g1Oplt0kb87RuBhfvInLBdCJucQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJV9XEaAAoJEP5prqPJtc/HGegH/3S/NgFKhS7aE3ogYO4vsBQ4
7TbtRSDe7yaXjzn98j2SHhZfBHLE0IlmRQE32hY9juLf1hmfwsIZ5yJMNSxca+BR
sQ1t631rU+jXUGUZI61Bn86gL57kVi7Asgx/abs8HAzI4MNkYyNfkzkuCITRmbrB
Pi61K8mMpKm+5YxmtLyYaTlrmm1ek+BCZxL9XWhSYwaejSTbnSCRIzXrfVWefSnn
zUzu/y7ng1uJZ0rGa7HzCSZFrUDdGqTKzZrTlLfcIeVOXlUD+/OCBuvtOvOjILI+
v6QNo4O9n6KTt+FdUIZ91C6sqpgckT9FiMVk79MqrcwiUbPkBJF4Q8RTYhXoNb0=
=MeRl
-----END PGP SIGNATURE-----

--PeC060g1Oplt0kb87RuBhfvInLBdCJucQ--
