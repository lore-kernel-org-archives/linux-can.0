From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v10 3/9] can/peak_usb: export ctrlmode_supported to adapter
 specific
Date: Tue, 27 Jan 2015 22:07:15 +0100
Message-ID: <54C7FE03.1020301@pengutronix.de>
References: <1422392697268557815@MailServerPEAK>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="TTeKcgxrmexm2Lo6x8d6jbPuIwbgWDxM5"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57477 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754526AbbA0VHS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 27 Jan 2015 16:07:18 -0500
In-Reply-To: <1422392697268557815@MailServerPEAK>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?B?U3TDqXBoYW5lIEdyb3NqZWFu?= <s.grosjean@peak-system.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TTeKcgxrmexm2Lo6x8d6jbPuIwbgWDxM5
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/27/2015 10:05 PM, St=C3=A9phane Grosjean wrote:
> Hi Mark,
>=20
> You've got my Ack for this patch (too)(again).
>=20
> St=C3=A9phane.Le 27 janv. 2015 17:41, Marc Kleine-Budde <mkl@pengutroni=
x.de> a =C3=A9crit :
>>
>> From: Stephane Grosjean <s.grosjean@peak-system.com>=20
>>
>> Export the ctrlmode_supported value from the core file to each adapter=
 specific=20
>> file. This has been mandatory for supporting the new CANFD extension. =

>>
>> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>=20
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>=20

This is more or less your original patch, I just split it...it still
lists you as the Author and has your S-o-b.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--TTeKcgxrmexm2Lo6x8d6jbPuIwbgWDxM5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJUx/4DAAoJECte4hHFiupULKQQAJjdjWcYdv7rWJNxMuYKD7Qs
WKumDuH8K0yAsKZcItBBdinZj7oaGPs6qSb6UFSrLr4KCkDy+aHSc1mUiiGqsUH4
VrsKZz9y59rIy1jAFT+h3Rqy/rPt7u2wYnwEhfaJZpXPcFPRKKCTcoHX96RgcUDJ
pjwsnfRk73N/PM1Dq/MKfnvQwPxZ5MDgzNqwBrSaN9ttJzxcayzatIedwSlnUSfM
3LSaIX8rFb1Z7xxjFVF4WQ93jkKX3tBCjhxytQCXg2dNIaEEB/Gk16ozyucPvH8x
58XQ/Yi1r0/x5KbDo+ScyrYMKWNimYLxcNHFSI6+JYPPVGzHCztytuWqX3Ggz48u
shN78EVUUG4KbaYmrKJzJMo6q65m1Nm7ICCbt/XQ17Byc85URBKnTgDptZ67qDaQ
2GwkUy1jbbt5wXnsnrrr0G0LWx6gEQRnSCz5JYN4eukEj1ZEIedaG0eFE+73Gxdp
q2k654fI/QBFPsK3vh4tlzYKxWVkqwXgt7zT1HoG7SXHi/PRlgHpDpfGs5PKKW3D
4o+Va5rVzGez8t2OOV1rydtmuVQ2qNTO2TgyuiJ++LPIMXqsk2sfjL5QKgKJo7n5
3hc+pwXcm2Pu5pWdE10zhQ0c6Iazxaa50fB+rUlJmc94/5sQaLmar7agjd7PGMNM
rqFg+Vtb6oBU2wc1uedl
=XoNC
-----END PGP SIGNATURE-----

--TTeKcgxrmexm2Lo6x8d6jbPuIwbgWDxM5--
