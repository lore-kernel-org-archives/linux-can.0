From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can/sja1000: Add miniPCIe/cPCI PC/104Plus PCI/104e PEAK-System
 boards
Date: Fri, 26 Oct 2012 10:11:22 +0200
Message-ID: <508A45AA.3080105@pengutronix.de>
References: <1350988637-13581-1-git-send-email-s.grosjean@peak-system.com> <50878AD9.6070302@grandegger.com> <508A4369.9010301@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE2B3D536626DB5B8FB9A8233"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44940 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757210Ab2JZIL1 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 26 Oct 2012 04:11:27 -0400
In-Reply-To: <508A4369.9010301@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE2B3D536626DB5B8FB9A8233
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 10/26/2012 10:01 AM, Stephane Grosjean wrote:
> Hi Wolfgang,
> Hi everybody,

> Well the "push PATCH" method is bit too formal, it should exist a field=

> where to say "Hello guys, how are you since last time ? Sorry to distur=
b
> you again, but I'd like to push..." ;-)

:D

If you want to add some prose text to the patch, that should not go into
the commit message you simply add it between the "---" and the diffstat:

> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> ---

=2E..here...

>  drivers/net/can/sja1000/peak_pci.c |   12 +++++++++++-
>  1 files changed, 11 insertions(+), 1 deletions(-)


> Le 24/10/2012 08:29, Wolfgang Grandegger a =E9crit :
>> Hi Stephane,
>>
>> On 10/23/2012 12:37 PM, Stephane Grosjean wrote:
>>     MODULE_AUTHOR("Wolfgang Grandegger <wg@grandegger.com>");
>> +MODULE_AUTHOR("Stephane Grosjean <s.grosjean@peak-system.com>");
>> Hm, does adding a second MODULE_AUTHOR work? Anyway, feel free to remo=
ve
>> my line.
>=20
> Yes it does:
>=20
> $ modinfo peak_pci.ko
> filename:       peak_pci.ko
> license:        GPL v2
> description:    Socket-CAN driver for PEAK PCAN PCI family cards
> author:         Stephane Grosjean <s.grosjean@peak-system.com>
> author:         Wolfgang Grandegger <wg@grandegger.com>
> srcversion:     72C217A41A3CA4ABBFEAFDB
> alias:          pci:v0000001Cd00000002sv*sd*bc*sc*i*
> alias:          pci:v0000001Cd00000004sv*sd*bc*sc*i*
> alias:          pci:v0000001Cd00000007sv*sd*bc*sc*i*
> alias:          pci:v0000001Cd00000006sv*sd*bc*sc*i*
> alias:          pci:v0000001Cd00000008sv*sd*bc*sc*i*
> alias:          pci:v0000001Cd00000005sv*sd*bc*sc*i*
> alias:          pci:v0000001Cd00000003sv*sd*bc*sc*i*
> alias:          pci:v0000001Cd00000001sv*sd*bc*sc*i*
> depends:        sja1000,i2c-algo-bit
> vermagic:       3.0.0-14-generic-pae SMP mod_unload modversions 686
>=20
> (well, don't ask me why my name comes before yours ;-) Maybe the
> alphabetic order is used instead of the declaration order...)
>=20
> So, for me there is no need (and I don't want) to remove yours.

I've replaced you as the author and the patch is already in David
Millers net tree.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigE2B3D536626DB5B8FB9A8233
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlCKRaoACgkQjTAFq1RaXHMXqQCfZ5ngodfieuR3hKynLd8JWSmD
hEoAn2NBdyX1mB5j6zMhh+TUy4QdEq2H
=+4ZZ
-----END PGP SIGNATURE-----

--------------enigE2B3D536626DB5B8FB9A8233--
