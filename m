From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3 5/5] can: allow to change the device mtu for CAN FD
 capable devices
Date: Tue, 18 Feb 2014 12:09:49 +0100
Message-ID: <53033F7D.9090805@pengutronix.de>
References: <1392481934-12569-1-git-send-email-socketcan@hartkopp.net> <1392481934-12569-5-git-send-email-socketcan@hartkopp.net> <52FF9D0C.30406@pengutronix.de> <52FFA3EB.7060902@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="NuuquVfffxgn24uSIaGdfvjsJ8LnErjI5"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57610 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754466AbaBRLJz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 18 Feb 2014 06:09:55 -0500
In-Reply-To: <52FFA3EB.7060902@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NuuquVfffxgn24uSIaGdfvjsJ8LnErjI5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 02/15/2014 06:29 PM, Oliver Hartkopp wrote:
>> On 02/15/2014 05:32 PM, Oliver Hartkopp wrote:
>>> The configuration for CAN FD depends on CAN_CTRLMODE_FD enabled in th=
e driver
>>> specific ctrlmode_supported capabilities.
>>>
>>> The configuration can be done either with the 'fd { on | off }' optio=
n in the
>>> 'ip' tool from iproute2 or by setting the CAN netdevice MTU to CAN_MT=
U (16) or
>>> to CANFD_MTU (72).
>>
>> Please don't add two possibilities to activate canfd on a CAN network
>> card. There should only be one.
>=20
> Yes it /should/ be like this.
> I thought about it some time but I didn't find a better solution.
>=20
> The problem is that dev->mtu is the switch for the skb->len whether CAN=
 frames
> or CAN FD frames are generated or received.
>=20
> The MTU can be modified by 'ip' (independently from CAN specific settin=
gs).

It _can_ be modified (directly by the userspace) _if_ the change mtu
callback is implemented. Maybe we don't need the callback?

> OTOH the only way the CAN devices provide their capabilities is the
> ctrlmode_supported bitfield - and it does not make sense to provide
> CAN_CTRLMODE_FD in ctrlmode_supported and do not provide the configurat=
ion for it.
>=20
> If you would skip the CAN_CTRLMODE_FD bit in ctrlmode_supported there's=
 no way
> to identify a CAN FD capable device. You could only try to set the MTU =
to
> CANFD_MTU and see, if it fails. Not a good solution either.
>=20
>=20
>>> +EXPORT_SYMBOL_GPL(can_change_mtu);
>>
>> Who will be the user of this function? The individual network drivers?=

>>
>=20
> Yes. It manages the MTU and CAN_CTRLMODE_FD consistency and only allows=
 the
> CANFD_MTU when the driver supports it.

And it has to be assigned by a FD capable driver to the net_device_ops,
right?

> Any other things to look at - or is the rest ok so far?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--NuuquVfffxgn24uSIaGdfvjsJ8LnErjI5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlMDP30ACgkQjTAFq1RaXHPHKACfQnNnwOu/oKTI5hIB8ip6FV0R
6ZQAoI+8L3wKD+Vt2zkQgx9Gyjg/VaEe
=imNz
-----END PGP SIGNATURE-----

--NuuquVfffxgn24uSIaGdfvjsJ8LnErjI5--
