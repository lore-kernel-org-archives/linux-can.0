From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: About sysfs usage by socket-can drivers
Date: Thu, 23 Jul 2020 17:23:33 +0200
Message-ID: <f329322b-25e1-b53a-73ae-2f239e27e92f@pengutronix.de>
References: <VI1PR03MB5053B1FB7A45D4243BD1F095D6760@VI1PR03MB5053.eurprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="pPM7xB3qFbob8jAHCcwHPZ3ixRikNd5yF"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbgGWPXk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 23 Jul 2020 11:23:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFCDC0619DC
        for <linux-can@vger.kernel.org>; Thu, 23 Jul 2020 08:23:40 -0700 (PDT)
In-Reply-To: <VI1PR03MB5053B1FB7A45D4243BD1F095D6760@VI1PR03MB5053.eurprd03.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?Q?St=c3=a9phane_Grosjean?= <s.grosjean@peak-system.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pPM7xB3qFbob8jAHCcwHPZ3ixRikNd5yF
Content-Type: multipart/mixed; boundary="1ksVh48gfRP95YB0UnWvBXsPLMnTdrhIG";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?UTF-8?Q?St=c3=a9phane_Grosjean?= <s.grosjean@peak-system.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Message-ID: <f329322b-25e1-b53a-73ae-2f239e27e92f@pengutronix.de>
Subject: Re: About sysfs usage by socket-can drivers
References: <VI1PR03MB5053B1FB7A45D4243BD1F095D6760@VI1PR03MB5053.eurprd03.prod.outlook.com>
In-Reply-To: <VI1PR03MB5053B1FB7A45D4243BD1F095D6760@VI1PR03MB5053.eurprd03.prod.outlook.com>

--1ksVh48gfRP95YB0UnWvBXsPLMnTdrhIG
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 7/23/20 4:50 PM, St=C3=A9phane Grosjean wrote:
> We've several pending requests regarding:
> - changing the default clock value,

The input clock rate for the CAN IP Core?

> - reading the bus load value,

=2E.as calculated by the USB device?

> - using a flashed device id. to better control the can interface number=
,

Can you make use of dev_id/dev_port
https://elixir.bootlin.com/linux/latest/source/include/linux/netdevice.h#=
L1687

> - identifying the (USB) channel

Does udev offer all needed information? E.g.:

    udevadm test /sys/class/net/can0

> Adding attributes under /sys/class/net/canX (or into a specific/private=
 group) could be a solution.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--1ksVh48gfRP95YB0UnWvBXsPLMnTdrhIG--

--pPM7xB3qFbob8jAHCcwHPZ3ixRikNd5yF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAl8Zq3UACgkQqclaivrt
76mAqwf+IzLyk/cXtQs/Hb32bVjxS/7FY0oNMtuY53E5cVtNStXKpbvioSHE89Uz
Yj5rTfNKRvKBvM/SVYl1i7XrSfu85CG6LxNi0dm78gO/TlvkXEvFZ2q5OaW7P59W
sxhVVERgRfA2B6qYi17vsoJBJYxCi9O5IhCOoPIRQ2JHrynX5GSvC5vCfzUNpZqG
3FA6zlmeoSyeN6B+gTUSfbMHGEBx2mtc8fIpReJ7vV+j1c5RUDPTY1d2Pje2A6q+
aVzMwfVoASAdXz79cN0GhytBw5b+OoBFMqCWI2n8OjCXJ+rMy6szUZHE33Suthlg
S93Q+PFe0foWTogRGf3xV1ox/9gJSA==
=fgTu
-----END PGP SIGNATURE-----

--pPM7xB3qFbob8jAHCcwHPZ3ixRikNd5yF--
