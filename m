From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: WARNING in can_rcv
Date: Tue, 16 Jan 2018 19:07:46 +0100
Message-ID: <a48197ff-9270-8af7-a814-56af53093b3c@pengutronix.de>
References: <001a11c16b40d795350562e878cc@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="3jcJliiHDas2jApTjLZAJ24OLXrfls366"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35545 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbeAPSIO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 16 Jan 2018 13:08:14 -0500
In-Reply-To: <001a11c16b40d795350562e878cc@google.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: syzbot <syzbot+4386709c0c1284dca827@syzkaller.appspotmail.com>, davem@davemloft.net, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3jcJliiHDas2jApTjLZAJ24OLXrfls366
Content-Type: multipart/mixed; boundary="hoJXd0KgtsRR2rnrQhh4rBOcScsKsCVZk";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: syzbot <syzbot+4386709c0c1284dca827@syzkaller.appspotmail.com>,
 davem@davemloft.net, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
Message-ID: <a48197ff-9270-8af7-a814-56af53093b3c@pengutronix.de>
Subject: Re: WARNING in can_rcv
References: <001a11c16b40d795350562e878cc@google.com>
In-Reply-To: <001a11c16b40d795350562e878cc@google.com>

--hoJXd0KgtsRR2rnrQhh4rBOcScsKsCVZk
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 01/16/2018 06:58 PM, syzbot wrote:
> Hello,
>=20
> syzkaller hit the following crash on =20
> a8750ddca918032d6349adbf9a4b6555e7db20da
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/master=

> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached
> Raw console output is attached.
> C reproducer is attached
> syzkaller reproducer is attached. See https://goo.gl/kgGztJ
> for information about syzkaller reproducers
>=20
>=20
> IMPORTANT: if you fix the bug, please add the following tag to the comm=
it:
> Reported-by: syzbot+4386709c0c1284dca827@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for =20
> details.
> If you forward the report, please keep this part and the footer.
>=20
> device eql entered promiscuous mode
> ------------[ cut here ]------------
> PF_CAN: dropped non conform CAN skbuf: dev type 65534, len 42, datalen =
0
> WARNING: CPU: 0 PID: 3650 at net/can/af_can.c:729 can_rcv+0x1c5/0x200  =

> net/can/af_can.c:724
> Kernel panic - not syncing: panic_on_warn set ...

Invalid packages generate a warning (WARN_ONCE()), and you have
panic_on_warn active. Should we better silently drop these CAN packages?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--hoJXd0KgtsRR2rnrQhh4rBOcScsKsCVZk--

--3jcJliiHDas2jApTjLZAJ24OLXrfls366
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlpeP3IACgkQHv7KIOw4
HPaYjggAqDJGD9BukUtf1dVA89P7I1wi5ZaeEwwU2dU1XYYG77doZ4DLOQtF5Qa3
6qcTXepSpzOL6DecMbK+V4Pa3mAWUVbgZr5EFB8AzpGW92QBUoINH6qsU8/zQjHa
T9zIRUekzJM0MOX+rlwvBrdq5iGlSrSUplzid2DSqrGT8+nSJdwHRdyRbrfvAseZ
Eq8NSohKe9kKNq3IYwLiw7stjEJ2v3lVBxuZ9NsezDRE5MoCcb2b/M46bMa3JZRt
/j1dCjP9WkpxgpVHbyxrigflrzIGSFTpm9BSJaXnEmguolhkDbhA6XGvkeSY0M5r
DZh3J1Pmeug8D8J3+nAyraMZAhU4Kw==
=+sBq
-----END PGP SIGNATURE-----

--3jcJliiHDas2jApTjLZAJ24OLXrfls366--
