From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: can-next rebase?
Date: Tue, 15 Jan 2013 10:35:33 +0100
Message-ID: <50F522E5.4080403@pengutronix.de>
References: <50F45338.9060301@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2STMNUXOACRLRRBHPKTSS"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44691 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892Ab3AOJfj (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 15 Jan 2013 04:35:39 -0500
In-Reply-To: <50F45338.9060301@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2STMNUXOACRLRRBHPKTSS
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 01/14/2013 07:49 PM, Oliver Hartkopp wrote:

[...]

> But coming back to the mail topic:
>=20
> I think i would need at least three patches for this change.
>=20
> When trying to rebase linux-can-next the automatic merge fails ...
>=20
> $ git rebase       =20
> First, rewinding head to replay your work on top of it...
> Applying: can: add tx/rx LED trigger support
> Applying: can: flexcan: add LED trigger support
> Applying: can: add tx/rx LED trigger support
> Using index info to reconstruct a base tree...
> Falling back to patching base and 3-way merge...
> No changes -- Patch already applied.
> Applying: can: flexcan: add LED trigger support
> Using index info to reconstruct a base tree...
> Falling back to patching base and 3-way merge...
> No changes -- Patch already applied.
> Applying: can: c_can: Add device tree support to Bosch C_CAN/D_CAN cont=
roller
> Using index info to reconstruct a base tree...
> Falling back to patching base and 3-way merge...
> Auto-merging drivers/net/can/c_can/c_can_platform.c
> CONFLICT (content): Merge conflict in drivers/net/can/c_can/c_can_platf=
orm.c
> Auto-merging Documentation/devicetree/bindings/net/can/c_can.txt
> CONFLICT (add/add): Merge conflict in Documentation/devicetree/bindings=
/net/can/c_can.txt
> Failed to merge in the changes.
> Patch failed at 0005 can: c_can: Add device tree support to Bosch C_CAN=
/D_CAN controller
>=20
> When you have resolved this problem run "git rebase --continue".
> If you would prefer to skip this patch, instead run "git rebase --skip"=
=2E
> To check out the original branch and stop rebasing run "git rebase --ab=
ort".

The LED patches are not yet part or linux-can-next/master,
linux-can-next/master was clean, a parent of net-next/master. However
I've pushed net-next/master to linux-can-next/master.

I hope I'll find time today to pick up all outstanding patches and queue
them.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2STMNUXOACRLRRBHPKTSS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlD1IugACgkQjTAFq1RaXHNv4ACgkAommhzDl6b9bv2bckWqdSOD
0c8AniDbnj4MUjsC6EB17N8lS5SgeY7j
=3KPI
-----END PGP SIGNATURE-----

------enig2STMNUXOACRLRRBHPKTSS--
