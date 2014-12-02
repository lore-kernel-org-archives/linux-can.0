From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can/peak_usb: fix memset() usage
Date: Tue, 02 Dec 2014 13:35:53 +0100
Message-ID: <547DB229.9080107@pengutronix.de>
References: <1417180128-28509-1-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Bire8GHuhXXIAH1Ub3lbxpk5hXfH3QFNb"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48170 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932588AbaLBMf4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 2 Dec 2014 07:35:56 -0500
In-Reply-To: <1417180128-28509-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Bire8GHuhXXIAH1Ub3lbxpk5hXfH3QFNb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/28/2014 02:08 PM, Stephane Grosjean wrote:
> This patchs fixes a misplaced call to memset() that fills the request
> buffer with 0. The problem was with sending PCAN_USBPRO_REQ_FCT
> requests, the content set by the caller was thus lost.
>=20
> With this patch, the memory area is zeroed only when requesting info
> from the device.
>=20
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>

Applied to can/master.

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Bire8GHuhXXIAH1Ub3lbxpk5hXfH3QFNb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUfbIpAAoJECte4hHFiupUSEkQAKRzNizyu5wlDHPGplz5+qLU
Aj5OvLuAFNmj+KrjHMWiCvcSwEKbbe8yzJNaF1ZAJGwsjlX4Hoqgw/uc7GN/X28Q
zqpOh5/R6NTyPGOuSwJl4060x3Y/ct0YqUVlAQQLZNjfWLy3vEWvA5zUvrFwvvjX
sJsOjuMuQjFXrElK2P639oI6cdImmv2wso3Q2fyC4Ur6h5/HLvNTx+4gdehzewuj
E0U50DO2i2Vwak3/Hx5+QTxbl0LcPcKn+Uft2rYoAgo3MZJnSnIEx2Hq4/ySjN9H
a3DquJK0tVk0o0V7/vKFKr+z/UXTQaYXTapBa2slQPBXp2PQK7qnI5E1oy/x80K3
9SI/xC53Sxj/Do7InFRetHey3OLwtVhJRVBVPfC/aGbMKIyxy71kgZc8QUKgvkXP
sbMVk+I8CdzePf1n2oQQa60L3INplGN6qd9o6t4ONRx3Duw3tXJGEQURu4/BscbH
sT38tpuV2ARkxF8d/S7UQz/68PWpBBwlc81xCzTforqHELY7aFwBhz7xpRbGWJ6U
oiduuG2FE3GLQe7+5cHOE/FV1Tc2pvBDAE+jjVo6kgRi2mdCCFsiom7g7puQnLRw
MPOCf5RGkj17+TXRxMtB3MQFNgso8DNSwy+8PxxfIWlIBPBOBrB6F8ShF78zL1fx
YLc4HVf/4nTK3QKBiibS
=24x+
-----END PGP SIGNATURE-----

--Bire8GHuhXXIAH1Ub3lbxpk5hXfH3QFNb--
