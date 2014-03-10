From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Populating netdev::dev_id for udev discrimination
Date: Mon, 10 Mar 2014 12:01:03 +0100
Message-ID: <531D9B6F.9010603@pengutronix.de>
References: <1394294420.3356.15.camel@NREC-014563> <531CBB6F.7090803@pengutronix.de> <531D6D3B.9020900@hartkopp.net> <20140310104650.GA456@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="gB2go5gOkQUBvuI4oiBGNEbsU8H9lvlJt"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37623 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752158AbaCJLBe (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 10 Mar 2014 07:01:34 -0400
In-Reply-To: <20140310104650.GA456@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, "Christopher R. Baker" <cbaker@rec.ri.cmu.edu>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gB2go5gOkQUBvuI4oiBGNEbsU8H9lvlJt
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 03/10/2014 11:46 AM, Kurt Van Dijck wrote:
> Hey Christopher & Oliver,
>=20
> On Mon, Mar 10, 2014 at 08:43:55AM +0100, Oliver Hartkopp wrote:
>> Hello Christopher,
>>
>> On 09.03.2014 20:05, Marc Kleine-Budde wrote:
>>> On 03/08/2014 05:00 PM, Christopher R. Baker wrote:
>>
>>> You are the first one to address this issue. \o/
>>
>> I remember we discussed this issue years ago - but it was not really b=
rought
>> to an end. So I really appreciate Christophers attempt :-)
>>
>>>> udevadm info gives me the KERNELS=3D... incantation to match the pci=
 bus
>>>> address, but there are no other differences in the udev listing for =
my
>>>> various CAN ports (at least for my peak_pci device)
>>>>
>>>> Digging into the semantics of ATTRS{...}, "dev_id" stood out as havi=
ng
>>>> the intention of discriminating between physical ports
>=20
> I find this attempt attractive, because it moves multichannel device id=
entification
> to generic netdev infrastructure.
>=20
> The patch obsoletes the 'channel' sysfs property of the softing device =
driver.
> That property did exactly what can now be done with 'dev_id'.
> I'll prepare a patch when this gets accepted.
> That patch would not only remove 1 property.
> The 'channel' property required the attr_group to be present at device =
creation.
> Whithout 'channel', I could use the regular sysfs_create_group which ma=
kes
> the code even simpler.

You can create a patch against the testing branch of linux-can-next[1]

Marc

[1]
https://gitorious.org/linux-can/linux-can-next/source/e7bf719dbbad1985704=
0ef50ed8b2cfefd81d78c:

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--gB2go5gOkQUBvuI4oiBGNEbsU8H9lvlJt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlMdm28ACgkQjTAFq1RaXHOtJACfd5H0AO2/FJHekszDTo9czTYi
LnsAnjmS4U2TV/UoLAnV04P4TD4aTdtW
=Dt0D
-----END PGP SIGNATURE-----

--gB2go5gOkQUBvuI4oiBGNEbsU8H9lvlJt--
