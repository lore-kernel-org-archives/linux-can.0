From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v4 4/6] can: flexcan: Consolidate and unify state change
 handling.
Date: Tue, 02 Dec 2014 14:25:12 +0100
Message-ID: <547DBDB8.5000108@pengutronix.de>
References: <3103cd54-1421-4594-855f-7bfca8f4ef49@GRBSR0089.marel.net> <547B7CDD.2080202@grandegger.com> <20141201110923.29602.38961@shannon> <6a5747c2d61b278876b6c3154c6a3130@grandegger.com> <20141201115158.1538.64214@shannon> <b4ad671712aef49ca40009d6d2ce6d24@grandegger.com> <20141201122255.3365.66370@shannon> <547CC491.3070705@grandegger.com> <547DB554.8050407@pengutronix.de> <20141202132243.16198.81379@shannon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="CcQ17jQME36Qm2rSpuSdwxrtmx4Nf9Knj"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41114 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932821AbaLBNZX (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 2 Dec 2014 08:25:23 -0500
In-Reply-To: <20141202132243.16198.81379@shannon>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>, Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CcQ17jQME36Qm2rSpuSdwxrtmx4Nf9Knj
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 12/02/2014 02:22 PM, Andri Yngvason wrote:
> That's fine by me. It's good enough for me anyway, as is. I might get s=
ome
> testing done on Saturday.=20

I'll be on vacation then.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--CcQ17jQME36Qm2rSpuSdwxrtmx4Nf9Knj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUfb24AAoJECte4hHFiupUXSkP/jaDcKhrq/Ntawd+TDQnjKic
gucMcvycmxkSt4fM/AHXCb57nzQEf8F1Vt0ROu581U/M0+11XLiPCc4pGujivZ2+
1kXla9GkOYTIS3K4USeLvBam1dXfSvq39x6s+/UHs8mH5ODTPEEpwxgvLKB3PY4I
3bXqNEAxarKoAtNxOS7xPbem+ZUTYzT1K6FdVnR6yWKuXIBu+oUbyquZbM78mPs2
m4rewymY8dD3BoRVWQeiYsWFfl4V/KiGljhJUeiOifNmiX3ReBouOKg77Gokjaxd
U64g9RtFlrJtqpxRG3HGi6Dh9yZGXNzGn+X/7w7osVJepz3Xagvh+UnvvURZDX3P
2bfratyz+n9jNGNiKbRCBd1bxydd5p6kHLBKoeMJiC53bYq0VJoev8qNb06TLCZh
RU179calY0YTM2+vwFePSajv4hPHiKwU2j4du2BpMPAk8IDxb928XMMBKeNSJ4uE
vtngmZnJo06VNUMo63IdjZ7VOuNnqOdq5wER0hFDJFIsz35f+Auzzk9+pTC9t8NT
no5Aq5LBoew2vN09NAepDt6o31dJxuI+LWrzxAYOIdky3JoYGr79Mli9CPvZdKuh
+PFVbOQFCty0w0w9ilW1vXl4WhU+IYHQ8grRixXjP7eK2/HpU5/J446OLbg1Oj68
19Gb0ut9yzXs/AixLex3
=UIHb
-----END PGP SIGNATURE-----

--CcQ17jQME36Qm2rSpuSdwxrtmx4Nf9Knj--
