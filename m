From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [can:for-davem 2/3] drivers/net/can/usb/kvaser_usb.c:431 kvaser_usb_send_simple_msg()
 error: doing dma on the stack ((null))
Date: Thu, 22 Nov 2012 16:50:42 +0100
Message-ID: <50AE49D2.4080709@pengutronix.de>
References: <50ae18f9.g1Qzcmfv5xzx4tke%fengguang.wu@intel.com> <50AE231A.2040306@pengutronix.de> <20121122144648.GA11612@hposo>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1EFF996BC7EDA9FE63065DEB"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48632 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752257Ab2KVTUQ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Nov 2012 14:20:16 -0500
In-Reply-To: <20121122144648.GA11612@hposo>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Olivier Sobrie <olivier@sobrie.be>
Cc: linux-can@vger.kernel.org, Fengguang Wu <fengguang.wu@intel.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1EFF996BC7EDA9FE63065DEB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/22/2012 03:46 PM, Olivier Sobrie wrote:
> Hi Marc,
>=20
> Argh.
>=20
> On Thu, Nov 22, 2012 at 02:05:30PM +0100, Marc Kleine-Budde wrote:
>> Hello Olivier,
>>
>> can you please ask on the usb mailinglist how to fix this problem (giv=
en
>> this isn't a false positive)
>=20
> Ok I'll ask. By googling I found this which looks to be a similar probl=
em
> fixed in another driver.
> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux.git;a=3Dcomm=
itdiff;h=3D32ec4576c3fb37316b1d11a04b220527822f3f0d
>=20
> I assume I've to kmalloc the kvaser_msg I send through
> kvaser_usb_send_msg(). I'll ask to people of linux-usb to be sure.
>=20
> By the way I installed smatch (which I never used) and ran the command
>  make CHECK=3D"~/bin/smatch -p=3Dkernel" C=3D1"
> in my kernel dir but I didn't get the error:
>   CHECK   drivers/net/can/usb/kvaser_usb.c
>   CC [M]  drivers/net/can/usb/kvaser_usb.o
>=20
> Do I've to give a specific option to smatch to get this error?

I've not used smack either. Maybe Wu can give us some hints and/or links.=


Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig1EFF996BC7EDA9FE63065DEB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlCuSdUACgkQjTAFq1RaXHNa6wCgkBNHtEkeDTD8G1ZPioKl1Qn7
9dgAoIIBelZRmjTpPyjfaALJwuiasAPK
=Xygy
-----END PGP SIGNATURE-----

--------------enig1EFF996BC7EDA9FE63065DEB--
