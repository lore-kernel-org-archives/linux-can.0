From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: CAN libpcap capture endianess
Date: Wed, 11 Sep 2013 20:38:15 +0200
Message-ID: <5230B897.7020807@pengutronix.de>
References: <1378920814-sup-4559@pruts.nl> <5230B4C9.4070904@pengutronix.de> <1378923967-sup-6565@pruts.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="rhlwHAwsT0IIDCHKUA2l3Us6j0pS2Svc4"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40756 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753850Ab3IKSiW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Sep 2013 14:38:22 -0400
In-Reply-To: <1378923967-sup-6565@pruts.nl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ico Doornekamp <can@zevv.nl>
Cc: linux-can <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rhlwHAwsT0IIDCHKUA2l3Us6j0pS2Svc4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/11/2013 08:30 PM, Ico Doornekamp wrote:
> Since CAN does not have a way to distinguish between sub-protocols, wir=
eshark
> has no way to detect the payload as CANopen.  To force wireshark to use=
 the
> CANopen dissector, you can change the next level protocol in the prefer=
ences
> window, as described here:

Correct.

> https://libbits.wordpress.com/2012/05/07/capturing-and-analyzing-can-fr=
ames-with-wireshark/

I see, thanks.

>> But you're using a 64 bit system while Yegor uses a 32 bit one
>> (according to your notes below).
>=20
> Indeed, but I believe that should in no way interfere with captured dat=
a
> endianess.
>=20
>> Your dump doesn't look correct in my wireshark, it has alternating
>> extended and standard frames and the standard frames have identifiers
>> of 0x060000 which is not valid.
>>
>> Does the command line tool candump show proper frames?
>=20
> I'll have to look into that tomorrow, at this time I only have access t=
o
> the capture file I made earlier.

What kind of CAN hardware are you using? Maybe it's not compatible with
the existing driver.

> For the record: my capture was made with the following commands:
>=20
> slcan_attach /dev/ttyUSB0 -o -s 5
> slcand ttyUSB0
> ifconfig slcan0 up
> wireshark -i slcan0 -w capture.pcap

I've never used a slcan device, but looks good, there aren't that many
options.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--rhlwHAwsT0IIDCHKUA2l3Us6j0pS2Svc4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlIwuJcACgkQjTAFq1RaXHN9ngCfTcVF18N0BTpMkbo2a8vrHNb5
WlMAn3UegMDFsljj/8d7wrrT9DzOaJSv
=EK3o
-----END PGP SIGNATURE-----

--rhlwHAwsT0IIDCHKUA2l3Us6j0pS2Svc4--
