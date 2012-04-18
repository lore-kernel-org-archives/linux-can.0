From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: read() question from newbie
Date: Wed, 18 Apr 2012 22:59:00 +0200
Message-ID: <4F8F2B14.7060207@pengutronix.de>
References: <CABHoAvngDnUfh6w7NXQksrmeLq52_cRp809rFZ+HriwYpZqo9w@mail.gmail.com> <CABHoAvmTvVfVKfwiZdf_=htKHYa554wpcPCRoEFujqwnxp9tkg@mail.gmail.com> <4F51DEF0.9060501@hartkopp.net> <CABHoAvmiu2JY70zJ8K20n8b=ahCDe8owRRWaSLMJoTd36ub7iw@mail.gmail.com> <4F553BDA.8060106@hartkopp.net> <4F553CA5.8080704@hartkopp.net> <CABHoAv=WuK0WZWNyi7jgBTNUbHub8AuGtPzbjL4dYaQ1ZGpu_g@mail.gmail.com> <4F56701E.3020104@hartkopp.net> <CABHoAv=FhULnAY+a2CbNjdyEEOoBKdEAezL7NQLo+PdfeyRTow@mail.gmail.com> <4F8D08D2.3090701@hartkopp.net> <CABHoAvmwCbAUfNBocHiUOHypN1uHMi9BrSREG-Yt=K=i3Wfn_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig383EF12CCF5D9E73687A1D77"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52425 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260Ab2DRU7P (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 18 Apr 2012 16:59:15 -0400
In-Reply-To: <CABHoAvmwCbAUfNBocHiUOHypN1uHMi9BrSREG-Yt=K=i3Wfn_w@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Economides <mecono@gmail.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig383EF12CCF5D9E73687A1D77
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 04/18/2012 10:13 PM, Michael Economides wrote:
> Hi Oliver,
>=20
> Looking on my scope, it does seem like the baudrate is a little off.
>=20
> Here are the commands I use to set up my CAN interface on my Linux boar=
d:
>=20
> insmod -m candev;
> insmod -m mscan-mpc52xx;
> insmod -m can;
> insmod -m can-raw
> ifconfig can0 up;

With mainline it's not possible to ifup an interface without setting the
bitrate first.

> ./cantest can0 baud 1000000;
>=20
> This "cantest" program uses:
>=20
>  ifr.ifr_ifru.ifru_ivalue =3D baudrate;
> ret =3D ioctl(s, SIOCSCANBAUDRATE, &ifr);
>=20
> to set the baudrate.  But it seems from reading other discussions,
> that this is not the correct way to set baud rate.

This ioctl isn't supported anymore, as Wolfgang pointed out you're
probably not using a mainline socketcan.

> I am using the MPC5121 from Freescale, in case that is relevant.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig383EF12CCF5D9E73687A1D77
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+PKxcACgkQjTAFq1RaXHM6wwCfZfIJxFn4CduZeimMBH495j29
fhQAn0WabaFfHnRv48S6CcBvzhjamdMb
=G5+q
-----END PGP SIGNATURE-----

--------------enig383EF12CCF5D9E73687A1D77--
