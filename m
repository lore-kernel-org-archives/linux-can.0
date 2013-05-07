From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: iproute2 and libsocketcan
Date: Tue, 07 May 2013 14:28:53 +0200
Message-ID: <5188F385.5010201@pengutronix.de>
References: <CANdmM3NkwHASR0LGLqpG3VHCj6z5TEyneXeDJ7K8h=p7bE032g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2IIAFUEVLBGQEXVRTOBSV"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46977 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757931Ab3EGM27 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 7 May 2013 08:28:59 -0400
In-Reply-To: <CANdmM3NkwHASR0LGLqpG3VHCj6z5TEyneXeDJ7K8h=p7bE032g@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: kedari appana <kedare06@gmail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2IIAFUEVLBGQEXVRTOBSV
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 05/07/2013 02:12 PM, kedari appana wrote:
>  I compiled can utilities and
>>     > iproute2 and libsocketcan utilities.But when i try to use  any o=
ne of
>>     > the below commands i am getting below errors.
>>     >  ip link set can0 type can bitrate 50000 triple-sampling on
>>     > ip: either "dev" is duplicate, or "type" is garbage
>>     >  canconfig can0 bitrate 50000 ctrlmode triple-sampling on
>>     > -sh: canconfig: not found

You have to copy the compiled tools (ip from iproute2, canconfig and
libsocketcan.so) to your root file system if you want to use them. What
you have to do depends on your build environment, look at the
documentation or contact the support of the build system supplier.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2IIAFUEVLBGQEXVRTOBSV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlGI84gACgkQjTAFq1RaXHPcIACfY7GklR+7kkQ6wv0HDlacvdWY
ye4An1mNoIvJ9FYeJtMc3DogC1fyA7B8
=+XQw
-----END PGP SIGNATURE-----

------enig2IIAFUEVLBGQEXVRTOBSV--
