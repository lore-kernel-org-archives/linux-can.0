From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: Unify MTU settings for CAN interfaces
Date: Fri, 07 Mar 2014 13:56:49 +0100
Message-ID: <5319C211.7070904@pengutronix.de>
References: <5319820D.6060104@hartkopp.net> <5319B033.10705@pengutronix.de> <5319C13E.5080103@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="BgTL6Oafc8SdLFvMRKTKsJ5nVtxUIF31l"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53951 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266AbaCGM44 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 7 Mar 2014 07:56:56 -0500
In-Reply-To: <5319C13E.5080103@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BgTL6Oafc8SdLFvMRKTKsJ5nVtxUIF31l
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 03/07/2014 01:53 PM, Oliver Hartkopp wrote:
>=20
>=20
> On 07.03.2014 12:40, Marc Kleine-Budde wrote:
>> On 03/07/2014 09:23 AM, Oliver Hartkopp wrote:
>>> CAN interfaces only support MTU values of 16 (CAN 2.0) and 72 (CAN FD=
).
>>> Setting the MTU to other values is pointless but it does not really h=
urt.
>>> With the introduction of the CAN FD support in drivers/net/can a new
>>> function to switch the MTU for CAN FD has been introduced.
>>>
>>> This patch makes use of this can_change_mtu() function to check for c=
orrect
>>> MTU settings also in legacy CAN (2.0) devices.
>>>
>>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>>
>>> diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
>>> index 3fcdae2..f5b16e0 100644
>>> --- a/drivers/net/can/slcan.c
>>> +++ b/drivers/net/can/slcan.c
>>> @@ -411,10 +411,16 @@ static void slc_free_netdev(struct net_device *=
dev)
>>>  	slcan_devs[i] =3D NULL;
>>>  }
>>> =20
>>> +static int slcan_change_mtu(struct net_device *dev, int new_mtu)
>>> +{
>>> +	return -EINVAL;
>>> +}
>>> +
>>
>> Why is the slcan special?
>=20
> slcan as well as vcan are no users of the CAN driver infrastructure.
> No include of dev.h, no bitrate settings, etc.
> The only drivers that do not depend from 'config CAN_DEV' in Kconfig.
>=20
> The -EINVAL error is only thrown when someone tries to move the slcan M=
TU away
> from the only valid CAN_MTU, see:
>=20
> 	http://lxr.free-electrons.com/source/net/core/dev.c#L5324

Thanks for the clarification.

Added yo can-next.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--BgTL6Oafc8SdLFvMRKTKsJ5nVtxUIF31l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlMZwhEACgkQjTAFq1RaXHPS6wCfc2J7ygEWHDNA6mZZrVn5o/aB
coQAoJE9gr2AVNbhAzVm4thUBfXnpO4j
=sb77
-----END PGP SIGNATURE-----

--BgTL6Oafc8SdLFvMRKTKsJ5nVtxUIF31l--
