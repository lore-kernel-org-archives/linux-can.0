From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 02/14] can: rx-fifo: Increase MB size limit from 32 to
 64
Date: Thu, 06 Nov 2014 09:41:59 +0100
Message-ID: <545B3457.9030207@pengutronix.de>
References: <1415262853-22907-1-git-send-email-david@protonic.nl> <1415262853-22907-3-git-send-email-david@protonic.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="kPO54VUD92tm9Td0NUTCgfvnqIhr5FWC7"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38522 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751062AbaKFKsW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Nov 2014 05:48:22 -0500
In-Reply-To: <1415262853-22907-3-git-send-email-david@protonic.nl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, Alexander Stein <alexander.stein@systec-electronic.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kPO54VUD92tm9Td0NUTCgfvnqIhr5FWC7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/06/2014 09:34 AM, David Jander wrote:
> Signed-off-by: David Jander <david@protonic.nl>
> ---
>  drivers/net/can/dev.c   | 24 ++++++++++++------------
>  include/linux/can/dev.h | 12 ++++++------
>  2 files changed, 18 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
> index c1e53e9..930b9f4 100644
> --- a/drivers/net/can/dev.c
> +++ b/drivers/net/can/dev.c
> @@ -289,20 +289,20 @@ static unsigned int can_rx_fifo_inc(struct can_rx=
_fifo *fifo, unsigned int *val)
>  		return (*val)--;
>  }
> =20
> -static u32 can_rx_fifo_mask_low(struct can_rx_fifo *fifo)
> +static u64 can_rx_fifo_mask_low(struct can_rx_fifo *fifo)
>  {
>  	if (fifo->inc)
> -		return ~0U >> (32 + fifo->low_first - fifo->high_first) << fifo->low=
_first;
> +		return ~0LLU >> (64 + fifo->low_first - fifo->high_first) << fifo->l=
ow_first;
>  	else
> -		return ~0U >> (32 - fifo->low_first + fifo->high_first) << (fifo->hi=
gh_first + 1);
> +		return ~0LLU >> (64 - fifo->low_first + fifo->high_first) << (fifo->=
high_first + 1);

Yesterday I stumbled over GENMASK_ULL
http://lxr.free-electrons.com/source/include/linux/bitops.h#L22
Does it make sense to use it here?

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--kPO54VUD92tm9Td0NUTCgfvnqIhr5FWC7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUWzRXAAoJECte4hHFiupUM/YP/3r7od7uIDd+cXt59A2uGZ90
WkgNQLHNCdCiQvG8p+9GGjkzh7YlTpemL+JdvCl+RqkwAMqbKx7GeBVaz0aS8yUV
LyAb6djiGfFeBpJXUpnjI3xERHu+yxhiufeLU1ZYG80swvG5X/8hKYfXEHDjAL2V
8ctCnjcMjSNkHkdqffi5J/VmrbkhpRyzI6Pu0a1lY1vUl0vZad//GvGduf3w5dhF
eqW9H5mYOVqx+c1yB3IPFtVgBPZ54fPV+KOJCskz6L/ghZOVSS2YOA12NzCIgJYP
a74d4jpbfbyNAfKSB8+7Cx/oh8shygFAvo1JPZ8ZCfxp1bF9cHtgBZEx3DGPnXNB
QSuyk3agwCz6usDjYCXnv6QNhr93a3y0Dne/A6MOCgKXmjLCIQjJmEyjacwx7X9X
/NwEc1Ulxg6qn5MJofu3ZZCXbeDfXLi8Pgrd9mRjjhBykjtJ9Z/S+G0wcJVe2V0/
znpklvirrfGTr/HgmfqM4UnIsj5lY9B02ky2HALyy31HyxRrOkrop7n8Lxge1eeF
cxtRgCdYJ29SYYn9eyhcoJ5btaGd3QV6RqtQ9PVEQv6zZYpG8IkBuNPYuRiFERiC
kODFIEdQmyxh3mEF4fOLexi+E0ZkMFqTaCFIFhtfTAVx+K42PzYvtF9XbXR6j1F/
q7g8HqOGlk8JLV3pljHF
=+4j9
-----END PGP SIGNATURE-----

--kPO54VUD92tm9Td0NUTCgfvnqIhr5FWC7--
