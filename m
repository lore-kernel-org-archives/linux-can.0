From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 5/6] can: janz-ican3: avoid firmware lockup caused by
 infinite bus error quota
Date: Thu, 19 Jul 2012 10:35:16 +0200
Message-ID: <5007C6C4.1070301@pengutronix.de>
References: <1342650798-2991-1-git-send-email-iws@ovro.caltech.edu> <1342650798-2991-6-git-send-email-iws@ovro.caltech.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBD0B3F5AF32742906E54F022"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54484 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752471Ab2GSIfS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 19 Jul 2012 04:35:18 -0400
In-Reply-To: <1342650798-2991-6-git-send-email-iws@ovro.caltech.edu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBD0B3F5AF32742906E54F022
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/19/2012 12:33 AM, Ira W. Snyder wrote:
> From: "Ira W. Snyder" <iws@ovro.caltech.edu>
>=20
> If the bus error quota is set to infinite and the host CPU cannot keep
> up, the Janz VMOD-ICAN3 firmware will stop responding to control
> messages until the controller is reset.
>=20
> The firmware will automatically stop sending bus error messages when th=
e
> quota is reached, and will only resume sending bus error messages when
> the quota is re-set to a positive value.
>=20
> This limitation is worked around by setting the bus error quota to one
> message, and then re-setting the quota to one message every time a bus
> error message is received. By doing this, the firmware never stops
> responding to control messages. The CAN bus can be reset without a
> hard-reset of the controller card.
>=20
> Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>

looks good.

Marc
> ---
>  drivers/net/can/janz-ican3.c |   13 ++++++++++++-
>  1 files changed, 12 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.=
c
> index 1304712..df3ba07 100644
> --- a/drivers/net/can/janz-ican3.c
> +++ b/drivers/net/can/janz-ican3.c
> @@ -960,6 +960,7 @@ static int ican3_handle_cevtind(struct ican3_dev *m=
od, struct ican3_msg *msg)
>  	 * skb allocation when it will just be freed immediately.
>  	 */
>  	if (isrc =3D=3D CEVTIND_BEI) {
> +		int ret;
>  		dev_dbg(mod->dev, "bus error interrupt, part 1\n");
> =20
>  		/* TX error */
> @@ -970,6 +971,16 @@ static int ican3_handle_cevtind(struct ican3_dev *=
mod, struct ican3_msg *msg)
>  			stats->rx_errors++;
>  		}
> =20
> +		/*
> +		 * The controller automatically disables bus-error interrupts
> +		 * and therefore we must re-enable them.
> +		 */
> +		ret =3D ican3_set_buserror(mod, 1);
> +		if (ret) {
> +			dev_err(mod->dev, "unable to re-enable bus-error\n");
> +			return ret;
> +		}
> +
>  		/* bus error reporting is off, return immediately */
>  		if (!(mod->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
>  			return 0;
> @@ -1447,7 +1458,7 @@ static int __devinit ican3_startup_module(struct =
ican3_dev *mod)
>  	}
> =20
>  	/* default to "bus errors enabled" */
> -	ret =3D ican3_set_buserror(mod, ICAN3_BUSERR_QUOTA_MAX);
> +	ret =3D ican3_set_buserror(mod, 1);
>  	if (ret) {
>  		dev_err(mod->dev, "unable to set bus-error\n");
>  		return ret;


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigBD0B3F5AF32742906E54F022
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAHxsQACgkQjTAFq1RaXHM+JACcCjqEAIeY3MB6Nr/V5O09+U+Y
pKAAnR5xykxt1JHBiL4zjoYOHAjcgFk2
=l1U4
-----END PGP SIGNATURE-----

--------------enigBD0B3F5AF32742906E54F022--
