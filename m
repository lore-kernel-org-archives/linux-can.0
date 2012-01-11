From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [can-utils] canbusload: flush output at the end of each cycle
Date: Wed, 11 Jan 2012 12:12:41 +0100
Message-ID: <4F0D6EA9.4070708@pengutronix.de>
References: <20111221091948.GC314@e-circ.dyndns.org> <4EF2D0F3.6080909@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCBD7D128A1D2C8A1249C5806"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56839 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753040Ab2AKLMq (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Jan 2012 06:12:46 -0500
In-Reply-To: <4EF2D0F3.6080909@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCBD7D128A1D2C8A1249C5806
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 12/22/2011 07:40 AM, Oliver Hartkopp wrote:
> On 21.12.2011 10:19, Kurt Van Dijck wrote:
>=20
>> canbusload: flush output at the end of each cycle
>>
>> When canbusload is piped to another program, the output
>> is queued for several cycles. This patch will flush the output
>> explicitely.
>>
>> Signed-off-by: Kurt Van Dijck <kurt.van.dijck@eia.be>
>=20
>=20
> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
>=20
> Tnx Kurt.
>=20
> I'll put it into the can-utils tree the next days.

nitpick:
Oliver, please don't forget to add your S-o-b if you are pushing commits
to the tree.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigCBD7D128A1D2C8A1249C5806
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8NbqsACgkQjTAFq1RaXHM7iQCaAxuoqTZ9JBIpBbcm761u5sXL
nA0AnRCBA6m8XWJZ5frMzp+vgT0fPTW6
=/LBT
-----END PGP SIGNATURE-----

--------------enigCBD7D128A1D2C8A1249C5806--
