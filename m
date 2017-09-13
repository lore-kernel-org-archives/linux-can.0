From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 5/6] can: flexcan: fix i.MX28 state transition issue
Date: Wed, 13 Sep 2017 14:50:18 +0200
Message-ID: <cad7ad55-6c91-3b64-3479-9221d1b31346@pengutronix.de>
References: <b1bfae3d42ca46ecaa83fe8a943da591@SGPMBX1017.APAC.bosch.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="dUCuW2vSJM1NIM3RwDQuhKm1w1rKdSSgn"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:40807 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751173AbdIMMu1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 13 Sep 2017 08:50:27 -0400
In-Reply-To: <b1bfae3d42ca46ecaa83fe8a943da591@SGPMBX1017.APAC.bosch.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>, Wolfgang Grandegger <wg@grandegger.com>, Andri Yngvason <andri.yngvason@marel.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "hs@denx.de" <hs@denx.de>, "RUAN Tingquan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>, "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dUCuW2vSJM1NIM3RwDQuhKm1w1rKdSSgn
Content-Type: multipart/mixed; boundary="PdoKTP6suKfpqmmUFaxr1ISBC1U7jEjgQ";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>,
 Wolfgang Grandegger <wg@grandegger.com>,
 Andri Yngvason <andri.yngvason@marel.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "hs@denx.de" <hs@denx.de>,
 "RUAN Tingquan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>,
 "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
Message-ID: <cad7ad55-6c91-3b64-3479-9221d1b31346@pengutronix.de>
Subject: Re: [PATCH 5/6] can: flexcan: fix i.MX28 state transition issue
References: <b1bfae3d42ca46ecaa83fe8a943da591@SGPMBX1017.APAC.bosch.com>
In-Reply-To: <b1bfae3d42ca46ecaa83fe8a943da591@SGPMBX1017.APAC.bosch.com>

--PdoKTP6suKfpqmmUFaxr1ISBC1U7jEjgQ
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 09/13/2017 11:39 AM, ZHU Yi (ST-FIR/ENG1-Zhu) wrote:
> From 19a2e96683debb514b266d1435327ab4edd8f882 Mon Sep 17 00:00:00 2001
> From: Wolfgang Grandegger <wg@grandegger.com>
> Date: Mon, 11 Sep 2017 08:59:53 +0200
> Subject: [PATCH 5/6] can: flexcan: fix i.MX28 state transition issue
>=20
> Enable FLEXCAN_QUIRK_BROKEN_PERR_STATE for i.MX28 to report correct
> state transitions, especially to error passive.
>=20
> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>

Please add your S-o-b when sending patches from other people. Is it ok o
add your's while applying the patch?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--PdoKTP6suKfpqmmUFaxr1ISBC1U7jEjgQ--

--dUCuW2vSJM1NIM3RwDQuhKm1w1rKdSSgn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlm5KYoACgkQHv7KIOw4
HPbGpQgAhviELjvjaNFN+2FOLx3CBpALqxbsmRpzmnToOOVJ2B2hQYCzQZVDSRk6
O3oQ9OLThrp171f9sQYEYMv6Q03BjgiZXo7/J6x9yRpptqUKPkZSv46UmWjU7hsY
Meiyc8QVZ68Tw0MdtOEfsCmd/k/4TWTSUdNfHQ4GLhMebdoffNw9WH/TaJBHKXM2
nlMuClBCnSrvgBVuXiBpVvSrpKQqKf40GutEf1taOMSiXRrhglpZsibGTIRJ4mn0
/LqGpwpA8QtDtZSRyJy/Mi+ThEtEpB8MYzKp8/AZMkhgjvDGgMq4h4yWzv4WVN/r
EAWMfjw5SmlLsG7X8Hr+VYWQcpgSqQ==
=IkIf
-----END PGP SIGNATURE-----

--dUCuW2vSJM1NIM3RwDQuhKm1w1rKdSSgn--
