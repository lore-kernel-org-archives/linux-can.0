From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: ti_hecc: fix rx wrong sequence issue
Date: Mon, 05 Nov 2012 14:56:55 +0100
Message-ID: <5097C5A7.4010002@pengutronix.de>
References: <1349678436-747-1-git-send-email-anilkumar@ti.com> <5097A45F.3000606@pengutronix.de> <331ABD5ECB02734CA317220B2BBEABC13EA647DC@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFE398427E8A65E446457C55D"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44676 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932464Ab2KEN5I (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 5 Nov 2012 08:57:08 -0500
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA647DC@DBDE01.ent.ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "Gole, Anant" <anantgole@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFE398427E8A65E446457C55D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/05/2012 02:47 PM, AnilKumar, Chimata wrote:
> On Mon, Nov 05, 2012 at 17:04:55, Marc Kleine-Budde wrote:
>> Hello,
>=20
> Hi Marc,
>=20
> Thanks for looking into this issue, I had spent some considerable
> time for debugging this issue, I have seen better sequence with
> below changes at 500KBPS but issue still there. Because of some
> other higher priority task I left there.

I'm testing with cansequence at 500 kbit/s at the moment. With my
current patch, I'm not seeing any out-of-order problem. With "ping -f"
and serial load, the driver goes into a rx-overflow. But this is
probably due to too high load.

The hardware I'm using has an issue with 1Mbit/s, thus I cannot test this=
=2E

> Some of my observations in the driver:-
> 1. One is buffer mailbox (12th mailbox we are missing)
>=20
> @@ -627,18 +617,34 @@ static int ti_hecc_rx_poll(struct napi_struct *na=
pi, int quota)
>  			if (ti_hecc_rx_pkt(priv, priv->rx_next) < 0)
>  				return num_pkts;
>  			++num_pkts;
> -		} else if (priv->rx_next > HECC_RX_BUFFER_MBOX) {
> +		} else if (priv->rx_next >=3D HECC_RX_BUFFER_MBOX) {
>  			break; /* pkt not received yet */
>  		}
>  		--priv->rx_next;
> -		if (priv->rx_next =3D=3D HECC_RX_BUFFER_MBOX) {
> -			/* enable high bank mailboxes */
> -			spin_lock_irqsave(&priv->mbx_lock, flags);
> +		if (priv->rx_next =3D=3D (HECC_RX_BUFFER_MBOX - 1)) {
>=20
> 2. Lower mail box configuration is not happening properly. I have
> changed this.
> 3. Removed spinlocks (Just for testing)

I've reworked the poll-loop completely.

[...]

> I can test the series if your patches are ready.

I'll send you a preliminary version to test soon, it wouldn't be finial,
but you can test, also include 1Mbit/s.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigFE398427E8A65E446457C55D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlCXxaoACgkQjTAFq1RaXHM9eQCggIH9pF/cBvuuKI57P36xyF9+
urYAoJL8sU7lnCqa8We7M0TmZyd3EYYR
=cgXc
-----END PGP SIGNATURE-----

--------------enigFE398427E8A65E446457C55D--
