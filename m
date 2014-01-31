From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Can't start ESD CAN-USB/2
Date: Fri, 31 Jan 2014 18:27:57 +0100
Message-ID: <52EBDD1D.4060503@pengutronix.de>
References: <52EBCACD.9080906@iit.it> <52EBCBFA.2090205@pengutronix.de> <52EBD794.3020503@iit.it> <52EBDCD2.6000301@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="0VfU2ihFivafuSdCSrVn7Ng6ip5r0wbxr"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43539 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932236AbaAaR17 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 31 Jan 2014 12:27:59 -0500
In-Reply-To: <52EBDCD2.6000301@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Francesco Giovannini <francesco.giovannini@iit.it>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0VfU2ihFivafuSdCSrVn7Ng6ip5r0wbxr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/31/2014 06:26 PM, Marc Kleine-Budde wrote:
> On 01/31/2014 06:04 PM, Francesco Giovannini wrote:
>> I tried #canconfig can0 bitrate 1000000
>>
>>    can0 bitrate: 1000000, sample-point: 0.750
>>
>> I am however still unable to successfully start the can0 interface wit=
h
>> # ifconfig can0 up. Same error shows up.
>=20
> What's the outout of "canconfig can0" after "canconfig can0 bitrate 100=
0000"

Please try as root and send me the output:

    dmesg -c > /dev/null
    canconfig can0 bitrate 1000000
    canconfig can0
    dmesg

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--0VfU2ihFivafuSdCSrVn7Ng6ip5r0wbxr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlLr3R0ACgkQjTAFq1RaXHPiNACfVSAv/k18uwsGQmUNCFN/VMJV
FJQAniZBqUfeWOyNSGCDRXATbcv3aEx8
=RtbG
-----END PGP SIGNATURE-----

--0VfU2ihFivafuSdCSrVn7Ng6ip5r0wbxr--
