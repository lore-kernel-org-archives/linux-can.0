From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RFC] [PATCH v3] can: fix handling of unmodifiable configuration
 options
Date: Tue, 15 Mar 2016 10:22:38 +0100
Message-ID: <56E7D45E.8040404@pengutronix.de>
References: <1457982490-27520-1-git-send-email-socketcan@hartkopp.net>
 <SG2PR06MB10380F64CC37C3F7B4D46017C3890@SG2PR06MB1038.apcprd06.prod.outlook.com>
 <56E7C502.4080109@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="h3JRCLbBHXRJgUcRV0hREuvTdFFlK79L3"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:41402 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934342AbcCOJWw (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 15 Mar 2016 05:22:52 -0400
In-Reply-To: <56E7C502.4080109@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Stephane Grosjean <s.grosjean@peak-system.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--h3JRCLbBHXRJgUcRV0hREuvTdFFlK79L3
Content-Type: multipart/mixed; boundary="tiNxMGM2mtjTJBkjkF8LlsvXbX3dCD0rC"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
 Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 Stephane Grosjean <s.grosjean@peak-system.com>
Message-ID: <56E7D45E.8040404@pengutronix.de>
Subject: Re: [RFC] [PATCH v3] can: fix handling of unmodifiable configuration
 options
References: <1457982490-27520-1-git-send-email-socketcan@hartkopp.net>
 <SG2PR06MB10380F64CC37C3F7B4D46017C3890@SG2PR06MB1038.apcprd06.prod.outlook.com>
 <56E7C502.4080109@hartkopp.net>
In-Reply-To: <56E7C502.4080109@hartkopp.net>

--tiNxMGM2mtjTJBkjkF8LlsvXbX3dCD0rC
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/15/2016 09:17 AM, Oliver Hartkopp wrote:
> Hello Marc,
>=20
> On 03/15/2016 08:15 AM, Ramesh Shanmugasundaram wrote:
>>> Oliver Hartkopp <socketcan@hartkopp.net>
>>> Subject: [RFC] [PATCH v3] can: fix handling of unmodifiable configura=
tion
>>> options
>=20
> (..)
>=20
>>> Reported-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.rene=
sas.com>
>>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>>
>> Reviewed-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renes=
as.com>
>> Tested-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas=
=2Ecom>
>>
>=20
> I would suggest to queue this patch for stable 3.18+ where I applies=20
> without problems.

Ok, I've added:

Cc: <stable@vger.kernel.org> # >=3D 3.18

> Ubuntu maintains a 3.16 longterm kernel - but I do not see a real=20
> benefit for that kernel as it would only affect the M_CAN driver there.=
=20
> I doubt any M_CAN hardware is used together with this specific Ubuntu=20
> kernel as we already would have get any feedback then.
>=20
> Once this patch emerged in Linux 4.0 I'll send a patch for the PCAN USB=
=20
> FD adapters which are potential can_set_static_ctrlmode() users too.

No need to wait, you can send the patches now. They'll go via can-next
anyway.

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--tiNxMGM2mtjTJBkjkF8LlsvXbX3dCD0rC--

--h3JRCLbBHXRJgUcRV0hREuvTdFFlK79L3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJW59ReAAoJED07qiWsqSVq6VsH/3Fle8drQ+UlrAcn+XaLWEAN
kDcWwP2YTPare6DN2BjuOwv82ZklAy8BGagVmbA6vA7H7UpYOeH3bfIbm7+izAnI
tn4gN++4XuaXtCtrG7CI7WmnCBre2TITGHV1PSVv9n6xOLwgdoNxA1UEny90LPF2
BUUTHJeuEGBDUngmWjyUXTb98jk84I5+gzabSWGJIiJ1g2Hgv/UChoarxlrgVugr
OofNlw6vawlVp80f9srUPoFxANY7KYZKdIYEONcq6eQhWODTDNg03RJMsTs1YWH2
5Kh0xqCJbUi7QtEPU3SKxZ6/isG/+At/qglHBZWocqLaD8B0vlO6Ikrit36ioQs=
=caTu
-----END PGP SIGNATURE-----

--h3JRCLbBHXRJgUcRV0hREuvTdFFlK79L3--
