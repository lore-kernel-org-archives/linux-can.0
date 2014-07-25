From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: C_CAN: can frame drops
Date: Fri, 25 Jul 2014 10:16:44 +0200
Message-ID: <53D2126C.40600@pengutronix.de>
References: <BAY176-W240BDB3FFF425370BF5B47D3FE0@phx.gbl>,<53D204A4.1060502@pengutronix.de> <BAY176-W4D41B1290DE5D3B2BD6D0D3FC0@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="beGFk54uune80QOUUI0rKm5wf21srhrw5"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36159 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759807AbaGYIQt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 25 Jul 2014 04:16:49 -0400
In-Reply-To: <BAY176-W4D41B1290DE5D3B2BD6D0D3FC0@phx.gbl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ssagarr Patil <hugarsagar@outlook.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--beGFk54uune80QOUUI0rKm5wf21srhrw5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/25/2014 10:13 AM, Ssagarr Patil wrote:
>>> I am using the c_can driver for latest kernel and using the latest ca=
nutils to dump to a file.
>>> My can bus is set at a rate of 1Mb (receiving 7000fps bus load of 80%=
).
>>>
>>> When I use the candump tool to dump can frames I get following messag=
e,
>>>
>>> 'DROPCOUNT: dropped 2223 CAN frames on 'any' socket (total drops 1629=
092)'
>>
>> These are the CAN frames dropped by the socket, this means as Oliver
>> pointed out, that the candump fails to read the CAN frames fast enough=

>> from the socket. How do you connect to the linux box with the c_can?
>> Where are the CAN frames printed to?
>>
> Agreed this is dropped by the socket, so for this to solve I increased =
the socket size
> (with -r option of candump to 111173056) after doing this I see that th=
ere is frame drop in
> the driver ie I see this function c_can_handle_lost_msg_obj() being cal=
led frequently in which
> can frame is overwritten.
>=20
> I have a can frame generator which I have connected to the EVM, the EVM=
 is recieving the
> frames and just dumping it on stdout going ahead I need to log the canf=
rames to SD card.

=2E..and where is your stdout going? serial line, telnet, ssh?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--beGFk54uune80QOUUI0rKm5wf21srhrw5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlPSEmwACgkQjTAFq1RaXHNt2gCfU70jJ84cSU6h9v8lP02d+6WX
6W4AoI/R/cAbn8RNS8VObzpEo3lR73Da
=5vk3
-----END PGP SIGNATURE-----

--beGFk54uune80QOUUI0rKm5wf21srhrw5--
