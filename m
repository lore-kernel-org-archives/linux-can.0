From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v5] can: flexcan: Re-write receive path to use MB queue
 instead of FIFO
Date: Wed, 01 Oct 2014 11:58:16 +0200
Message-ID: <542BD038.2070106@pengutronix.de>
References: <1411995175-13540-1-git-send-email-david@protonic.nl>	<4712537.n1vM034J9B@ws-stein>	<20141001110741.0e8e5ffb@archvile>	<5856354.jaFqUxgnZF@ws-stein> <20141001113432.18ec8bed@archvile>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="kCIplmlLXswwWfIWn5K12dc6aUn97m5k0"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33968 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944AbaJAJ6Z (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Oct 2014 05:58:25 -0400
In-Reply-To: <20141001113432.18ec8bed@archvile>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>, Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kCIplmlLXswwWfIWn5K12dc6aUn97m5k0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/01/2014 11:34 AM, David Jander wrote:
[...]

> Back to topic: Can one of the maintainers (Wolfgang, Marc) give an opin=
ion on
> how to best solve the following two issues:
>=20
> 1.- Using MB area instead of FIFO for flexcan breaks RTR reception on o=
lder
> SoC's. My proposal is to modify my approach as to have two different IR=
Q
> handling paths: One that off-loads the RX-FIFO into the cyclic-buffer f=
or
> older chips and one that uses the whole MB area and off-loads it into t=
he same
> cyclic buffer for i.MX6, Vybrid and newer chips.

Sounds good.

> 2.- Since the problem addressed by my patch to at91_can is very similar=
, what
> about solving these problems in the SocketCAN framework (if that is pos=
sible)?

Have you had a look at my rx-fifo branch in
https://gitorious.org/linux-can/linux-can-next? It already tries to
abstract the simulation of the FIFO with the linear mailboxes.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--kCIplmlLXswwWfIWn5K12dc6aUn97m5k0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlQr0DgACgkQjTAFq1RaXHPTmACeP+6Sox2SLzde3KFR2MM35YOB
tbgAnjN8SjIDIfNaEh2fYvdY6ZKM9uJE
=ru9o
-----END PGP SIGNATURE-----

--kCIplmlLXswwWfIWn5K12dc6aUn97m5k0--
