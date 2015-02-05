From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: can: kvaser_usb: Consolidate and unify state change handling
Date: Thu, 05 Feb 2015 09:17:53 +0100
Message-ID: <54D32731.2070106@pengutronix.de>
References: <20150205081239.GA30683@mwanda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="ibc65A8CdCNkhPd960JvQLVMK9TGV2phR"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51110 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755761AbbBEISE (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 5 Feb 2015 03:18:04 -0500
In-Reply-To: <20150205081239.GA30683@mwanda>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>, ahmed.darwish@valeo.com
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ibc65A8CdCNkhPd960JvQLVMK9TGV2phR
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hey Dan,

On 02/05/2015 09:12 AM, Dan Carpenter wrote:
> The patch 96d7f10634e6: "can: kvaser_usb: Consolidate and unify state
> change handling" from Jan 26, 2015, leads to the following Smatch
> warning:
>=20
> 	drivers/net/can/usb/kvaser_usb.c:827 kvaser_usb_rx_error_update_can_st=
ate()
> 	warn: impossible condition '(es->txerr >=3D 256) =3D> (0-255 >=3D 256)=
'

A patch that implicitly fixes this warning, along with other
things, is in my latest pull request to David Miller.

    can: kvaser_usb: Ignore spurious error events after a busoff
    http://article.gmane.org/gmane.linux.can/7587
    http://www.spinics.net/lists/netdev/msg315062.html

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--ibc65A8CdCNkhPd960JvQLVMK9TGV2phR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJU0yc1AAoJECte4hHFiupUknwQAIuFgiP122lFMoH3qFC1lVjT
Gm1C6HfercJEnQMWqfKMobjmPnt+DMZDKTwE1fKjEZpizylR2WR/1mWZwQDxvY/m
tSWTHKjdbABLL15T0zWRY+EB5oUeU3L4XmG7i+DxnzcShXOQ67reFCV3DOvv0mdf
E+Qvi++L9mf9v+C2C1ziDk2VpGoznOf3qSNd5E3qGPBzUfeAwNch7GIFDrOr9dDt
2CxJ04xay/gbsQ8HBps/76pEkAkS5s8gvoCE9EgPSfS2sBQppm867u9QlB6EH2vY
xycd6MHNBZ015fwnAZGQvtx66FupIhK6vj+QoiYCp/2zsNQi3NnrxuS2TgRQ5sZv
aFxwBFuyQ5Spbcq5PrKaLE5EhIGHTnUqSsQ8rsozI4a2Kmjf9K/LO1AzKGgWLPnD
HcBucH8Lwspo1NgxBqm69OAYxV8MawBowsb0GCGHBXjC0qyrnuXf6Fpnlp/gLQAb
kDHMWz63NxCtfmuv0t+nOa4rdOj5c31MAAvpdFBGBWeYx8n1MES22KTxvPkQRWiF
0G36MOHmKSe2vJGPeDloymHmH5pYg18yyslcUOc1FLGfkKcr/z8Exa1dErTeWoOO
o0AreeKH/arYyG5obB2MRYWVpaMYqg4CVvwh3Xmu/ASM7GuACyI75erpKKcC24Fr
Qtf9fZExgBTlgSsKvkXi
=0al+
-----END PGP SIGNATURE-----

--ibc65A8CdCNkhPd960JvQLVMK9TGV2phR--
