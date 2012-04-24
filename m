From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/3] can: c_can: fix "BUG! echo_skb is occupied!" during
 transmit
Date: Tue, 24 Apr 2012 13:28:07 +0200
Message-ID: <4F968E47.7020109@pengutronix.de>
References: <1334915862-29810-1-git-send-email-anilkumar@ti.com> <4F965C6D.6030303@pengutronix.de> <331ABD5ECB02734CA317220B2BBEABC13E997D11@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA64E4A63883785B51E692543"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52658 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752310Ab2DXL2T (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 24 Apr 2012 07:28:19 -0400
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13E997D11@DBDE01.ent.ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "Gole, Anant" <anantgole@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA64E4A63883785B51E692543
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 04/24/2012 01:24 PM, AnilKumar, Chimata wrote:
> On Tue, Apr 24, 2012 at 13:25:25, Marc Kleine-Budde wrote:
>> On 04/20/2012 11:57 AM, AnilKumar Ch wrote:
>>> This patch fixes an issue with transmit routine, which causes
>>> "can_put_echo_skb: BUG! echo_skb is occupied!" messgae when
>>> using "cansequence -p" on D_CAN controller.
>>>
>>> In c_can driver, while transmitting packets tx_echo flag holds
>>> the no of can frames put for transmission into the hardware.
>>>
>>> As the comment above c_can_do_tx() indicates, if we find any packet
>>> which is not transmitted then we should stop looking for more.
>>> In the current implementation this is not taken care of causing the
>>> said message.
>>>
>>> Also, fix the condition used to find if the packet is transmitted
>>> or not. Current code skips the first tx message object and ends up
>>> checking one extra invalid object.
>>
>> The two above listed issues can occur with the c_can hardware, too?
>> Please split into two separate patches. These should go to the stable
>> kernel, too. Can someone with a c_can hardware test these patches.
>=20
> I will split into two patches. I had clubbed both the changes in a sing=
le
> patch because both the changes are required to get rid of the error men=
tioned
> in the subject line.

okay - then it's better to keep them together.

> I will add the stable tag when submitting next, but since I do not have=
 c_can
> hardware, someone needs to confirm this actually solves a c_can issue. =
I have
> read through the c_can specification and see that this would indeed be =
a problem
> on c_can.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigA64E4A63883785B51E692543
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+WjkwACgkQjTAFq1RaXHOzYACePeWu8btlKDk/lsszcwBJlDLM
W38AmwVTXwYNWyjg29x3j6ZR6QLyzwg4
=MG3B
-----END PGP SIGNATURE-----

--------------enigA64E4A63883785B51E692543--
