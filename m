From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: usb-can device
Date: Mon, 27 Aug 2012 11:05:41 +0200
Message-ID: <503B3865.4090202@pengutronix.de>
References: <1345996339.6610.10.camel@slaptop> <503A4E9B.9060308@pengutronix.de> <503B1198.3010506@hartkopp.net> <20120827081028.GA417@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9157F82849ADFF5B46C5A965"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42113 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312Ab2H0JFp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 27 Aug 2012 05:05:45 -0400
In-Reply-To: <20120827081028.GA417@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, "Max S." <max@schneidersoft.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9157F82849ADFF5B46C5A965
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/27/2012 10:10 AM, Kurt Van Dijck wrote:
>> *2:
>> To provide a state-of-the-art echo functionality the sk pointer (skb->=
sk) is
>> sent along with the CAN frame. This allows to skb_free() the original =
tx skb
>> and create a new one at rx time with the correct sk pointer, when the =
frame is
>> echoed after successful transmission. As we are endian safe the sk poi=
nter can
>> be taken from the USB URB as-is. (For security reasons we should proba=
bly not
>> take the pointer directly but double check with stored echo-skbs)

> 'sending an skb pointer' is indeed a key to cleaner design,
> but couples both systems more tight: is that pointer 32bit? 64?
>=20
> I even don't know if that is a problem ...

On 64 Bit archs you need 64 bit for a pointer. However I'd like to call
this cookie or handle not pointer to some kernel internal data. And as
Oliver pointed out, don't trust the data that comes from the USB device.

regards, Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig9157F82849ADFF5B46C5A965
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlA7OGUACgkQjTAFq1RaXHPYagCZAfEMMAbaeRDARRBJbCijae5m
+BUAoIBmIJ58g9s0aatk3stEIO+Uxgu6
=kg5K
-----END PGP SIGNATURE-----

--------------enig9157F82849ADFF5B46C5A965--
