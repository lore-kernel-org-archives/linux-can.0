From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: usb_8dev: unregister netdev before free()ing
Date: Tue, 18 Jun 2013 20:34:08 +0200
Message-ID: <51C0A820.3010102@pengutronix.de>
References: <1371560243-24316-1-git-send-email-mkl@pengutronix.de> <51C0A5A2.6010909@universalnet.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2NMWEDNNXTAQEDBBURMDI"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40483 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933020Ab3FRSe2 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 18 Jun 2013 14:34:28 -0400
In-Reply-To: <51C0A5A2.6010909@universalnet.at>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Bernd Krumboeck <krumboeck@universalnet.at>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2NMWEDNNXTAQEDBBURMDI
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 06/18/2013 08:23 PM, Bernd Krumboeck wrote:
> Am 2013-06-18 14:57, schrieb Marc Kleine-Budde:
>> The usb_8dev hardware has problems on some xhci USB hosts. The driver
>> fails to
>> read the firmware revision in the probe function. This leads to the
>> following
>> Oops:
>>
>>      [ 3356.635912] kernel BUG at net/core/dev.c:5701!
>>
>> The driver tries to free the netdev, which has already been
>> registered, without
>> unregistering it.
>>
>> This patch fixes the problem by unregistering the netdev in the error
>> path.
>>
>=20
> Thank you for the patch!
>=20
> I've applied it to my source tree:
> https://github.com/krumboeck/usb2can

Can I have you Acked-by or Reviewed-by?

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2NMWEDNNXTAQEDBBURMDI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlHAqCQACgkQjTAFq1RaXHOEOACghT8FFBNii/uSwmWjJtcBqIZX
S9UAoI9TLse82j902ay+6hj2IaOqJeoN
=V+Ff
-----END PGP SIGNATURE-----

------enig2NMWEDNNXTAQEDBBURMDI--
