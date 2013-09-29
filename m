From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: adding can4linux to drivers/char
Date: Sun, 29 Sep 2013 20:44:40 +0200
Message-ID: <52487518.80008@pengutronix.de>
References: <1881932.U1kQQJkqCz@heinz.site> <523DF9C1.30300@grandegger.com> <2109885.0l6dWmo4a5@heinz.site> <CADGMhsXTbEc5ifQEbNM=dS3OP6uwGrvGfZ3OCvWJ=aXJyzGs+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="nLJPT9BbvNMVr018HPJ4CVtsaIElFueUd"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48369 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755099Ab3I2Sor (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 29 Sep 2013 14:44:47 -0400
In-Reply-To: <CADGMhsXTbEc5ifQEbNM=dS3OP6uwGrvGfZ3OCvWJ=aXJyzGs+A@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Sebastian Haas <dev@sebastianhaas.info>
Cc: =?UTF-8?B?SGVpbnotSsO8cmdlbiBPZXJ0ZWw=?= <hj.oertel@t-online.de>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nLJPT9BbvNMVr018HPJ4CVtsaIElFueUd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/29/2013 07:45 PM, Sebastian Haas wrote:
> I think Heinz-J=C3=BCrgens' arguments are not that wrong. There are a b=
unch
> of example in the kernel of concurring solution for the same issues
> every single one with different advantages and disadvantages (just
> compare how many solution for virtualization are available kvm, xen,
> paravirt, ...).

You're right.

> There must be space in kernel for the classical chardev CAN-approach.
> Sharing common code to access the different controllers must be
> possible.

That's already implemented in the Kernel, it's called a driver.

> I think there are a bunch of use cases out there which are easier and
> more efficiently solved with a simple chardev API. A simple chardev
> CAN driver like can4linux provide doesn't depend on the whole
> networking subsystem which may be imported of real embedded systems
> with strong memory constraints (less memory footprint, smaller
> kernel).

The smallest system we're running Linux is a Cortex M3, it's on chip RAM
is to small for Kernel + Userspace, so you need an external RAM chip
anyways.

> The Socket approach has some real advantages (multi-user for single
> CAN controller, iptables filtering, netutil integration, buffering,
> ..), but many of them may be considered as disadvantages as well (no
> control of the message flow in terms of timing and ordering, no

You you have ordering problem? That's a bug? Which driver/hardware?

> exclusive use of the interface, networking dependency). Implementing
> an automatic bitrate detection or application driver busoff recovery
> is a pain in the ass with SocketCAN.

If there is a need for bitrate detection, feel free request it here. I
think there are some controllers that support this in hardware, while
others don't. Is there a known working algorithm for bitrate detection?
How can we make busoff recovery better? What's the most annoying point?

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--nLJPT9BbvNMVr018HPJ4CVtsaIElFueUd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlJIdRgACgkQjTAFq1RaXHNjKQCfYhlOcDofma7NI9cXI+A6wB8e
FrgAoIgQgw1YIL6Qt17jXJAqhIKiz473
=8C6/
-----END PGP SIGNATURE-----

--nLJPT9BbvNMVr018HPJ4CVtsaIElFueUd--
