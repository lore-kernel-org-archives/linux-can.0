From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: socketcan Features
Date: Mon, 25 Jan 2016 16:59:32 +0100
Message-ID: <56A64664.80104@pengutronix.de>
References: <897E6F50-B05B-458C-A172-A6C01A9C3D76@microcontrol.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="riQgWG6wIU1PKacXIU5STmiLvx4QF61Xk"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:46829 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932948AbcAYP7l (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 25 Jan 2016 10:59:41 -0500
In-Reply-To: <897E6F50-B05B-458C-A172-A6C01A9C3D76@microcontrol.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>
Cc: Uwe Koppe <koppe@microcontrol.net>, Robert Schwebel <r.schwebel@pengutronix.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--riQgWG6wIU1PKacXIU5STmiLvx4QF61Xk
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

some German questions, I'll answer here as these are quite interesting.

On 01/21/2016 12:05 PM, Uwe Koppe wrote:
> 1. Root Rechte
>=20
> Wie kann man es erreichen, dass f=C3=BCr die Konfiguration der CAN
> Schnittstelle (Bitrate, Up, Down, etc) keine Root
> Rechte erforderlich sind?

Q: Is it possible to configure the CAN interface without root permissions=
?

A: The capability CAP_NET_ADMIN should be sufficient. If not please
complain and/or send patches :)

> 2. Interrupts
>=20
> Durch den Treiber werden CAN Error Interrupts =E2=80=9Eweitergereicht=E2=
=80=9C, die
> in einigen Use-Cases das System langsam bis hin zu unbedienbar
> machen. Wie lassen sich CAN Interrupts konfigurieren ohne dass ich
> die Treiber anpassen muss?

Q: Driver pass CAN error interrupts to the userspace. On some systems
this leads to unresponsive systems.

A: You are probably using a flexcan IP core. On some SoCs the warning
interrupt is not attached to the interrupt controller. As a workaround
the error interrupts are enabled, which makes detection of the warning
interrupt possible again.

Another reason for bus errors reported to your application is tht you
have enabled bus error detection. If you need this, but don't want to be
flooded by them there's the feature called bus error limiting support
[1]. It's not mainline yet, but feedback is welcome.

regards,
Marc

[1] berr_limit support:
https://marc.info/?l=3Dlinux-can&m=3D138115684802850&w=3D2
https://marc.info/?l=3Dlinux-can&m=3D138115684802849&w=3D2
https://marc.info/?l=3Dlinux-can&m=3D138115684902851&w=3D2

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--riQgWG6wIU1PKacXIU5STmiLvx4QF61Xk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWpkZkAAoJEP5prqPJtc/Hii8H/jNG2aWN8XgFQ5SXPx4PF34k
KgBFNCRgSBcG3Xtq5yXYxT1KGSkWcDjk2vqIKFvOl8Qjz1iuyyQgQNSGC4sC4z+J
XLLc0KE1FMEXc6HNqEdECAi/cRjQ8+qe4CbQgXgUTuSIUkwQIF1peaQLARjeUIc1
crK44Wom0NgZIXoApmTUqfou0V38XXaehtiposGJkifjn6hY+c78D+L7R4KHWWUm
Jun6cFi82T92P3JnztMxptm5OuJNVVuXWMzqcwyb0v3FPgyf7lrVInRGurXE4wlv
FqoaTp9wJDLirPJUtGZXKQqndZxJuEGAta+/hm/4nS1S0CgK/Wxi8CofljLPRHA=
=utIK
-----END PGP SIGNATURE-----

--riQgWG6wIU1PKacXIU5STmiLvx4QF61Xk--
