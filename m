From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [can:for-davem 2/3] drivers/net/can/usb/kvaser_usb.c:431 kvaser_usb_send_simple_msg()
 error: doing dma on the stack ((null))
Date: Thu, 22 Nov 2012 14:05:30 +0100
Message-ID: <50AE231A.2040306@pengutronix.de>
References: <50ae18f9.g1Qzcmfv5xzx4tke%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF39E00CC9D77682C94F4B7ED"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48610 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756728Ab2KVTT7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Nov 2012 14:19:59 -0500
In-Reply-To: <50ae18f9.g1Qzcmfv5xzx4tke%fengguang.wu@intel.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Olivier Sobrie <olivier@sobrie.be>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF39E00CC9D77682C94F4B7ED
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello Olivier,

can you please ask on the usb mailinglist how to fix this problem (given
this isn't a false positive)

Marc

On 11/22/2012 01:22 PM, kbuild test robot wrote:
> tree:   git://gitorious.org/linux-can/linux-can-next for-davem
> head:   21c837dccb1b249864b9c8475f51dad355b42554
> commit: f0fbcc3bab6ff298bbb8c91de2ddf2824996181f [2/3] can: kvaser_usb:=
 Add support for Kvaser CAN/USB devices
>=20
>=20
> smatch warnings:
>=20
> + drivers/net/can/usb/kvaser_usb.c:431 kvaser_usb_send_simple_msg() err=
or: doing dma on the stack ((null))
> + drivers/net/can/usb/kvaser_usb.c:1073 kvaser_usb_set_opt_mode() error=
: doing dma on the stack ((null))
> + drivers/net/can/usb/kvaser_usb.c:1174 kvaser_usb_flush_queue() error:=
 doing dma on the stack ((null))
> + drivers/net/can/usb/kvaser_usb.c:1384 kvaser_usb_set_bittiming() erro=
r: doing dma on the stack ((null))
>=20
> vim +431 drivers/net/can/usb/kvaser_usb.c
>=20
> f0fbcc3b Olivier Sobrie 2012-11-21  415  end:
> f0fbcc3b Olivier Sobrie 2012-11-21  416  	kfree(buf);
> f0fbcc3b Olivier Sobrie 2012-11-21  417 =20
> f0fbcc3b Olivier Sobrie 2012-11-21  418  	return err;
> f0fbcc3b Olivier Sobrie 2012-11-21  419  }
> f0fbcc3b Olivier Sobrie 2012-11-21  420 =20
> f0fbcc3b Olivier Sobrie 2012-11-21  421  static int kvaser_usb_send_sim=
ple_msg(const struct kvaser_usb *dev,
> f0fbcc3b Olivier Sobrie 2012-11-21  422  				      u8 msg_id, int chann=
el)
> f0fbcc3b Olivier Sobrie 2012-11-21  423  {
> f0fbcc3b Olivier Sobrie 2012-11-21  424  	struct kvaser_msg msg =3D {
> f0fbcc3b Olivier Sobrie 2012-11-21  425  		.len =3D MSG_HEADER_LEN + si=
zeof(struct kvaser_msg_simple),
> f0fbcc3b Olivier Sobrie 2012-11-21  426  		.id =3D msg_id,
> f0fbcc3b Olivier Sobrie 2012-11-21  427  		.u.simple.channel =3D channe=
l,
> f0fbcc3b Olivier Sobrie 2012-11-21  428  		.u.simple.tid =3D 0xff,
> f0fbcc3b Olivier Sobrie 2012-11-21  429  	};
> f0fbcc3b Olivier Sobrie 2012-11-21  430 =20
> f0fbcc3b Olivier Sobrie 2012-11-21 @431  	return kvaser_usb_send_msg(de=
v, &msg);
> f0fbcc3b Olivier Sobrie 2012-11-21  432  }
> f0fbcc3b Olivier Sobrie 2012-11-21  433 =20
> f0fbcc3b Olivier Sobrie 2012-11-21  434  static int kvaser_usb_get_soft=
ware_info(struct kvaser_usb *dev)
> f0fbcc3b Olivier Sobrie 2012-11-21  435  {
> f0fbcc3b Olivier Sobrie 2012-11-21  436  	struct kvaser_msg msg;
> f0fbcc3b Olivier Sobrie 2012-11-21  437  	int err;
> f0fbcc3b Olivier Sobrie 2012-11-21  438 =20
> f0fbcc3b Olivier Sobrie 2012-11-21  439  	err =3D kvaser_usb_send_simpl=
e_msg(dev, CMD_GET_SOFTWARE_INFO, 0);
>=20
> ---
> 0-DAY kernel build testing backend         Open Source Technology Cente=
r
> Fengguang Wu, Yuanhan Liu                              Intel Corporatio=
n
>=20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigF39E00CC9D77682C94F4B7ED
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlCuIx4ACgkQjTAFq1RaXHPOtACgjEkwqg6CzSyWYt/gsQnCGMG4
mP0AoJSoR7kRylHYsFKV9NtwU804mfRY
=L5fU
-----END PGP SIGNATURE-----

--------------enigF39E00CC9D77682C94F4B7ED--
