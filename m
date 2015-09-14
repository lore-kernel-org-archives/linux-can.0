From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [linux-sunxi] [PATCH v5 2/2] can: Allwinner A10/A20 CAN
 Controller support - controller code
Date: Mon, 14 Sep 2015 14:45:33 +0200
Message-ID: <55F6C16D.5040707@pengutronix.de>
References: <1442144632-4541-1-git-send-email-info@gerhard-bertelsmann.de>
 <1442144632-4541-3-git-send-email-info@gerhard-bertelsmann.de>
 <20150913124501.GS9885@lukather>
 <f8eea0f544eb6367142bbc1c2ab35964@mail.rdts.de>
 <20150914081703.GB9885@lukather>
 <cc433d14a0a6e9e8c8ccebaa372e1893@mail.rdts.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="WjieH90mug8ehATrx1siM2RGGDIRtSXoc"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39711 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640AbbINMpl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 14 Sep 2015 08:45:41 -0400
In-Reply-To: <cc433d14a0a6e9e8c8ccebaa372e1893@mail.rdts.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux-can@vger.kernel.org, linux-sunxi@googlegroups.com, linux-can-owner@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WjieH90mug8ehATrx1siM2RGGDIRtSXoc
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/14/2015 02:41 PM, Gerhard Bertelsmann wrote:
>> All these people are supposed to be reviewing your driver, and while
>> Marc will have a look at how your driver interact with the CAN
>> framework, I'll have a look at how your driver interact with the rest
>> of the code we did for the Allwinner SoCs. We look at different
>> aspects, we have different kind of comments.
>>
>> Maxime
>=20
> I think I got it.
>=20
> IMHO Marc did a very good job reviewing the code so far. If the=20
> SocketCAN
> is happy with the code I will send the patch to the maintainer if Marc =

> agree.

I think for the following patch iterations you can send to all parties
that show up in the get_maintainer.pl's output.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--WjieH90mug8ehATrx1siM2RGGDIRtSXoc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJV9sFtAAoJEP5prqPJtc/H14gIAL6SMrg3l7Iz2OZqdgAS5Zdd
Uey1A1TrChHG2U62m97h4gHUvWRZxIC65q+x6GzY29wWt6fM5tcoxe1tl/PNjf8D
6osikF+vg+AWOJwesOJSCvDxgy8qRMauGytTvSdNjj54BiQ9gkubpdMcDWhdVNqF
UjKtfGspIaizRnVyfY4vIpePJ4PJ3HzyjByvj/UgMQxONdSu1AbP03ZA8XRsODbA
FYxN3/CjFTxd2iqUGYVB4rnsspBBh7z8oLd33AvYG0DKUWcZkjXJYA9qL0brlh7A
yYNwQ/bGTTnlS/WxgGb0MVs+XdbMfGNgYnWY123XMR6cmoD11C0OrEnQGD1SqqU=
=9cGK
-----END PGP SIGNATURE-----

--WjieH90mug8ehATrx1siM2RGGDIRtSXoc--
