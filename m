From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: mcp251x can't drop the can0 Interface
Date: Mon, 10 Feb 2014 23:34:45 +0100
Message-ID: <52F95405.9050404@pengutronix.de>
References: <20140207201236.GB28637@griso.site> <52F66505.6090303@pengutronix.de> <20140210222543.GA28211@griso.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="FKwaT5bvcN65Sl3fXPAHjGR9pQ7xGaPOM"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40536 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890AbaBJWev (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 10 Feb 2014 17:34:51 -0500
In-Reply-To: <20140210222543.GA28211@griso.site>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: John Whitmore <arigead@gmail.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FKwaT5bvcN65Sl3fXPAHjGR9pQ7xGaPOM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 02/10/2014 11:28 PM, John Whitmore wrote:
> Sorry for the slight delay went from the RaspberryPi 3.6 Kernel to the =
3.10 to
> see if maybe the later version worked. I'm afraid neither worked.

Your "ifplugd" is meesing around with the CAN interface.

> [   86.044493] CPU: 0 PID: 1713 Comm: ifplugd Not tainted 3.10.29-can+ =
#2
> [   86.044583] [<c0013aa4>] (unwind_backtrace+0x0/0xf0) from [<c0010e00=
>] (show_stack+0x10/0x14)
> [   86.044642] [<c0010e00>] (show_stack+0x10/0x14) from [<bf00ddd4>] (m=
cp251x_open+0x18/0x1d0 [mcp251x])
> [   86.044694] [<bf00ddd4>] (mcp251x_open+0x18/0x1d0 [mcp251x]) from [<=
c0327544>] (__dev_open+0xd4/0x144)
> [   86.044728] [<c0327544>] (__dev_open+0xd4/0x144) from [<c0327788>] (=
__dev_change_flags+0x88/0x130)
> [   86.044756] [<c0327788>] (__dev_change_flags+0x88/0x130) from [<c032=
789c>] (dev_change_flags+0x10/0x48)
> [   86.044795] [<c032789c>] (dev_change_flags+0x10/0x48) from [<c0381ba=
0>] (devinet_ioctl+0x630/0x6f8)
> [   86.044839] [<c0381ba0>] (devinet_ioctl+0x630/0x6f8) from [<c031195c=
>] (sock_ioctl+0x70/0x298)
> [   86.044882] [<c031195c>] (sock_ioctl+0x70/0x298) from [<c00dc174>] (=
do_vfs_ioctl+0x7c/0x5c4)
> [   86.044913] [<c00dc174>] (do_vfs_ioctl+0x7c/0x5c4) from [<c00dc6f4>]=
 (SyS_ioctl+0x38/0x60)
> [   86.044947] [<c00dc6f4>] (SyS_ioctl+0x38/0x60) from [<c000db40>] (re=
t_fast_syscall+0x0/0x30)

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--FKwaT5bvcN65Sl3fXPAHjGR9pQ7xGaPOM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlL5VAUACgkQjTAFq1RaXHNjJACfXVU9Yy/RGVGKD6F54049pjWe
uGgAn2cZMH4jgxywZaOne/oIk7/cajC4
=VX2w
-----END PGP SIGNATURE-----

--FKwaT5bvcN65Sl3fXPAHjGR9pQ7xGaPOM--
