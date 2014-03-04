From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v9 0/7] Add CAN FD infrastructure for CAN driver
Date: Tue, 04 Mar 2014 10:22:25 +0100
Message-ID: <53159B51.4020704@pengutronix.de>
References: <1393601785-4631-1-git-send-email-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="uuPo7GdB8CpaqWBtIstM1Ugi1nlJXKOfa"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41380 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752195AbaCDJWc (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 4 Mar 2014 04:22:32 -0500
In-Reply-To: <1393601785-4631-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org, Stephane Grosjean <s.grosjean@peak-system.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uuPo7GdB8CpaqWBtIstM1Ugi1nlJXKOfa
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 02/28/2014 04:36 PM, Oliver Hartkopp wrote:
> This is the patch series to extend the CAN driver infrastructure with C=
AN FD.
>=20
> Changes v8 -> v9:
>=20
> Fixed a whitepace issue in patch 4 and added a comment about the differ=
ent
> configuration options.
>=20
> *** BLURB HERE ***
>=20
> Oliver Hartkopp (7):
>   can: preserve skbuff protocol in can_put_echo_skb
>   can: only send bitrate data via netlink when available
>   can: move sanity check for bitrate and tq into can_get_bittiming
>   can: provide a separate bittiming_const parameter to bittiming
>     functions
>   can: introduce the data bitrate configuration for CAN FD
>   can: allow to change the device mtu for CAN FD capable devices
>   can: add bittiming check at interface open for CAN FD
>=20
>  drivers/net/can/dev.c            | 160 ++++++++++++++++++++++++++++++-=
--------
>  include/linux/can/dev.h          |   7 +-
>  include/uapi/linux/can/netlink.h |   3 +
>  3 files changed, 133 insertions(+), 37 deletions(-)

Stephane, I'll add your Acked-by that you have given for the v8 of this
series.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--uuPo7GdB8CpaqWBtIstM1Ugi1nlJXKOfa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlMVm1EACgkQjTAFq1RaXHNBhACfbY822HJpHaeM7HLLaT+4NFlN
YykAnj/seKGJUedRBSNmiri5R5DFQCtb
=bNhY
-----END PGP SIGNATURE-----

--uuPo7GdB8CpaqWBtIstM1Ugi1nlJXKOfa--
