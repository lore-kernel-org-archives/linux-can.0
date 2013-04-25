From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Is there any way of getting the CAN interfaces list, from any
 C program?
Date: Thu, 25 Apr 2013 09:07:36 +0200
Message-ID: <5178D638.1010303@pengutronix.de>
References: <5169B395.2070703@hartkopp.net> <516D2ABB.4000300@pengutronix.de> <5177A090.6010904@peak-system.com> <20130424144929.GA2077@vandijck-laurijssen.be> <5178D00C.70507@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2XFKJLCPWRWBVFVVDFNSB"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35074 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758Ab3DYHHl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 25 Apr 2013 03:07:41 -0400
In-Reply-To: <5178D00C.70507@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Stephane Grosjean <s.grosjean@peak-system.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2XFKJLCPWRWBVFVVDFNSB
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 04/25/2013 08:41 AM, Wolfgang Grandegger wrote:
> Hi Kurt,
>=20
> On 04/24/2013 04:49 PM, Kurt Van Dijck wrote:
>> Hi Stephane,
>>
>> I have written this some time ago, not using it actually.
>> I tried a modular approach, don't know if its usefull.
>>
>> PS: I used attachments.
>=20
> ~/enumif$ ./enumif
> 1: lo	{loopback} <LOOPBACK,UP,LOWER_UP> UNKNOWN
> 2: eth0	{ether} <BROADCAST,MULTICAST> DOWN
> 3: eth1	{ether} <BROADCAST,MULTICAST,UP,LOWER_UP> UNKNOWN
> 4: eth3	{ether} <NO-CARRIER,BROADCAST,MULTICAST,UP> DOWN
> 5: can0	{can} <NOARP,UP,LOWER_UP,ECHO> UNKNOWN
> 6: can1	{can} <NOARP,ECHO> DOWN
> 7: can2	{can} <NOARP,ECHO> DOWN
> 8: can3	{can} <NOARP,ECHO> DOWN
> 9: pan0	{ether} <BROADCAST,MULTICAST> DOWN
>=20
> Cool! We know that "ip link" does list all network interfaces but the
> code doing the job is not really strength-forward. I think this would b=
e
> a nice enhancement of the can-utils.

Good idea, Stephane, can you license the code under a permissive license
like LGPL or BSD?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2XFKJLCPWRWBVFVVDFNSB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlF41joACgkQjTAFq1RaXHNX9ACghKVQDOt0J7VbUDu7gX3byGFl
9BEAoIkS5QxdocV7rEa7DB2pcK7gE2he
=3EqV
-----END PGP SIGNATURE-----

------enig2XFKJLCPWRWBVFVVDFNSB--
