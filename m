From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Antwort: Re: [Socketcan-users] socketcan in barebox bootloader
Date: Thu, 09 Feb 2012 10:50:04 +0100
Message-ID: <4F3396CC.1060009@pengutronix.de>
References: <OF32B6D01B.4E8430B8-ONC125799E.0055E20B-C125799E.00563FFD@o0802.rafi.inhouse> <4F3372C3.3040902@grandegger.com> <OF323BE753.A56A00D8-ONC125799F.002F6CA3-C125799F.00302BFA@o0802.rafi.inhouse> <4F3392C5.2080409@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig236C351DA2BE4E5B716AA322"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55862 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757421Ab2BIJuI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 9 Feb 2012 04:50:08 -0500
In-Reply-To: <4F3392C5.2080409@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: christian.buettner@rafi.de, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig236C351DA2BE4E5B716AA322
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/09/2012 10:32 AM, Wolfgang Grandegger wrote:
> On 02/09/2012 09:46 AM, christian.buettner@rafi.de wrote:
>> Hi Wolfgang,
>>
>> i know that CAN is not the best solution for this tasks, but it is a=20
>> requirement of a customer to use the can-bus :(
>>
>> So i create a SocketCAN interface on the host side and implement a Lev=
el 2=20
>> CAN receiver in the bootloader, right?

What's Level 2 CAN receiver?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig236C351DA2BE4E5B716AA322
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8zlswACgkQjTAFq1RaXHNKEQCdEiO3hLBQJt2RKz+k37n6ywuA
ahYAnAhKfVMK2snmKCPCF4IaZ2Lj2+5f
=llwa
-----END PGP SIGNATURE-----

--------------enig236C351DA2BE4E5B716AA322--
