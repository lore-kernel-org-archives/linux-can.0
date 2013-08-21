From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Reading messages that use BAM, or have a DLC larger than 8
Date: Wed, 21 Aug 2013 22:19:22 +0200
Message-ID: <521520CA.5080700@pengutronix.de>
References: <9522AFA707AD744DA5CF5DF53E30277430EEDB1B86@WEICSUS1.weics.local> <52151DCA.3000606@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="LwNwDN7ttFBPJNhih9b8pFutqStvsincH"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33320 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289Ab3HUUTb (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 21 Aug 2013 16:19:31 -0400
In-Reply-To: <52151DCA.3000606@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Brent Sink <Brent.Sink@we-ics.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Kurt Van Dijck <kurt.van.dijck@eia.be>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LwNwDN7ttFBPJNhih9b8pFutqStvsincH
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/21/2013 08:43 PM, Brent Sink wrote:
> How do I read J1939 messages that use the BAM format?  Some of the
> diagnostic messages that are on the DM01 message have a DLC that is
> often larger than 8 bytes when the message contains more than one
> error.  Is there something special that I need to do to enable reading
> these messages?  Thanks!

With mainline linux you just receive raw CAN frames. I'm not a j1939
expert, as far as I can see, BAM is a transport protocol for CAN.

There are two options:
1) You have to implement the BAM protocol yourself either,
   a) inside the kernel or
   b) inside userspace.
2) Talk to Kurt (Cc'ed) if his j1939 patches support BAM.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--LwNwDN7ttFBPJNhih9b8pFutqStvsincH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlIVIMoACgkQjTAFq1RaXHOvegCgiwVud/JGsuLx7G9qyN+++iAy
oHEAn2V6CcN6KrP4CRPZxPArralOsFhy
=z3UP
-----END PGP SIGNATURE-----

--LwNwDN7ttFBPJNhih9b8pFutqStvsincH--
