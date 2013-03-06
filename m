From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Informations About CAN API of the Linux Kernel
Date: Wed, 06 Mar 2013 16:42:04 +0100
Message-ID: <513763CC.1070507@pengutronix.de>
References: <2B7D120CFC15DC438D721B998AD9D9E9097105AB@SEGOTNC5180-N2.vcn.ds.volvo.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2TQFAFHPILWRMPLQFANCL"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55798 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887Ab3CFPmK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 6 Mar 2013 10:42:10 -0500
In-Reply-To: <2B7D120CFC15DC438D721B998AD9D9E9097105AB@SEGOTNC5180-N2.vcn.ds.volvo.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Sako Youssouf <youssouf.sako@renault-trucks.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Kurt Van Dijck <kurt.van.dijck@eia.be>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2TQFAFHPILWRMPLQFANCL
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03/06/2013 03:51 PM, Sako Youssouf wrote:
> I'm an engineer of a French company, Renault Trucks Defense. We are=20
> Militaries cars makers. We are currently testing the CAN API of=20
> Linux. I found your article "SocketCAN - The official CAN API of the=20
> Linux kernel" on internet and after reading it I have some=20
> questions.

Please use the linux-can mailinglist (Cc'ed), however no HTML mails are
allowed on that list.

> About CAN frame reception:
>=20
> 1.       In a case of a controller with a single receive buffer . if=20
> a new CAN frame arrives and the previous one has not yet been=20
> treated, what happens? is the previous one is just lost? Or the=20
> kernel has a way to handle that situation.

In linux-can we make use of the Linux networking driver model. This
means if a frame is received from the hardware, it read from the receive
buffer by the driver as soon as possible and pushed into the Linux
networking stack. If the driver fails to do so, the frame of course is lo=
st.

However there is a queue between you application and the kernel, so that
several CAN frames can be on-the-fly between the driver and your
application.

> 2.       In a case of a hardware with a large RX FIFO,  when we call=20
> the read function on userspace program, is it possible to know how=20
> many frames are available on the RX queue?

There's no way to figure out the number of frames in the RX queue of the
hardware. It might be possible to figure out the number of frames in the
software queue between the kernel and your application. What's your
usecae? What do you want to do with that information?

> And a last question, do you have information about when the Linux
> API for SAE J1939 will be available?

Kurt (Cc'ed) can probably comment on this.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |




------enig2TQFAFHPILWRMPLQFANCL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlE3Y8wACgkQjTAFq1RaXHOkxgCeJQDDXc+K8E3dPPku8SpNPZI1
FRoAn0jlwuQc8QtE3QcOZw0rlJvJ5zcf
=jXkb
-----END PGP SIGNATURE-----

------enig2TQFAFHPILWRMPLQFANCL--
