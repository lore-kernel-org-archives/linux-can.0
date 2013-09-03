From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: real-time transmission?
Date: Tue, 03 Sep 2013 16:59:51 +0200
Message-ID: <5225F967.9060106@pengutronix.de>
References: <11071630B606A2488DE633430B530FDE57F06BEE@ELS-EX01-PV.KSTG.corp> <5225F8A5.4060207@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Mu5Fi0fDeB2c8woEdXOhQrQHojKiVWGuT"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59156 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753664Ab3ICO7w (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 3 Sep 2013 10:59:52 -0400
In-Reply-To: <5225F8A5.4060207@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Aiken, Scott" <Scott.Aiken@karlstorz.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Mu5Fi0fDeB2c8woEdXOhQrQHojKiVWGuT
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/03/2013 04:56 PM, Marc Kleine-Budde wrote:
>> I=E2=80=99m porting an old implementation of CAL/CiA to Linux.  The de=
vice
>> connection protocol has some pretty tight timing.  I=E2=80=99ve observ=
ed that
>> some CAN packets are buffered for 500 ms between the socket write() ca=
ll
>> and the actual transmission of the packet.  This is enough to sabotage=

>> the connection process, and possibly take out other devices as well.=20
>> Are there any socket options to disable buffering of write packets, an=
d
>> send them when write() is called?=20

Depends who introduces that big delay. If you're sending too much CAN
traffic on your system you can use traffic shaping to prioritize your
communication. It there are other interrupts in the system you may want
to use PREEMPT_RT and play with the interrupt and net-rx/tx softirq
priorities.

I think the first step should be measurements to figure out who
introduces the delay.

Regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Mu5Fi0fDeB2c8woEdXOhQrQHojKiVWGuT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlIl+WcACgkQjTAFq1RaXHPkxwCfXw5S64DzHWThsX2LWn25hru6
+IwAnjlLBCJHMmeWNV9+RfpdPPDj+y7f
=Gk50
-----END PGP SIGNATURE-----

--Mu5Fi0fDeB2c8woEdXOhQrQHojKiVWGuT--
