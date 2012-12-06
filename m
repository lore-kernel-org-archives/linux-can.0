From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: CAN Driver
Date: Thu, 06 Dec 2012 10:02:37 +0100
Message-ID: <50C05F2D.8060903@pengutronix.de>
References: <1346761707.5009.4.camel@punsfloyd-desktop>  <5045F53F.7070209@pengutronix.de> <1354779353.5010.2.camel@punsfloyd-desktop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig20B40E2196216EF1931739C6"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56269 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932139Ab2LFJCw (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Dec 2012 04:02:52 -0500
In-Reply-To: <1354779353.5010.2.camel@punsfloyd-desktop>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: puneet.sharma@moschip.com, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig20B40E2196216EF1931739C6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,

I've put the linux-can mailinglist on Cc.

On 12/06/2012 08:35 AM, Puneet Sharma wrote:
> Can you guide me how to implement system wide per CAN device
> filterting in driver code.

Here is my old mail with some thoughts:

=46rom my point of view it should become a per device callback, which you=

(admin, i.e. the root user) can set when the device is down. You have to
extend the CAN netlink interface [1].

Each device should identify what kind and how many hardware filters it
supports:
a) mask+id
b) just id
c) ...
Analogue to ctrlmode [2][3].

The requested filers are transferred into the kernel via netlink, but
you have to figure out how to encode a variable length list (netfilter
has probably a solution for this). Then the code in can_changelink() [4]
should check if the transferred filter is supported on that hardware.
Then, during open the driver should code the filters into hardware, on
at91 it should be done in at91_setup_mailboxes [5][6].

Marc

[1] http://lxr.free-electrons.com/source/drivers/net/can/dev.c#L585
[2] http://lxr.free-electrons.com/source/include/linux/can/netlink.h#L81
[3] http://lxr.free-electrons.com/source/drivers/net/can/dev.c#L724
[4] http://lxr.free-electrons.com/source/drivers/net/can/dev.c#L633
[5] http://lxr.free-electrons.com/source/drivers/net/can/at91_can.c#L418
[6] http://lxr.free-electrons.com/source/drivers/net/can/at91_can.c#L336

> We also want to test CAN controller in u-boot. Can you help me out to
> write some test cases which can test the CAN controller on a basic
> level.

If you just want to do testing, I suggest, don't do it in u-boot. I
think it's more complicated to port a CAN driver to u-boot, than to boot
linux and do the tests there.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig20B40E2196216EF1931739C6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlDAXzcACgkQjTAFq1RaXHPsSACfTod9iNtfpsqP1WcI7n/oCTQ2
ZYEAn2uFoUUezJpcU9EL9qxeN8vhfFRL
=UFEd
-----END PGP SIGNATURE-----

--------------enig20B40E2196216EF1931739C6--
