From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] mcp251x: mcp2515 stops receiving
Date: Mon, 12 May 2014 19:00:38 +0200
Message-ID: <5370FE36.8020901@pengutronix.de>
References: <2E9F00CBB66AB544A1ACDC59627518BA0DC7ED11@mailserver>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="S4CRA7NRq50JlIpS0Cp4tW67v91kv7MGr"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41799 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752138AbaELRAw (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 12 May 2014 13:00:52 -0400
In-Reply-To: <2E9F00CBB66AB544A1ACDC59627518BA0DC7ED11@mailserver>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Rost, Martin" <Martin.Rost@tonfunk.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Alexander Shiyan <shc_work@mail.ru>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--S4CRA7NRq50JlIpS0Cp4tW67v91kv7MGr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hey Martin,

On 05/08/2014 08:33 AM, Rost, Martin wrote:
> The mcp2515 sometimes seems to trigger an interrupt with the
> corresponding register not being set yet. This makes the driver exit
> the interrupt because there is obviously nothing to do, but the
> interrupt line is kept low. Therefore the driver does not see any
> more interrupts until the chip is reset (via interface down/up).

Hmmmm, I think level triggered interrupt would help here. However not
all interrupt controller support level interrupts and
arch/arm/mach-pxa/icontrol.c sets the trigger to rising edge.

> This patch changes the IST to first check the IRQ registers, and wait
> up to 10 ms if an event really occurrs. If the IRQ register is still
> empty after 10ms, a kernel message gets issued.

What happens if the register is still empty after 10ms? Can we do
something better than the print, which will probably not fix the probem..=
=2E

> The IST loop is rearranged to evaluate the IRQ register at the last
> moment before exiting, to not miss a late irq event.

Alexander, have you seen or heard of this problem before? What do you
think about this workaround?

> ---
> diff --git "a/mcp251x.c" "b/mcp251x.c"
> index ad58ac6..668ce63 100644
> --- "a/mcp251x.c"=09
> +++ "b/mcp251x.c"=09
> @@ -806,15 +806,29 @@ static irqreturn_t mcp251x_can_ist(int irq, void =
*dev_id)
>  	struct mcp251x_priv *priv =3D dev_id;
>  	struct spi_device *spi =3D priv->spi;
>  	struct net_device *net =3D priv->net;
> +	u8 intf, eflag;
> +	u8 retrycount =3D 10;
> =20
>  	mutex_lock(&priv->mcp_lock);
> -	while (!priv->force_quit) {
> +=09
> +	do {
> +	mcp251x_read_2regs(spi, CANINTF, &intf, &eflag);
> +		if (!intf) {
> +//			printk(KERN_CRIT "MCP251x: IRQ delaying.\r\n");

please remove that line

> +			mdelay(1);
> +		}
> +	} while (!intf && (retrycount--));
> +=09
> +	if (!intf)
> +		printk(KERN_CRIT "MCP251x: IRQ without a cause.\r\n");

In Linux, we use \n only, also dev_LEVEL() is preferred over plain printk=
=2E

> +=09
> +	while ((!priv->force_quit) && (intf)) {
>  		enum can_state new_state;
> -		u8 intf, eflag;
> +//		u8 intf, eflag;

please remove, not comment out.

>  		u8 clear_intf =3D 0;
>  		int can_id =3D 0, data1 =3D 0;
> =20
> -		mcp251x_read_2regs(spi, CANINTF, &intf, &eflag);
> +//		mcp251x_read_2regs(spi, CANINTF, &intf, &eflag);

same here

> =20
>  		/* mask out flags we don't care about */
>  		intf &=3D CANINTF_RX | CANINTF_TX | CANINTF_ERR;
> @@ -913,8 +927,8 @@ static irqreturn_t mcp251x_can_ist(int irq, void *d=
ev_id)
>  			}
>  		}
> =20
> -		if (intf =3D=3D 0)
> -			break;
> +//		if (intf =3D=3D 0)
> +//			break;

same here

> =20
>  		if (intf & CANINTF_TX) {
>  			net->stats.tx_packets++;
> @@ -926,6 +940,7 @@ static irqreturn_t mcp251x_can_ist(int irq, void *d=
ev_id)
>  			netif_wake_queue(net);
>  		}
> =20
> +		mcp251x_read_2regs(spi, CANINTF, &intf, &eflag);
>  	}
>  	mutex_unlock(&priv->mcp_lock);
>  	return IRQ_HANDLED;

I'll send a cleaned version of you patch.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--S4CRA7NRq50JlIpS0Cp4tW67v91kv7MGr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlNw/jYACgkQjTAFq1RaXHOO6QCeNtScOZXv19qoGoSRp8GceGlI
gmgAnRzGlauLAt+ghTfKV4fCPjfqx2Cf
=OPPm
-----END PGP SIGNATURE-----

--S4CRA7NRq50JlIpS0Cp4tW67v91kv7MGr--
