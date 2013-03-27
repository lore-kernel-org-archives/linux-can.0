From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: drivers/net/can/sja1000/peak_pcmcia.c:626:2: error: implicit
 declaration of function 'ioport_unmap'
Date: Wed, 27 Mar 2013 11:24:43 +0100
Message-ID: <5152C8EB.9090703@pengutronix.de>
References: <5152a96f.mjO7hZyAZ4CJtDg3%fengguang.wu@intel.com> <20130327083110.GB11489@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2OAIFHCRICSWWGTMSKNMI"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50921 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992Ab3C0Lng (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 27 Mar 2013 07:43:36 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:6f8:1178:4:5054:ff:fe8d:eefb] helo=bjornoya.do.blackshift.org)
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <mkl@pengutronix.de>)
	id 1UKolT-0008Vn-Mo
	for linux-can@vger.kernel.org; Wed, 27 Mar 2013 12:43:35 +0100
Received: from [172.17.34.65] (unknown [172.17.34.65])
	(using TLSv1 with cipher ECDHE-ECDSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: frogger)
	by bjornoya.do.blackshift.org (Postfix) with ESMTPSA id 6C1135E891
	for <linux-can@vger.kernel.org>; Wed, 27 Mar 2013 12:43:35 +0100 (CET)
In-Reply-To: <20130327083110.GB11489@localhost>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: Stephane Grosjean <s.grosjean@peak-system.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2OAIFHCRICSWWGTMSKNMI
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03/27/2013 09:31 AM, Fengguang Wu wrote:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux ma=
ster
> head:   de55eb1d60d2ed0f1ba5e13226d91b3bfbe1c108
> commit: 2b61972b74219d21ef1e91178349bdb840357688 can: sja1000: add supp=
ort for PEAK-System PCMCIA card
> date:   1 year, 1 month ago
> config: make ARCH=3Dsh allyesconfig
>=20
> All error/warnings:
>=20
>    In file included from drivers/net/can/sja1000/peak_pcmcia.c:28:0:
>    drivers/net/can/sja1000/sja1000.h:59:0: warning: "REG_SR" redefined =
[enabled by default]
>    arch/sh/include/asm/ptrace_32.h:25:0: note: this is the location of =
the previous definition

Another problem, a define conflict, due to missing namespace. I'm adding
a SJA1000_ to the sja1000 defines. I'll prepare a patch soon.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2OAIFHCRICSWWGTMSKNMI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlFSyOsACgkQjTAFq1RaXHPhcwCfUjGtVRYqJN4Oi09hDLeN8W+2
o4MAn2VDujNBIvhQkBjBYN9BvcMKRQju
=HXeF
-----END PGP SIGNATURE-----

------enig2OAIFHCRICSWWGTMSKNMI--
