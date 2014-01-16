From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: add ability to allocate CANFD frame in skb data
Date: Thu, 16 Jan 2014 17:35:37 +0100
Message-ID: <52D80A59.3020302@pengutronix.de>
References: <1389775813-14838-1-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="lvG8BTmFfrBucBX3JHpdFs7LCDEAmbl2D"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59412 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078AbaAPQfm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 16 Jan 2014 11:35:42 -0500
In-Reply-To: <1389775813-14838-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lvG8BTmFfrBucBX3JHpdFs7LCDEAmbl2D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/15/2014 09:50 AM, Stephane Grosjean wrote:
> This patch adds the ability of allocating a CANFD frame data structure =
in the
> skb data area.
>=20
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
>=20
> ---
>  drivers/net/can/dev.c   | 24 ++++++++++++++++++++++++
>  include/linux/can/dev.h |  2 ++
>  2 files changed, 26 insertions(+)
>=20
> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
> index 13a9098..cb584ea 100644
> --- a/drivers/net/can/dev.c
> +++ b/drivers/net/can/dev.c
> @@ -521,6 +521,30 @@ struct sk_buff *alloc_can_skb(struct net_device *d=
ev, struct can_frame **cf)
>  }
>  EXPORT_SYMBOL_GPL(alloc_can_skb);
> =20
> +struct sk_buff *alloc_canfd_skb(struct net_device *dev,
> +				struct canfd_frame **cfd)

Originally "cf" stands for _c_an _f_rame, but cfd for for CAN-FD frames
ist nice, too :)

applied to can-next
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--lvG8BTmFfrBucBX3JHpdFs7LCDEAmbl2D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlLYClkACgkQjTAFq1RaXHOXcwCfR2/8xTH8PhWz+xpYeShR8cZX
ypcAoIObuXusDjWh185tcxUTnINj0/dM
=mVxg
-----END PGP SIGNATURE-----

--lvG8BTmFfrBucBX3JHpdFs7LCDEAmbl2D--
