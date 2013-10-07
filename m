From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/3] remove do_get_state() callback
Date: Mon, 07 Oct 2013 21:39:25 +0200
Message-ID: <52530DED.5080604@pengutronix.de>
References: <1381157168-24588-1-git-send-email-mkl@pengutronix.de> <52530AAB.4040808@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="6aQfoPkOCmHBeOrmF4cdsA4BlkwNgF1OD"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51228 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642Ab3JGTje (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Oct 2013 15:39:34 -0400
In-Reply-To: <52530AAB.4040808@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6aQfoPkOCmHBeOrmF4cdsA4BlkwNgF1OD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/07/2013 09:25 PM, Wolfgang Grandegger wrote:
>> this patch series removes the do_get_state() callback from the driver
>> interface, as it is not needed to get the state of the interface.

Then I'll just take "[PATCH 1/3] can: ti_hecc: remove
priv->can.do_get_state() callback"

> I just realized that Max's GS-USB driver would require it because the
> device does not send asynchronous error and state change messages. But
> thinking more about it, I tend to nack such a solution as it breaks man=
y
> user space programs.

The real need for a synchronous state callback to the driver has come
with the GS-USB device. I'll drop patches 2+3.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--6aQfoPkOCmHBeOrmF4cdsA4BlkwNgF1OD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlJTDe0ACgkQjTAFq1RaXHMyDwCcC2ULxJZWMBuL0Uw50CFs2qcx
cvYAnjGdE+bDbwtgrCFDB5ZApfSo6uDC
=uZwq
-----END PGP SIGNATURE-----

--6aQfoPkOCmHBeOrmF4cdsA4BlkwNgF1OD--
