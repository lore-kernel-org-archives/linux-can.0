From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Request for proper hardware dependencies
Date: Tue, 13 May 2014 16:37:20 +0200
Message-ID: <53722E20.9080405@pengutronix.de>
References: <21352.42929.159377.243822@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="PWaHFsFO3iI1w20cIgTIF0oVAAbVsHEQ0"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54538 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933327AbaEMOhY (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 13 May 2014 10:37:24 -0400
In-Reply-To: <21352.42929.159377.243822@gargle.gargle.HOWL>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>, linux-can@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PWaHFsFO3iI1w20cIgTIF0oVAAbVsHEQ0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 05/06/2014 11:13 AM, Uwe Bonnes wrote:
> Hallo,
>=20
> the number of kernel driver exploded in the last years and so the kerne=
l
> configuration. Distribution mantainers must at some point limit compile=
d
> driver at least partly to the driver needed one on a given arch. Howeve=
r the
> distribution maintainers mosty can't always know what they deal about.
>=20
> For me this resulted in loosing socketcan from the Opensuse Kernels in
> between 12.3 up to some weeks ago, as one maintainer (not Jean) matched=

> socketcan in error with "SPI" which is not related to normal desktop
> machines. See
> http://lists.opensuse.org/archive/opensuse-bugs/2014-01/msg00970.html.
> Opensuse 13.1 recent kernels and the next release will have socketcan a=
gain,
> but in the course of the discussion Jean Delvare pointed some weak poin=
ts in
> socketcan configuration, leading to compilation on driver not needed on=
 some
> archs:
>=20
>>>>>> "Jean" =3D=3D Jean Delvare <jdelvare@suse.com> writes:
>=20
>     Jean> For the record, hardware dependencies on CAN device drivers a=
ren't
>     Jean> that bad in general, I've seen worse in several other subsyst=
ems.
>=20
>     Jean> That being said, there is still some room for improvement. Fo=
r
>     Jean> example, CAN_AT91 could depend on ARCH_AT91 instead of just A=
RM,
>     Jean> PCH_CAN could depend on X86, and a few drivers with "ISA" in =
their
>     Jean> description should probably depend on ISA. I'm also not sure =
why
>     Jean> CAN_MSCAN alternatively depends on M68K instead of just
>     Jean> ARM. That's just from a quick look from the non-initiate I am=
,
>     Jean> there may be more dependency fix-ups possible.  I'll send a f=
ew
>     Jean> patches out if I can find some time for that today.
>=20
> Please consider openly his patches or even better consider a cleanup yo=
urself.

I've applied all 3 patches by Jean to can-next.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--PWaHFsFO3iI1w20cIgTIF0oVAAbVsHEQ0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlNyLiAACgkQjTAFq1RaXHMgLgCfTI8dIbFOhOyvwyf9FFf7f2ul
QaQAn0BsHxSTCMAgdMcqsWAjnWjzdjsI
=04kF
-----END PGP SIGNATURE-----

--PWaHFsFO3iI1w20cIgTIF0oVAAbVsHEQ0--
