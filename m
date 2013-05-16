From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] drivers: net: can: grcan: use devm_ioremap_resource()
Date: Thu, 16 May 2013 13:50:00 +0200
Message-ID: <5194C7E8.4060804@pengutronix.de>
References: <1368458871-7402-1-git-send-email-laurent.navet@gmail.com> <51935176.7020601@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2NJUWBQCCIVDADDCFLDWQ"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60022 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123Ab3EPLuD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 16 May 2013 07:50:03 -0400
In-Reply-To: <51935176.7020601@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Laurent Navet <laurent.navet@gmail.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2NJUWBQCCIVDADDCFLDWQ
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 05/15/2013 11:12 AM, Marc Kleine-Budde wrote:
> On 05/13/2013 05:27 PM, Laurent Navet wrote:
>> Replace a call to deprecated devm_request_and_ioremap by devm_ioremap_=
resource.
>> dev_err() message is no more needed since it's already displayed in
>> devm_ioremap_resource().
>>
>> Signed-off-by: Laurent Navet <laurent.navet@gmail.com>
>=20
> Tnx, applied to linux-can-next.

The "IS_ERR(base)" ...

> +	base =3D devm_ioremap_resource(&ofdev->dev, res);
> +	if (IS_ERR(base)) {
> +		err =3D PTR_ERR(base);
>  		goto exit_error;
>  	}

=2E.. introduces this sparse warning:

> drivers/net/can/grcan.c:1687:20: warning: incorrect type in argument 1 =
(different address spaces)
> drivers/net/can/grcan.c:1687:20:    expected void const *ptr
> drivers/net/can/grcan.c:1687:20:    got void [noderef] <asn:2>*[assigne=
d] base
> drivers/net/can/grcan.c:1688:31: warning: incorrect type in argument 1 =
(different address spaces)
> drivers/net/can/grcan.c:1688:31:    expected void const *ptr
> drivers/net/can/grcan.c:1688:31:    got void [noderef] <asn:2>*[assigne=
d] base

I think it's the __iomem annotation of the void pointer that
devm_ioremap_resource() returns. Is there a clever way to improve IS_ERR
and PTR_ERR?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2NJUWBQCCIVDADDCFLDWQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlGUx+gACgkQjTAFq1RaXHN3pwCfeMypx0rU/Ky2c8F+qDL5Ts0x
OVsAoI9r/nHQ70eAka2/9HK8rLT3Zi1z
=ivLw
-----END PGP SIGNATURE-----

------enig2NJUWBQCCIVDADDCFLDWQ--
