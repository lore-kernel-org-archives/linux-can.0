From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Stuck vcan
Date: Tue, 11 Mar 2014 21:56:57 +0100
Message-ID: <531F7899.3010205@pengutronix.de>
References: <CANGgnMZLZ+Uhdjpw0QC1ER74FFyot6sjSpcL0Q+HK7ydQTynsg@mail.gmail.com>	<531EB5A4.1090302@hartkopp.net> <CANGgnMbtfaowdGjVRbQ9L8TJBKmbAaNxjApPsc=JDM7e28U8LA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="jVP3nkKp5shucu77iKQLjreViPL8DeQ7u"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34470 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754268AbaCKU5H (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 11 Mar 2014 16:57:07 -0400
In-Reply-To: <CANGgnMbtfaowdGjVRbQ9L8TJBKmbAaNxjApPsc=JDM7e28U8LA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Austin Schuh <austin@peloton-tech.com>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jVP3nkKp5shucu77iKQLjreViPL8DeQ7u
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 03/11/2014 09:37 PM, Austin Schuh wrote:
> I'm not trying to cause problems ;)

:D

> Neither of those helped.
>=20
> # ifconfig vcan0
> vcan0     Link encap:UNSPEC  HWaddr
> 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
>           UP RUNNING NOARP  MTU:16  Metric:1
>           RX packets:428406 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:428406 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:0
>           RX bytes:3427248 (3.2 MiB)  TX bytes:3427248 (3.2 MiB)
>=20
> # ip link show vcan0
> 17: vcan0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc noqueue state UNKNOWN
> mode DEFAULT
>     link/can
>=20
> # ifconfig vcan0
> vcan0     Link encap:UNSPEC  HWaddr
> 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
>           UP RUNNING NOARP  MTU:16  Metric:1
>           RX packets:1400094 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:1400094 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:10
>           RX bytes:11200752 (10.6 MiB)  TX bytes:11200752 (10.6 MiB)
>=20
> # ip link show vcan0
> 17: vcan0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc noqueue state UNKNOWN
> mode DEFAULT qlen 10
>     link/can
>=20
> Both times, I get the following.
>=20
> Mar 11 13:28:58 aschuh-peloton kernel: [96229.460901] Dead loop on
> virtual device vcan0, fix it urgently!
> Mar 11 13:28:59 aschuh-peloton kernel: [96230.313875] Dead loop on
> virtual device vcan0, fix it urgently!
> Mar 11 13:28:59 aschuh-peloton kernel: [96230.319494] Dead loop on
> virtual device vcan0, fix it urgently!
> Mar 11 13:29:00 aschuh-peloton kernel: [96231.072617] Dead loop on
> virtual device vcan0, fix it urgently!
>=20
> Luckily, it is easy to reproduce.  I have some trivial code which
> sends out 10,000 msgs/sec on the vcan.  I run 3+ copies of the code on
> a dual core machine with hyperthreads enabled.  More parallel sends
> should cause it to occur more frequently.

Can you share the code?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--jVP3nkKp5shucu77iKQLjreViPL8DeQ7u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlMfeJkACgkQjTAFq1RaXHPCZQCff+wq3be0yjJhLXwlMEfoQO7i
cbYAn2GnbCBz8Jn8JBbDN9taaHJGo0sR
=HpIx
-----END PGP SIGNATURE-----

--jVP3nkKp5shucu77iKQLjreViPL8DeQ7u--
