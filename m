From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v5 5/5] can: move can_stats.bus_off++ from can_bus_off
 into can_change_state
Date: Sun, 07 Dec 2014 21:15:42 +0100
Message-ID: <5484B56E.10607@pengutronix.de>
References: <470b7276-2306-4075-814b-7ebd624903dc@GRBSR0089.marel.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="eF9G5lujOw0HtkMRp2bJXP4hN2GmEC8Q1"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38127 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752700AbaLGUPz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 7 Dec 2014 15:15:55 -0500
In-Reply-To: <470b7276-2306-4075-814b-7ebd624903dc@GRBSR0089.marel.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>, linux-can@vger.kernel.org
Cc: wg@grandegger.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eF9G5lujOw0HtkMRp2bJXP4hN2GmEC8Q1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 12/03/2014 06:54 PM, Andri Yngvason wrote:
> In order to be able to move the stats increment from can_bus_off() into=

> can_change_state(), the increment had to be moved back into code that w=
as using
> can_bus_off() but not can_change_state().
>=20
> Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>
> ---
>  drivers/net/can/bfin_can.c                  | 1 +
>  drivers/net/can/c_can/c_can.c               | 1 +
>  drivers/net/can/cc770/cc770.c               | 1 +
>  drivers/net/can/dev.c                       | 3 ++-
>  drivers/net/can/m_can/m_can.c               | 1 +
>  drivers/net/can/pch_can.c                   | 1 +
>  drivers/net/can/rcar_can.c                  | 1 +
>  drivers/net/can/softing/softing_main.c      | 1 +
>  drivers/net/can/spi/mcp251x.c               | 1 +
>  drivers/net/can/ti_hecc.c                   | 1 +
>  drivers/net/can/usb/ems_usb.c               | 1 +
>  drivers/net/can/usb/esd_usb2.c              | 1 +
>  drivers/net/can/usb/peak_usb/pcan_usb.c     | 1 +
>  drivers/net/can/usb/peak_usb/pcan_usb_pro.c | 1 +
>  drivers/net/can/usb/usb_8dev.c              | 1 +
>  15 files changed, 16 insertions(+), 1 deletion(-)

What about:

> drivers/net/can/c_can/c_can.c-910-		cf->can_id |=3D CAN_ERR_BUSOFF;
> drivers/net/can/c_can/c_can.c:911:		can_bus_off(dev);

> drivers/net/can/janz-ican3.c-1010-			cf->can_id |=3D CAN_ERR_BUSOFF;
> drivers/net/can/janz-ican3.c:1011:			can_bus_off(dev);

> drivers/net/can/xilinx_can.c-560-		priv->write_reg(priv, XCAN_SRR_OFFSE=
T, XCAN_SRR_RESET_MASK);
> drivers/net/can/xilinx_can.c:561:		can_bus_off(ndev);

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--eF9G5lujOw0HtkMRp2bJXP4hN2GmEC8Q1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUhLVvAAoJECte4hHFiupUL7EP/i1USECihmTz87fySk/AFM8Q
iN2ADlOOftW9HdlB+/y0r6Eui3QF5LjEuqyj7c8rJPM5tXvOoe01qU1zkzgUdeKV
kh6e8PD7tdvYvgyQMvp88K9w4tfFtD0Q9XFiMebPQo2ac/ijm3Ffow4XopI1+j+W
6l7m4Z+C4JBzeNXLraXwplr2kWU6VIxAvY/1MqIPxK0ZnAaLfxJ0kbXr/3Cdo3hm
V+ax3QOxHOGopPeexcqjz+SednYsMvdWuhkzLg+dKABJPfRMoD50feuR3EH1YSSo
XQU/Umq+eGXLj5A1aS4q1eNLjcIWcdKsc0KwonxQ5u4XjhDo2+XoPArmduQHFz5N
4n/DdpMH/xJXGz4d/Hjmi6c3VN9V2tWNsB+Sv+TrkmEoJOZJetBcINsY9q6ywqMI
KTUQRyHUQ7Y9qsdvomEHkc92kZTD8WrXthcCwGx0UyHqrZV5cuhJxo1p+EhQHSll
IGS/2SOSxjJGisbdldVlWwf8Sa388fYhq02B9cW4Vw7d2iw8HGoIgCF3qn8KFWTI
8Bv1plIOgqr5JtlqHLDJ8r1Sk7iYlfYwNYOBjeNj7lDuGmcH8uRLYPr0tfvZc2hI
PrD1JGwJMuJq4iIT6aXq80vZHPHWZgPWphq0i+FnOKjZnOUDMrX1gjdlZ9l86f73
nCtMP8a9CqrmuqwEmOOx
=zVNS
-----END PGP SIGNATURE-----

--eF9G5lujOw0HtkMRp2bJXP4hN2GmEC8Q1--
