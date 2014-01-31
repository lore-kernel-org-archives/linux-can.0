From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/2] canbusload: Add exact CAN frame length calculation
 (including bitstuffing)
Date: Fri, 31 Jan 2014 11:17:20 +0100
Message-ID: <52EB7830.2080604@pengutronix.de>
References: <87fvo5k2w2.fsf@steelpick.2x.cz> <1391089139-31201-1-git-send-email-sojkam1@fel.cvut.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="UM2dxkXbnQ1dOSnxuu9PAl1WinAJLbbfR"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43838 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751463AbaAaKRV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 31 Jan 2014 05:17:21 -0500
In-Reply-To: <1391089139-31201-1-git-send-email-sojkam1@fel.cvut.cz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michal Sojka <sojkam1@fel.cvut.cz>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UM2dxkXbnQ1dOSnxuu9PAl1WinAJLbbfR
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/30/2014 02:38 PM, Michal Sojka wrote:

> diff --git a/canframelen.h b/canframelen.h
> new file mode 100644
> index 0000000..225bc09
> --- /dev/null
> +++ b/canframelen.h
> @@ -0,0 +1,35 @@
> +#ifndef CANFRAMELEN_H
> +#define CANFRAMELEN_H
> +
> +#include <linux/can.h>
> +
> +/**
> + * Frame length calculation modes.
> + *
> + * CFL_WORSTCASE corresponds to Ken Tindells *worst* case calculation
> + * for stuff-bits (see "Guaranteeing Message Latencies on Controller
> + * Area Network" 1st ICC'94) the needed bits on the wire can be
> + * calculated as:
> + *
> + * (34 + 8n)/5 + 47 + 8n for SFF frames (11 bit CAN-ID) =3D> (269 + 48=
n)/5
> + * (54 + 8n)/5 + 67 + 8n for EFF frames (29 bit CAN-ID) =3D> (389 + 48=
n)/5
> + *
> + * while 'n' is the data length code (number of payload bytes)
> + *
> + */

Can you please post a patch against the new master and add a license
header to this file.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--UM2dxkXbnQ1dOSnxuu9PAl1WinAJLbbfR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlLreDAACgkQjTAFq1RaXHNOGACgkgiZzB9wU7o91uxtLiIC7AK8
SZwAnRNhFuw8kzOCz+1wyIVEouAFIUtG
=baCE
-----END PGP SIGNATURE-----

--UM2dxkXbnQ1dOSnxuu9PAl1WinAJLbbfR--
