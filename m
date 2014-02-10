From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: trouble bringing up can0 interface on intel eg20t chipset
Date: Mon, 10 Feb 2014 19:30:44 +0100
Message-ID: <52F91AD4.8040300@pengutronix.de>
References: <52F903EB.8030107@symboticware.com> <52F904E6.2060605@pengutronix.de> <52F914FF.20902@symboticware.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="SqBUGq8q058SmC9PQIWwgcUMIGiD2lB42"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37269 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185AbaBJSat (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 10 Feb 2014 13:30:49 -0500
In-Reply-To: <52F914FF.20902@symboticware.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Luc Richer <lricher@symboticware.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SqBUGq8q058SmC9PQIWwgcUMIGiD2lB42
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 02/10/2014 07:05 PM, Luc Richer wrote:
> On 02/10/2014 11:57 AM, Marc Kleine-Budde wrote:
>> On 02/10/2014 05:52 PM, Luc Richer wrote:
>>> I am trying to interface with vehicle engine using Intel EG20T chipse=
t.
>>>
>>> This board does have a pinout for CANbus interface, and I believe I h=
ave
>>> determined the correct module for the interface is pch_can
>>> http://cateee.net/lkddb/web-lkddb/PCH_CAN.html
>>> Someone told me I may need the i2c module for this chipset as well, s=
o I
>>> have loaded it also (i2c_eg20t)
>>>
>>> I have loaded the modules for the can interface (can, can-dev, can-ra=
w,
>>> can-bcm) along with i2c_eg20t and pch_can.
>>>
>>> dmesg | grep can reveals
>>> can: controller area network core (rev 20120528 abi 9)
>>> can: raw protocol (rev 20120528)
>>> can: broadcast manager protocol (rev 20120528 t)
>> Please send the output of:
>>
>>      lspci
>>      ifconfig -a
>>
>> Marc
>>
> I have made some advancement and now have the interface detected but
> can't seem to bring it up.

How do you try do bring it up?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--SqBUGq8q058SmC9PQIWwgcUMIGiD2lB42
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlL5GtQACgkQjTAFq1RaXHPj1wCfQlFOOQm+sGSiOu9+b3ANQDu+
SHwAnAhEt/Dh6Lc4wiPQzLx674WnjqY4
=rG0u
-----END PGP SIGNATURE-----

--SqBUGq8q058SmC9PQIWwgcUMIGiD2lB42--
