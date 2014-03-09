From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Populating netdev::dev_id for udev discrimination
Date: Sun, 09 Mar 2014 20:05:19 +0100
Message-ID: <531CBB6F.7090803@pengutronix.de>
References: <1394294420.3356.15.camel@NREC-014563>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="RsXVtQHEXhrTeCot0EiaMJS4l66DtICav"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52812 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949AbaCITFf (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 9 Mar 2014 15:05:35 -0400
In-Reply-To: <1394294420.3356.15.camel@NREC-014563>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Christopher R. Baker" <cbaker@rec.ri.cmu.edu>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RsXVtQHEXhrTeCot0EiaMJS4l66DtICav
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 03/08/2014 05:00 PM, Christopher R. Baker wrote:
> I'm new to the list, and have poked around on gmane enough to convince
> myself that this hasn't been covered before, but if I've missed
> something in this vein, apologies in advance.

You are the first one to address this issue. \o/

> My objective is to be able to totally discriminate CAN ports on
> multi-port cards via udev so as to rename them to semantically
> interesting/unique names for my system (e.g., "ecuCAN" and "auxCAN"
> instead of "can0" and "can1").
>
> udevadm info gives me the KERNELS=3D... incantation to match the pci bu=
s
> address, but there are no other differences in the udev listing for my
> various CAN ports (at least for my peak_pci device)
>=20
> Digging into the semantics of ATTRS{...}, "dev_id" stood out as having
> the intention of discriminating between physical ports that "share the
> same link layer" (from netdev.h) or "share the same MAC address" (from
> various other mailing lists).
>=20
> The following patch assigns the dev_id field to match the channel numbe=
r
> on all multi-channel cards I could identify in a fresh git pull under
> drivers/net/can.  I can only test my two-port Peak PCI card, but it
> works as expected: ATTRS{dev_id} now expresses the port number and my
> udev rules now unambiguously pick out and rename my individual CAN
> ports.
>=20
> The drivers for other cards I have touched at least compile, but should=

> certainly be tested before deploying this patch.

Thanks for the patch, looks good. Can I add your Signed-off-by[1]?

Marc

[1]
http://lxr.free-electrons.com/source/Documentation/SubmittingPatches#L307=

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--RsXVtQHEXhrTeCot0EiaMJS4l66DtICav
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlMcu28ACgkQjTAFq1RaXHMoVACfVCWpRRr9oE8W6TxjmjuqW1Zc
XfkAnApQ8mPbYP8/P4IpFaaj4kYl4Yz5
=ceu+
-----END PGP SIGNATURE-----

--RsXVtQHEXhrTeCot0EiaMJS4l66DtICav--
