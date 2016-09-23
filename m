From: Alexander Gerasiov <gq@cs.msu.su>
Subject: Re: [PATCH v4] can: sja1000: Optimise register accesses
Date: Fri, 23 Sep 2016 14:06:30 +0300
Message-ID: <20160923140630.37373192@brick.gerasiov.net>
References: <20160908135101.17978-1-nebaruzdin@gmail.com>
        <6f96b7d9-e8b6-28cc-b1d3-dbd04bf1a46d@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/+Nu/6Fgst_+bO4bM=ObD/0a"; protocol="application/pgp-signature"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from off.redlab-i.ru ([195.16.34.157]:53242 "EHLO mail.gerasiov.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759250AbcIWLNn (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 23 Sep 2016 07:13:43 -0400
In-Reply-To: <6f96b7d9-e8b6-28cc-b1d3-dbd04bf1a46d@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Nikita Edward Baruzdin <nebaruzdin@gmail.com>, linux-can@vger.kernel.org

--Sig_/+Nu/6Fgst_+bO4bM=ObD/0a
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hello Marc,

On Mon, 19 Sep 2016 16:08:04 +0200
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> I talked to my PCI expert and we came to the conclusion that it's a
> very bad idea to acess the PCI bus with 32 bit on non aligned
> addresses.
>=20
> #define SJA1000_ID1		0x11

Agree, I've missed this. I'll update (write|read)_reg_rep() and send
updated patch next week.

--=20
Best regards,
 Alexander Gerasiov

 Contacts:
 e-mail: gq@cs.msu.su  Homepage: http://gerasiov.net  Skype: gerasiov
 PGP fingerprint: 04B5 9D90 DF7C C2AB CD49  BAEA CA87 E9E8 2AAC 33F1

--Sig_/+Nu/6Fgst_+bO4bM=ObD/0a
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJX5Qy+AAoJEMqH6egqrDPxzF4H/1iR0OsvyiiW7/a05DpVSkzF
pg2frl8kpXz4v2jXdLbBFTu8pMsiMC7jwiVO29QJGUMQui5hpXbFbTYtfLdx62Fm
J+8Cdjo0kuelhfuGGucU9v1sKoUlHAa4kuS3XQIXBiGG/5RJD+NmkzERPk2P6C+Z
kXrohUUxN69hy0aOTuampeJov7/9LJkGQXbYpIQUh7XZZEj5rjc9XYqD/dJcYka6
8apkBwcWBvfB/mNRAVLFtI6QsAlFjfy4kUGgtf56ApwOuWXsk3G+lazNjduivaAC
+w3p9J+7hN+MjRZrXy1E7sX7qHhl94qRh4cn5zFJXAD1y315ta0h9qT9mKiwf1Q=
=R241
-----END PGP SIGNATURE-----

--Sig_/+Nu/6Fgst_+bO4bM=ObD/0a--
