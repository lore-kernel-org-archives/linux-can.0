From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Bus off
Date: Fri, 27 Jun 2014 17:50:12 +0200
Message-ID: <53AD92B4.6020701@pengutronix.de>
References: <CANGgnMZyG1UDVigM-68tu27=oNYfaw0OWxCv4uT+NfN4v=vm2A@mail.gmail.com> <20140627050512.GA1291@vandijck-laurijssen.be> <OF8D65BB4D.F92B928C-ON86257D04.00546246-86257D04.0054697F@notes.cat.com> <53AD8F4B.7090900@grandegger.com> <OF5172F7FC.3EFFF9B4-ON86257D04.0056582A-86257D04.00568EC9@notes.cat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="olK7UwjcpTd6OqmNfCdLKXliI0uRqi622"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55700 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753446AbaF0PuY (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 27 Jun 2014 11:50:24 -0400
In-Reply-To: <OF5172F7FC.3EFFF9B4-ON86257D04.0056582A-86257D04.00568EC9@notes.cat.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Jason R1 White <White_Jason_R1@cat.com>, Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, linux-can-owner@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--olK7UwjcpTd6OqmNfCdLKXliI0uRqi622
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 06/27/2014 05:45 PM, Jason R1 White wrote:
> So is it still the recommendation to close the interface to flush the=20
> queues?
>=20
> Is there anything planned for an ip command or IOCTL to do this?

I already thought some flushing/abort commands, abort the current CAN
frame and abort the tx queue in the controller and flush the whole tx
queue in linux. However we found no customer who actually wanted to
sponsor this development.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--olK7UwjcpTd6OqmNfCdLKXliI0uRqi622
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlOtkrQACgkQjTAFq1RaXHOnGwCbBn5UOy3ExuwfbYcowM2g5RcL
wz8An3M8EwkNyz3PBLF9Ptf9M1vXTsD5
=HUVv
-----END PGP SIGNATURE-----

--olK7UwjcpTd6OqmNfCdLKXliI0uRqi622--
