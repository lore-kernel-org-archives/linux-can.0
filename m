From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] c_can: Add support for eg20t (pch_can)
Date: Thu, 03 Apr 2014 16:59:24 +0200
Message-ID: <533D774C.4050703@pengutronix.de>
References: <1396534451-9654-1-git-send-email-alexander.stein@systec-electronic.com> <17044566.IbTu3WUyuf@ws-stein>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="xtv6CB4AcQf9nFEcBVeLsMnXnls8eclAu"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45860 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255AbaDCO7b (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 Apr 2014 10:59:31 -0400
In-Reply-To: <17044566.IbTu3WUyuf@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>, Wolfgang Grandegger <wg@grandegger.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xtv6CB4AcQf9nFEcBVeLsMnXnls8eclAu
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Adding tglx to Cc

On 04/03/2014 04:55 PM, Alexander Stein wrote:
> Just for the records in this thread:
>=20
> based on tag 'linux-can-fixes-for-3.15-20140401' on repository git://gi=
torious.org/linux-can/linux-can I have noticed message losts(only one mes=
sage each time). Interestingly 'candump any,0~0,#FFFFFFFF' didn't show yn=
 error frames.
> From 500000 CAN frames I lost 72 frames.
>=20
> On Thursday 03 April 2014 16:14:11, Alexander Stein wrote:
>> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>=

>> ---
>>  drivers/net/can/c_can/c_can_pci.c | 50 ++++++++++++++++++++++++++++++=
++++++++-
>>  1 file changed, 49 insertions(+), 1 deletion(-)
>=20
> Best regards,
> Alexander
>=20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--xtv6CB4AcQf9nFEcBVeLsMnXnls8eclAu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlM9d0wACgkQjTAFq1RaXHP+CQCfSSN9S3ADdzMj50bMA8s5meGL
vIUAoILf8adhruNeG27Md7fgPv1DeeRj
=1bXm
-----END PGP SIGNATURE-----

--xtv6CB4AcQf9nFEcBVeLsMnXnls8eclAu--
