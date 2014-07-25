From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: C_CAN: can frame drops
Date: Fri, 25 Jul 2014 10:27:14 +0200
Message-ID: <53D214E2.7020205@pengutronix.de>
References: <BAY176-W240BDB3FFF425370BF5B47D3FE0@phx.gbl>,<53D204A4.1060502@pengutronix.de> <BAY176-W4D41B1290DE5D3B2BD6D0D3FC0@phx.gbl>,<53D2126C.40600@pengutronix.de> <BAY176-W426E5C1C47CA0379DFCD84D3FC0@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="tfPjSa30NVScTLecqnQFn1VHwh8WPNuAH"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43695 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818AbaGYI10 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 25 Jul 2014 04:27:26 -0400
In-Reply-To: <BAY176-W426E5C1C47CA0379DFCD84D3FC0@phx.gbl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ssagarr Patil <hugarsagar@outlook.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tfPjSa30NVScTLecqnQFn1VHwh8WPNuAH
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/25/2014 10:22 AM, Ssagarr Patil wrote:
> Hi Marc,
>=20
>>
>> On 07/25/2014 10:13 AM, Ssagarr Patil wrote:
>>>>> I am using the c_can driver for latest kernel and using the latest =
canutils to dump to a file.
>>>>> My can bus is set at a rate of 1Mb (receiving 7000fps bus load of 8=
0%).
>>>>>
>>>>> When I use the candump tool to dump can frames I get following mess=
age,
>>>>>
>>>>> 'DROPCOUNT: dropped 2223 CAN frames on 'any' socket (total drops 16=
29092)'
>>>>
>>>> These are the CAN frames dropped by the socket, this means as Oliver=

>>>> pointed out, that the candump fails to read the CAN frames fast enou=
gh
>>>> from the socket. How do you connect to the linux box with the c_can?=

>>>> Where are the CAN frames printed to?
>>>>
>>> Agreed this is dropped by the socket, so for this to solve I increase=
d the socket size
>>> (with -r option of candump to 111173056) after doing this I see that =
there is frame drop in
>>> the driver ie I see this function c_can_handle_lost_msg_obj() being c=
alled frequently in which
>>> can frame is overwritten.
>>>
>>> I have a can frame generator which I have connected to the EVM, the E=
VM is recieving the
>>> frames and just dumping it on stdout going ahead I need to log the ca=
nframes to SD card.
>>
>> ...and where is your stdout going? serial line, telnet, ssh?
>>
> Its the serial line.

That's not good. As printing to the serial console is quite costly.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--tfPjSa30NVScTLecqnQFn1VHwh8WPNuAH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlPSFOIACgkQjTAFq1RaXHM7/ACdGFVZJxjRFtDQEYFFbHgiwO34
R9UAn1dBq9IaFJo5dMgu/8nKWRzMWLe6
=0HaT
-----END PGP SIGNATURE-----

--tfPjSa30NVScTLecqnQFn1VHwh8WPNuAH--
