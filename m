From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 09/15] can: rx-fifo: Add can_rx_fifo_reset() function
Date: Mon, 03 Nov 2014 12:16:24 +0100
Message-ID: <54576408.5040709@pengutronix.de>
References: <1412956020-21489-1-git-send-email-david@protonic.nl> <1412956020-21489-10-git-send-email-david@protonic.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="7iuarfW9jDWsAs42xC9NpWO3rXUBPamds"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33576 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631AbaKCLQa (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 3 Nov 2014 06:16:30 -0500
In-Reply-To: <1412956020-21489-10-git-send-email-david@protonic.nl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7iuarfW9jDWsAs42xC9NpWO3rXUBPamds
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/10/2014 05:46 PM, David Jander wrote:
> This function needs to be called every time the CAN controller is reset=

> and before interrupts are enabled. Otherwise the irq-offload loop gets
> out of sync. Detect this and BUG() to the user if he forgot.
>=20
> Signed-off-by: David Jander <david@protonic.nl>
> ---
>  drivers/net/can/dev.c   | 20 ++++++++++++++++++--
>  include/linux/can/dev.h |  1 +
>  2 files changed, 19 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
> index 3e1160a..fc35d28 100644
> --- a/drivers/net/can/dev.c
> +++ b/drivers/net/can/dev.c
> @@ -487,8 +487,17 @@ int can_rx_fifo_irq_offload(struct can_rx_fifo *fi=
fo)
>  		fifo->second_first =3D true;
>  	}
> =20
> -	if (received)
> -		napi_schedule(&fifo->napi);
> +	if (received) {
> +		can_rx_fifo_napi_schedule(fifo);
> +	} else {
> +		/*
> +		 * This should only happen if the CAN conroller was reset, but
> +		 * can_rx_fifo_reset() was not called. BUG();
> +		 */
> +		netdev_warn(fifo->dev, "%s: No messages found,"
> +			    " RX-FIFO out of sync?\n", __func__);
> +		BUG();

Can you replace the BUG() (which crashes the system) by something less
fatal? E.g. by some of the WARN function [1]? Does it make sense to call
the fifo_reset() function after this? We'll loose up to a FIFO size
amount of CAN frames, but the system stays hopefully working.

Marc

[1] http://lxr.free-electrons.com/source/include/asm-generic/bug.h#L84

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--7iuarfW9jDWsAs42xC9NpWO3rXUBPamds
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUV2QIAAoJECte4hHFiupUzrUP/3R9Zsrvv8f6MUOI7D6KoVBy
PErL+ngafOakRk27TavloEhbUUXW3EwKVP9eear7bDLxyKNd9ZVvs+8r7GOKpDP7
k16Dkw1+NkX3pQFkeVcx5H2W/eYVn3BqPrlT0t8hNkC0+r8mzrQcwY0o/jAfBuRU
qu6APRvEm7Hzhz6v4JuNMxJpFOwjitZ3jYT5N1SLgs7V+8+7+PGTt6O6jGnwamMj
i0Ve3NDk2KO7YAmhiiTXgmZMwf5eXc3iNj00oG2jg5MmNz70YtTCIbAV3GqaSmW7
n0cVIkgIKTMStKW+C63GaP1tDP5PG7nsn0+g9ssmKmIaHhN+ZlkU1l7VWlXvUY6y
4AWFh1o3CYSipiSZNW5f6p4zUciXlSsZCaqKBGyOKdFKHUv8+CWlRbL2kD9yX0l7
+Sjs543cN1oSJ+lVdRSF+Z1e14RkzVKs2tJKQw4CJXsxA3CSRWeMKkRJUoYcrtr+
uQIUr8fqGQX8okDhLUB6C921rK1lC36jSmkifa0nZMIhXbHepUtjP2AH0Pzk9coT
17Sef3lI1AoUYQ4DcjFzfgXE0aDq7HYPa+jkOZb4LrXEI4Ye6ZTzcvMLG7qod5+w
RTKvJFML46i4Igkt9/1+DZRdnPzQTNnTTJw2m1mW2n5FW6qSYP+a4u6Xm+O24OlH
PsAQFUgP5NfxJAN52jYP
=MBXx
-----END PGP SIGNATURE-----

--7iuarfW9jDWsAs42xC9NpWO3rXUBPamds--
