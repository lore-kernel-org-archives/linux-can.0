From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [Socketcan-users] AM335x CAN/D_CAN
Date: Wed, 23 May 2012 10:08:18 +0200
Message-ID: <4FBC9AF2.2030508@pengutronix.de>
References: <CAHvj1qbb9YJSBLZc1bG6MpEJcjPUtr+37wn3iJUNm_OmpH2SgA@mail.gmail.com> <4FBBE272.5020807@grandegger.com> <331ABD5ECB02734CA317220B2BBEABC13E9C2E10@DBDE01.ent.ti.com> <4FBC8B5D.7000302@grandegger.com> <4FBC8C25.3050107@pengutronix.de> <20120523080713.GG30137@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA595C30C560FDE544444A4DE"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57773 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756230Ab2EWIIW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 23 May 2012 04:08:22 -0400
In-Reply-To: <20120523080713.GG30137@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Robert Schwebel <r.schwebel@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, "AnilKumar, Chimata" <anilkumar@ti.com>, bruce bushby <bruce.bushby@gmail.com>, Linux-CAN <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA595C30C560FDE544444A4DE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 05/23/2012 10:07 AM, Robert Schwebel wrote:
> Hi Marc,
>=20
> On Wed, May 23, 2012 at 09:05:09AM +0200, Marc Kleine-Budde wrote:
>>> Yes, I think we should push it forward, even if the C_CAN part
>>> remains untested for the moment. IIRC, the patch series is already
>>> in a good shape. I personally do also not have a board with a C_CAN
>>> controller at hand. Marc, what is your opinion?
>>
>> I don't have any of the *_CAN hardware. But the driver looks quite
>> good.  I'm quite busy at the moment, but currently we've the merge
>> window. I'll do a review now, anyway. Wolfgang can I have your
>> Acked-by?
>=20
> We have a BeagleBone in the PTX Lab, with an AM3359, which has the CAN
> port on the extension header. Does that help?

Sure \o/, if our soldermaster can attach it to our CAN network.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigA595C30C560FDE544444A4DE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+8mvIACgkQjTAFq1RaXHNcYQCcDw4HqeyoRkg2Z59JUxn2208A
Ho0AoIIk2SSNE8is4huk2kHiADnHdTyw
=Pumc
-----END PGP SIGNATURE-----

--------------enigA595C30C560FDE544444A4DE--
