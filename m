From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [Socketcan-users] socketcan
Date: Fri, 26 Apr 2013 16:21:35 +0200
Message-ID: <517A8D6F.90400@pengutronix.de>
References: <CANdmM3PoMSQeo19m0W-XEtQ8MXhW9RTv1ZUKdFzQ-MgMzwbUsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2QPPARVBIWGWOAFPPSRUD"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54515 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057Ab3DZOVh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 26 Apr 2013 10:21:37 -0400
In-Reply-To: <CANdmM3PoMSQeo19m0W-XEtQ8MXhW9RTv1ZUKdFzQ-MgMzwbUsQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: kedari appana <kedare06@gmail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2QPPARVBIWGWOAFPPSRUD
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hello kedari appana,

please use the linux-can mailing list (Cc'ed) as the old berlios list is
obsolete.

On 04/26/2013 03:03 PM, kedari appana wrote:
> I am new to socketcan and i write a socketcan driver based on the
> standard can drivers now i want to compile that driver how to compile

Add your driver to your linux kernel under:

    drivers/net/can/

and add an option to

    drivers/net/can/Kconfig
    drivers/net/can/Makefile

follow an existing driver like e.g. flexcan [1][2].

> it and please help me how to write user space applications and how to
> test my hardware so that  my driver code is correct .please help me
> regarding this issue

There are existing userspace applications, e.g. the can-utils, which can
be downlaoded at gitorious.org [3]. Use cansend and candump to send and
receive can messages. Use "ip" of the iproute2 package to configure the
bitrate of your can interface[4]. See that document for more information
about CAN under Linux.

hth,
Marc

[1] http://lxr.free-electrons.com/source/drivers/net/can/Kconfig#L99
[2] http://lxr.free-electrons.com/source/drivers/net/can/Makefile#L23
[3] https://gitorious.org/linux-can/can-utils
[4]
http://lxr.free-electrons.com/source/Documentation/networking/can.txt#L85=
4
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |




------enig2QPPARVBIWGWOAFPPSRUD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlF6jW8ACgkQjTAFq1RaXHOgrACeOVeLAHeVJ6We2NoRXizhQqSV
JWEAnipfnGhbMl8xGA70CuAHdNOJqKmm
=SVCc
-----END PGP SIGNATURE-----

------enig2QPPARVBIWGWOAFPPSRUD--
