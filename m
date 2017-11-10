From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/2] can: flexcan: Remodel FlexCAN register r/w APIs for
 big endian FlexCAN controllers.
Date: Fri, 10 Nov 2017 11:48:28 +0100
Message-ID: <839309ad-706e-15a2-426f-4f5c133ee14a@pengutronix.de>
References: <1510307990-15418-1-git-send-email-pankaj.bansal@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="o9Ke13QiIi4lbWXfCiRw4bX1XexMSRkHm"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:49945 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752503AbdKJKsi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 10 Nov 2017 05:48:38 -0500
In-Reply-To: <1510307990-15418-1-git-send-email-pankaj.bansal@nxp.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pankaj Bansal <pankaj.bansal@nxp.com>, wg@grandegger.com, linux-can@vger.kernel.org
Cc: V.Sethi@nxp.com, poonam.aggrwal@nxp.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--o9Ke13QiIi4lbWXfCiRw4bX1XexMSRkHm
Content-Type: multipart/mixed; boundary="juxHdanuGWO00tR72dfHeoGaLoDjhGa37";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Pankaj Bansal <pankaj.bansal@nxp.com>, wg@grandegger.com,
 linux-can@vger.kernel.org
Cc: V.Sethi@nxp.com, poonam.aggrwal@nxp.com
Message-ID: <839309ad-706e-15a2-426f-4f5c133ee14a@pengutronix.de>
Subject: Re: [PATCH 1/2] can: flexcan: Remodel FlexCAN register r/w APIs for
 big endian FlexCAN controllers.
References: <1510307990-15418-1-git-send-email-pankaj.bansal@nxp.com>
In-Reply-To: <1510307990-15418-1-git-send-email-pankaj.bansal@nxp.com>

--juxHdanuGWO00tR72dfHeoGaLoDjhGa37
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 11/10/2017 10:59 AM, Pankaj Bansal wrote:
> The FlexCAN driver assumed that FlexCAN controller is big endian for
> powerpc architecture and little endian for other architectures.
>=20
> But this may not be the case. FlexCAN controller can be little or
> big endian on any architecture. For e.g. NXP LS1021A ARM based SOC
> has big endian FlexCAN controller.
>=20
> Therefore, the driver has been modified to add a provision for both
> types of controllers using an additional device tree property. Big
> Endian controllers should have "big-endian" set in the device tree.
>=20
> Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
> Signed-off-by: Sakar Arora <Sakar.Arora@freescale.com>
> Reviewed-by: Zhengxiong Jin <Jason.Jin@freescale.com>
> Reviewed-by: Poonam Aggrwal <poonam.aggrwal@nxp.com>

Can you fix the email addresses of sakar.arora and bhupesh.sharma? They
are not deliverable any more.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--juxHdanuGWO00tR72dfHeoGaLoDjhGa37--

--o9Ke13QiIi4lbWXfCiRw4bX1XexMSRkHm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAloFg/wACgkQHv7KIOw4
HPYw4wf9GC4v9qX1Ex/jTivJCwYE71qZpKs8JUNrglKda3e1LKoZ/O1uvlotojPA
ctHIQFW8Ob5t9ymIMbzQP2kosVtpoCOTWvh7UbxNJ+etxfW64IulselJPLxvl83m
6NzkYSU3w0KXm96KSfif6zsvJZydzFB9xTATorLHJwHypkRi9QdkcmgfrIZOEsro
lx+GlfVU8iLpYeoTORS7YIPG5pfG9sY5lG48kfb2V/krcXRFI2gk5V2HkHRX3tZw
KqAsNef++sisn6KWtVSTe48VOMrtPCDxnbdP2Hk53yKx4zAZlbamN+YrYOVJ6azo
PyQSjS17BeAokI+/dSaJkmMe2HISjA==
=VTf3
-----END PGP SIGNATURE-----

--o9Ke13QiIi4lbWXfCiRw4bX1XexMSRkHm--
