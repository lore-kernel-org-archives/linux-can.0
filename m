From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] net: can: esd_usb2: check index of array before accessing
Date: Wed, 03 Jul 2013 13:51:12 +0200
Message-ID: <51D41030.10708@pengutronix.de>
References: <1372840409-13481-1-git-send-email-mkl@pengutronix.de>  <51D3F638.3080207@esd.eu> <1372852299.15632.13.camel@blackbox>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2UGAEMOPEQILSLMVWWEKS"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37895 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503Ab3GCLvW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 3 Jul 2013 07:51:22 -0400
In-Reply-To: <1372852299.15632.13.camel@blackbox>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Max S." <max@schneidersoft.net>
Cc: Matthias Fuchs <matthias.fuchs@esd.eu>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2UGAEMOPEQILSLMVWWEKS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/03/2013 01:51 PM, Max S. wrote:
> On Wed, 2013-07-03 at 12:00 +0200, Matthias Fuchs wrote:
>> Hi,
>>
>> did anybody encounter an issue with invalid net codes comming from the=

>> device?
> Technically one could write a usb device that sends a bad
> netcode/crafted message.
>=20
> through=20
> esd_usb2_read_bulk_callback()
> 	esd_usb2_rx_can_msg(dev->nets[msg->msg.rx.net], msg);
> 	...
> 	esd_usb2_rx_event()
> 		...
> 		u8 state =3D msg->msg.rx.data[0];
> 		...
> 		priv->old_state =3D state;
>=20
> one could write any u8 memory value to <255 past dev->nets.
>=20
> ... I think.

Yes or crash the kernel by accessing bad memory, better safe then sorry.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2UGAEMOPEQILSLMVWWEKS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlHUEDAACgkQjTAFq1RaXHOd2wCfZbO8VMejlQrz84X8bwppRJB8
DbIAniz3B+kmSBWMrBETC9cxv83kJvJS
=W+Pc
-----END PGP SIGNATURE-----

------enig2UGAEMOPEQILSLMVWWEKS--
