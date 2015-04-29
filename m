From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: kvaser leaf and SocketCAN
Date: Wed, 29 Apr 2015 08:34:25 +0200
Message-ID: <55407B71.8030005@pengutronix.de>
References: <loom.20150422T090300-352@post.gmane.org> <553755E8.20704@pengutronix.de> <loom.20150429T040002-878@post.gmane.org> <CANGgnMbtZz2M=-7ydV6iSFtCskTeXnKsWVB9rqnwX1M+SE1AAg@mail.gmail.com> <loom.20150429T063429-693@post.gmane.org> <55406A03.9060105@pengutronix.de> <loom.20150429T081022-13@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="VDpCSMBMmUWcQsjhn2jtxqgolhpowhbvG"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43927 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126AbbD2GhN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 29 Apr 2015 02:37:13 -0400
In-Reply-To: <loom.20150429T081022-13@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Leo Stan <leo.stanislas@qut.edu.au>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VDpCSMBMmUWcQsjhn2jtxqgolhpowhbvG
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/29/2015 08:15 AM, Leo Stan wrote:
> I uninstalled the driver and now :
>=20
> - I don't have the leaf in /dev/ when I plug it, which is a good thing
> - I have those modules running :
>=20
> can_raw                17159  0=20
> can                    45043  1 can_raw
> kvaser_usb             22385  0=20
> can_dev                21659  1 kvaser_usb
>=20
> - ifconfig -a shows the CAN :
>=20
> can0      Link encap:UNSPEC  HWaddr 00-00-00-00-00-00-00-00-00-00-00-00=
-00-
  ^^^^
> 00-00-00 =20
>           NOARP  MTU:16  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:10=20
>           RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

\o/

> - My kernel log shows :
>=20
> usb 1-3: new high-speed USB device number 4 using xhci_hcd
> [ 1393.767114] usb 1-3: New USB device found, idVendor=3D0bfd, idProduc=
t=3D0120
> [ 1393.767124] usb 1-3: New USB device strings: Mfr=3D0, Product=3D2,=20
> SerialNumber=3D0
> [ 1393.767128] usb 1-3: Product: Kvaser Leaf Light HS
> [ 1393.815801] CAN device driver interface
> [ 1393.857896] usbcore: registered new interface driver kvaser_usb
>=20
> - When I try to run the example from http://en.wikipedia.org/wiki/Socke=
tCAN I get this error :
>=20
> vcan0 at index 1866752400
  ^^^^^
> Error in socket bind: No such device

You're using "can0" - the example is for virtual CAN device "vcan0".
Please change the interface in the Code.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--VDpCSMBMmUWcQsjhn2jtxqgolhpowhbvG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJVQHtxAAoJECte4hHFiupUNf8P/2h9d65IuvCMO6hcy0aRuSRK
pPabo/DM21XJYl+8jOQ2vIBHhQ5RBcobp0Ud5FMxkJk2bV8H1Q3aX2quYMEw2wd9
XK93E2gTYhcb2ayqlYqIu8CitbMQLMpR9sFGcbnU3i8BjJkZ+ocKQQA5uioNCZ84
EoHqGcQYFHlGw7pK5oZLtSg6DrrbPCOXDXpB+wDVQYR/09dwI5Hq4igkSdeL5Szv
BC65GjH6RgO/trCo5YJkpaBRQx3iqrXLtFntWNO34Xiilsv3gyUxHXVo/CcAs508
Wp3KQpsSS7HsR1I0/Is54zWM1srIeNcEq1oIYGDxAnFleCGWGBLzSNfcTX/5LPdk
Fk7lsdCJJcoDYa3/yAZoFdUaoIfq5vWmNal6goQ2efuuW/gmZzSfx1glQz5I+Y37
KxcZrMVxeXWrdCuFEgDNn9H8SFC75rLCi0f5ZaOXS5bl2Qfp1oaXwguuCHTH6+vL
jmdxuoEEm5UvnhGx4jgNfTNw6/CfPXck4jJQMNz/4wg/18e9NPPqaZFBQk2+/IpQ
9t8sgxIGKKzhSOVP1YizFhXGLQ9L4DvDVGv0JKkL8Dy5j9Ab9S6g1CBPWmc8nVC3
SoYlZgKfLjiJS9F+JE+WOybz29hqrwRYIdQ1X19OWFJxVDWX6NWWqXVRqxTgVwU8
riqhc0Qn6UTPTbVE0KuI
=zM1Q
-----END PGP SIGNATURE-----

--VDpCSMBMmUWcQsjhn2jtxqgolhpowhbvG--
