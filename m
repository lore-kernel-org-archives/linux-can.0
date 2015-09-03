From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/8] RFC: more flexcan cleanups and SW FIFO IRQ offloading
Date: Thu, 3 Sep 2015 10:45:52 +0200
Message-ID: <55E808C0.8040309@pengutronix.de>
References: <1441103522-15593-1-git-send-email-mkl@pengutronix.de>
 <55E78D42.1060109@optusnet.com.au> <20150903083208.29333e01@archvile>
 <55E7EF8D.306@pengutronix.de> <55E80231.30808@optusnet.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="WLpoBlpoCre8wQfE0IutKWrr1IFo7EidM"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48489 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286AbbICIqB (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 Sep 2015 04:46:01 -0400
In-Reply-To: <55E80231.30808@optusnet.com.au>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: tom_usenet@optusnet.com.au, David Jander <david@protonic.nl>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WLpoBlpoCre8wQfE0IutKWrr1IFo7EidM
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/03/2015 10:17 AM, Tom Evans wrote:
> On 03/09/15 16:58, Marc Kleine-Budde wrote:
>> On 09/03/2015 08:32 AM, David Jander wrote:
>>>>> this series adds a software FIFO implementation and switches
>=20
> Thank you both for explaining that.
>=20
> It seems fairly bulletproof as long as it doesn't overflow. There are 6=
4=20
> buffers, so 32 in the first half, so that handles a 1.5ms interrupt lat=
ency.
>=20
> A shame Freescale didn't think of that method instead of requiring the =
driver=20
> run quicksort somewhere.
>=20
>  > In an atomic operation, the MB's that have been served are
>  > now disabled.
>=20
> That's the sort of tricky operation that exposes nasty silicon bugs. I'=
d=20
> suggest that this mode be made easy to turn off in case some chip varia=
nt has=20
> a problem like htis.

This mode is only enabled on imx6, vybid and newer, as all the other
cores cannot receive RTR frames in the non FIFO mode.

> This feature looks to be enabled as a "QUIRK" of the CPU.

The quirk to enable the non FIFO mode, a.k.a. SW_FIFO is called
FLEXCAN_QUIRK_USE_SW_FIFO. See patch 7/8 where it is enabled on imx6 and
vybrid.

> In an old generation kernel this might be optionally enabled in the .co=
nfig=20
> file, as NAPI is in the 2.6.35 FEC drivers I'm stuck with using at the =
moment=20
> on the i.MX53. In the current kernel, could this mode of operation (and=
/or=20
> hardware FIFO using NAPI) be made configurable in the Device Tree inste=
ad?

Since 4.0 or something you really want to use NAPI, otherwise the order
of the packages is not guaranteed by the networking stack. So in both
case we use NAPI, but read the CAN frames in the hard IRQ context.
Either with the traditional FIFO (on that powerpc, imx25, imx35, imx53
and imx28) or the non-FIFO mode (imx6, vybrid).

With the current implementation, when enabling FLEXCAN_QUIRK_USE_SW_FIFO
on mx28, the controller doesn't receive RTR and extended CAN frames. RTR
is a known issue for the older cores, whie extended frames is probably a
configuration issue.

Given that the extended frame issue is fixed, you might want to
sacrifice RTR reception (because you don't need it) for bigger buffers
you can either patch the driver (adding the FLEXCAN_QUIRK_USE_SW_FIFO),
add a device tree option (convince the reviewers that this not a
confiuration option but a hardware description) or make it a new
CAN_CTRLMODE, so that it can be configured from the userspace.

According to the documentation both the normal FIFO and the mailboxes
can be used for RX at the same time, we can try to setup filters, so
that the FIFO is used for RTR messages only, while the normal mailboxes
are used for the non RTR messages. In order to merge these two together
we probably need to evaluate the timestamps.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--WLpoBlpoCre8wQfE0IutKWrr1IFo7EidM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJV6AjAAAoJEP5prqPJtc/HUWoH/3X5GWTYDjzTKdilI5+iQWhZ
kYYjf+Wm+Wpk6UY2oTF79y210rzBXW25fFcpj+h4SwBHYhi4YjyxJ8iFs4ysu6Ca
FW+Y/j+eztpbV2VVrskEjVIy3g97apHvbLY5H0oORuI3ZBLeZcHupFyeQh9J/oPp
cbQlS+EaUjSt8SiFl7Zj2JnDwWaSs78Ej+Ma7nuj6iDe08kLrUawUAtX5zEEALD9
Qi++gebomoWnD8HYrQzHZH46IqoFHmSi1I7V2xVmAiBhowCZEO+s+zROZTI04pAL
Qo0GvcluR3nI7jYxQlbRHc9WXvPDbvkXwBV99/Npx2A8WSect1FHac+9wvZBoWU=
=TZKu
-----END PGP SIGNATURE-----

--WLpoBlpoCre8wQfE0IutKWrr1IFo7EidM--
