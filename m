From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: exclusive access to can interface
Date: Tue, 08 Jan 2013 10:32:25 +0100
Message-ID: <50EBE7A9.3050809@pengutronix.de>
References: <2412937.XVpYjfC7zz@ws-stein> <50EB10F4.6070308@pengutronix.de> <2293513.Wi876mfY7y@ws-stein>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE3AF4138F257F0280093B199"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40176 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754135Ab3AHJca (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Jan 2013 04:32:30 -0500
In-Reply-To: <2293513.Wi876mfY7y@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE3AF4138F257F0280093B199
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 01/08/2013 10:23 AM, Alexander Stein wrote:
> Hello Marc,
>=20
> On Monday 07 January 2013 19:16:20, Marc Kleine-Budde wrote:
>> On 01/07/2013 05:52 PM, Alexander Stein wrote:
>>> is there a way to get exclusive (write) access to a CAN interface, so=

>>> that only one bound socket can write CAN frames on the bus?
>>
>> No, what's the use case?
>=20
> This was a customers request in order to prevent multiple applications =
(or=20
> instances) to send CAN frames on a specific CAN interface at the same t=
ime=20
> with the very same CAN-IDs. Concurrent reads shall still be allowed!

Sending CAN frames is proper serialized by the networking subsystem :)
If back to back CAN frames are a problem it seems the design of the
application is fishy.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigE3AF4138F257F0280093B199
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlDr56wACgkQjTAFq1RaXHO0NgCePTtKKet6owktiwvcU8lOLb6u
sZAAn1iMGdEz06GkCcV+sprcEDDuLecI
=rFx2
-----END PGP SIGNATURE-----

--------------enigE3AF4138F257F0280093B199--
