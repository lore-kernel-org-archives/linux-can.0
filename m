From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH V5 1/1] can: Add support for esd CAN PCIe/402 card
Date: Mon, 16 Mar 2015 14:35:03 +0100
Message-ID: <5506DC07.90700@pengutronix.de>
References: <1426508113-14904-1-git-send-email-thomas.koerper@esd.eu> <20150316124621.14895.31220@shannon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="2Wni6RaSr3XT5kO0mHlmrTpXa1h6DrK8B"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48362 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbbCPNfQ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 16 Mar 2015 09:35:16 -0400
In-Reply-To: <20150316124621.14895.31220@shannon>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>, linux-can@vger.kernel.org
Cc: =?UTF-8?Q?Thomas_K=c3=b6rper?= <thomas.koerper@esd.eu>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2Wni6RaSr3XT5kO0mHlmrTpXa1h6DrK8B
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/16/2015 01:46 PM, Andri Yngvason wrote:
> can_change_state() is now used in mscan, flexcan, sja1000, kvaser and p=
eak.
> Those drivers should provide sufficent examples for you to learn how to=
 use the
> function.

Thanks for keeping an eye on the CAN error handling, Andri.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--2Wni6RaSr3XT5kO0mHlmrTpXa1h6DrK8B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJVBtwRAAoJECte4hHFiupU110P/1Vshy6R57IVs4zexFTKdQO1
ljnPahT8UElhtNri0XgBiwHp5B9DzjWi2Cv+Pf023srl0/J/3WhqHWHd7Wz9sTQE
RHXQpbQvVfQW6/nn4i0wQyhOJ+GTsiOJygugw6l7trjBFmq6vdo1V1s5wwlj8ZGm
tiVWBjga9kkhtd5Euw9g7QlLm2Fgvgmsu9yLPy87TSDKzUwXwS9n52Lx2zhaqqoa
w9+FACp1/9E6dsme8hjHOdJ6E0DV+JmHk7/tnJub6iTvMGCUiacbLy7ELx5xyuN9
AmptjaBWOVBBXor8OpP+cSPUTdUPJeWxbdaAcXWHQXDSovq9raT+aUMrAjMvCsm7
wl1kioLZwwOI1sxcQCImiMesA/ZcJixmLUjLIrf5OejCQNZOx/ZhrGoWl4DgR+fT
KAFoxFP+ob1TnAcCiSzjzfXeEe93pcdAk01icbltnT9+63eiGpfmpkiI3OAPofcI
jeWMNEZKY0QzOuAUY3WOgpWgpQeCJ5/oSZFzpHm4RgsdTjRBTbGIMbvU/sEk0jJW
Hbw6/+ipNnVRkpICiDMXlO+NdtU0Vj+PPhRcAek04mFNoXjEXY20E67iw8nBP1Yg
iI1m5JPNqsuTc/i6gKkxTnsRAY4NjzTjpOk+EQmyeCpRqhdAZ11zt0mKxZGr5fWj
x02JTbcqLEXJsqqEq7rr
=HOeE
-----END PGP SIGNATURE-----

--2Wni6RaSr3XT5kO0mHlmrTpXa1h6DrK8B--
