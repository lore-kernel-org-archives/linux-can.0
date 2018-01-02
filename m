From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v6 1/6] can: dev: Add support for limiting configured
 bitrate
Date: Tue, 2 Jan 2018 17:15:57 +0100
Message-ID: <8d973da8-df40-e37e-377f-50666db382fe@pengutronix.de>
References: <1513949488-13026-1-git-send-email-faiz_abbas@ti.com>
 <1513949488-13026-2-git-send-email-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="1gfRHrEAPVF2DlVztWY0ZNDXwHqjpbCIq"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:51959 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750945AbeABQQT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 2 Jan 2018 11:16:19 -0500
In-Reply-To: <1513949488-13026-2-git-send-email-faiz_abbas@ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Faiz Abbas <faiz_abbas@ti.com>, wg@grandegger.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, fcooper@ti.com, robh@kernel.org, Wenyou.Yang@microchip.com, sergei.shtylyov@cogentembedded.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1gfRHrEAPVF2DlVztWY0ZNDXwHqjpbCIq
Content-Type: multipart/mixed; boundary="dFnOBra85TLH5uMqywCjrc5oBMrdKMIuM";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Faiz Abbas <faiz_abbas@ti.com>, wg@grandegger.com, robh+dt@kernel.org,
 mark.rutland@arm.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com,
 fcooper@ti.com, robh@kernel.org, Wenyou.Yang@microchip.com,
 sergei.shtylyov@cogentembedded.com
Message-ID: <8d973da8-df40-e37e-377f-50666db382fe@pengutronix.de>
Subject: Re: [PATCH v6 1/6] can: dev: Add support for limiting configured
 bitrate
References: <1513949488-13026-1-git-send-email-faiz_abbas@ti.com>
 <1513949488-13026-2-git-send-email-faiz_abbas@ti.com>
In-Reply-To: <1513949488-13026-2-git-send-email-faiz_abbas@ti.com>

--dFnOBra85TLH5uMqywCjrc5oBMrdKMIuM
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 12/22/2017 02:31 PM, Faiz Abbas wrote:
> From: Franklin S Cooper Jr <fcooper@ti.com>
>=20
> Various CAN or CAN-FD IP may be able to run at a faster rate than
> what the transceiver the CAN node is connected to. This can lead to
> unexpected errors. However, CAN transceivers typically have fixed
> limitations and provide no means to discover these limitations at
> runtime. Therefore, add support for a can-transceiver node that
> can be reused by other CAN peripheral drivers to determine for both
> CAN and CAN-FD what the max bitrate that can be used. If the user
> tries to configure CAN to pass these maximum bitrates it will throw
> an error.

Please add support to read the maximum bitrate via netlink. Have a look
at 12a6075cabc0 ("can: dev: add CAN interface termination API"). I think
you need to extend the following functions: can_get_size() and
can_fill_info().

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--dFnOBra85TLH5uMqywCjrc5oBMrdKMIuM--

--1gfRHrEAPVF2DlVztWY0ZNDXwHqjpbCIq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlpLsD0ACgkQHv7KIOw4
HPbBjAf/bOJRFYHJIk88I58vTH20FS36dHkmYNPjJoQ2gqI5/QK446crK9Rw2Dwi
t467KHEcDx3gThkGjcWNr2s2eu+e61wIFbOwS8epegEeUFRFdaG3VPPFK4Z8rvbl
cGJZ68ZPXBA0MdnJqE5tXvCadmIsikDbfh0NQtRd1Egv/9L8R42gqkFfHrsq5xs/
e7ZTLbI24+eOGRldyh/JMEGkGGIctrkd1iHNo3OfV3U+aLnJBvQCnQx5rPdUf0Gm
27nyaZqZZgTx8925iOEhA1/h/o/gRaQS4HpSm8lJNw0UMuRPAy3WPW+/N5PE7vRK
3D0/P+Bt1CVGKJSmaXNr4FjnHgHATw==
=OkNx
-----END PGP SIGNATURE-----

--1gfRHrEAPVF2DlVztWY0ZNDXwHqjpbCIq--
