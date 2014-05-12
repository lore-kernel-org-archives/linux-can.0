From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCHv3] C_CAN: Add 32-bit accesses
Date: Mon, 12 May 2014 17:47:29 +0200
Message-ID: <5370ED11.4000002@pengutronix.de>
References: <6bf951b6-51e7-4b90-b054-9ba5b6e93874@email.android.com> <20140427122510.GB12901@amd.pavel.ucw.cz> <1398716449.836.4.camel@dinh-ubuntu> <20140428211505.GA28242@amd.pavel.ucw.cz> <CAF03EBf9KXqB4W9GuDduhLwp_kwFjUEi3syU7fX3KpXfZEFxHg@mail.gmail.com> <CAF03EBd19PC5RAsLR6-dMPF2x3XRf9X4bFPgX2kRdCYWUQBYcA@mail.gmail.com> <20140430215359.GA15148@amd.pavel.ucw.cz> <CAF03EBewoV0pOOmNQBwPrKgm-zhaSbFcNd_UiEhFWyUrq91-Jg@mail.gmail.com> <20140502084851.GA5730@amd.pavel.ucw.cz> <20140505120801.GA16461@amd.pavel.ucw.cz> <20140506135702.GA9879@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="ni4VN6xRRcPRa6kgnxAWHweF68bPewKLc"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34763 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751681AbaELPrt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 12 May 2014 11:47:49 -0400
In-Reply-To: <20140506135702.GA9879@amd.pavel.ucw.cz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pavel Machek <pavel@denx.de>, Thor Thayer <tthayer.linux@gmail.com>
Cc: Thor Thayer <tthayer@altera.com>, Dinh Nguyen <dinguyen@altera.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org, socketcan@hartkopp.net, wg@grandegger.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ni4VN6xRRcPRa6kgnxAWHweF68bPewKLc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 05/06/2014 03:57 PM, Pavel Machek wrote:
> Add helpers for 32-bit accesses and replace open-coded 32-bit access
> with calls to helpers. Minimum changes are done to the pci case, as I
> don't have access to that hardware.

I'll ask David Miller to merge net/master into net-next/master so that I
can apply this patch.

For now, I've applied the patch to can-next testing-c_can
(git://gitorious.org/linux-can/linux-can-next.git testing-c_can)

Can you make other patches based on that tree, please.

> --- a/drivers/net/can/c_can/c_can_pci.c
> +++ b/drivers/net/can/c_can/c_can_pci.c
> @@ -63,6 +63,23 @@ static void c_can_pci_write_reg_aligned_to_32bit(str=
uct c_can_priv *priv,
>  	writew(val, priv->base + 2 * priv->regs[index]);
>  }
> =20
> +static u32 c_can_plat_read_reg32(struct c_can_priv *priv, enum reg ind=
ex)
> +{
> +	u32 val;
> +
> +	val =3D priv->read_reg(priv, index);
> +	val |=3D ((u32) priv->read_reg(priv, index + 1)) << 16;
> +
> +	return val;
> +}
> +
> +static void c_can_plat_write_reg32(struct c_can_priv *priv, enum reg i=
ndex,
> +		u32 val)
> +{
> +	priv->write_reg(priv, index + 1, val>>16);

spaces around >>, I'll fix this while applying.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--ni4VN6xRRcPRa6kgnxAWHweF68bPewKLc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlNw7REACgkQjTAFq1RaXHNdHACfecmZBZ3k6iTRWMT1MqIjmDSU
ohwAoIDr5XPXcaT1aeDGJSnX5xO8iFe0
=/G5I
-----END PGP SIGNATURE-----

--ni4VN6xRRcPRa6kgnxAWHweF68bPewKLc--
