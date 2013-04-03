From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Fwd: Loosing CAN messages with socket-CAN
Date: Wed, 03 Apr 2013 17:17:13 +0200
Message-ID: <515C47F9.20708@pengutronix.de>
References: <OFFDCA8F9E.6364F5F1-ONC1257B42.00342754-C1257B42.003887D3@de.abb.com> <515C064F.2060503@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2KNKOOJIHHJDUHVXCXNAJ"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54980 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760462Ab3DCPRQ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 3 Apr 2013 11:17:16 -0400
In-Reply-To: <515C064F.2060503@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Jeroen Lammertink <jeroen.lammertink@nl.abb.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2KNKOOJIHHJDUHVXCXNAJ
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 04/03/2013 12:37 PM, Marc Kleine-Budde wrote:
> We are sending batches of 80 CAN messages using socket CAN to transfer =
an
> image for download. After the 80 messages we wait for a response

Are you evaluating the return value of the write() or sendmsg() systemcal=
l?

> consisting of a single CAN message. Within the messages we have coded a=

> sequence number, so that we can detect lost messages. Besides the CAN
> device that is subject of download, we have also a (hardware) CAN sniff=
er
> on the CAN bus. We typically log CAN messages when we put them in the
> socket. With this set-up we typically detect loosing a short series of
> (mostly 5) CAN messages, somewhere halfway the batch of 80. No other
> devices are present on the CAN bus.
>=20
> I've dumped below some version and set-up info of Ubuntu, socket-can an=
d
> ifconfig.
>=20
> Is this problem known?
> May this problem be related to using an old version of socket can?

This is either a userspace problem or a buggy driver. The driver problem
may have been fixed in the meantime.

> How can I upgrade Ubuntu to the latest versions of socket-can?

First we have to figure out what's brokoen.

> Thanks in advance,
>=20
> Jeroen Lammertink
>=20
>=20
> bmterra@q7buntu:~/user/jla$ uname -a
> Linux q7buntu 3.5.0-26-generic #42~precise1-Ubuntu SMP Mon Mar 11 22:19=
:42
> UTC 2013 i686 i686 i386 GNU/Linux
> bmterra@q7buntu:~/user/jla$ cat /proc/net/can/version
> rev 20090105 abi 8
> bmterra@q7buntu:~/user/jla$ ifconfig can0
> can0      Link encap:UNSPEC  HWaddr
> 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
>           UP RUNNING NOARP  MTU:16  Metric:1
>           RX packets:1128 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:4400 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:1024
>           RX bytes:9024 (9.0 KB)  TX bytes:34176 (34.1 KB)
>           Interrupt:18

Which CAN hardware are you using?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2KNKOOJIHHJDUHVXCXNAJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlFcR/oACgkQjTAFq1RaXHNu6wCbBp05l7aRQPrkGgMXc9wfK791
LLEAniRvstbwfSRfa7ekkSthvbDzypEA
=fh1B
-----END PGP SIGNATURE-----

------enig2KNKOOJIHHJDUHVXCXNAJ--
