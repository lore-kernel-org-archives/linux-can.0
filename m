From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH V4 2/2] bfin_can: rewrite the driver into common style
 with MMU
Date: Thu, 05 Feb 2015 09:50:20 +0100
Message-ID: <54D32ECC.7070809@pengutronix.de>
References: <y> <1423124930-12871-1-git-send-email-Aaron.wu@analog.com> <1423124930-12871-2-git-send-email-Aaron.wu@analog.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="IOxbXRkMrOTwKRKVILma7gRl2kJdRm5nv"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423124930-12871-2-git-send-email-Aaron.wu@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaron Wu <Aaron.wu@analog.com>, wg@grandegger.com, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, linux-devel@analog.com
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IOxbXRkMrOTwKRKVILma7gRl2kJdRm5nv
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/05/2015 09:28 AM, Aaron Wu wrote:
> Rewrite the blackfin CAN driver into common style
> V4 changes: remove unused variable in patch 2/2
> V3 changes: remove redundant cast in patch 2/2
> V2 changes: split patch into two parts
> V1 changes: rewrite code into common style
>=20
> Signed-off-by: Aaron Wu <Aaron.wu@analog.com>

The code looks good, the patch description can be improved though.
Please replace the change history by a description what this patch does
and why. For this kind of patch a single sentence would be enough, but
rewrite into common style is to generic. (Same applies to 1/2)

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--IOxbXRkMrOTwKRKVILma7gRl2kJdRm5nv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJU0y7PAAoJECte4hHFiupUNrcP/RIuZUa0NKTKlM6vBoKhJ0fc
Q+EuTYkUyrBYmWDFqwBXL5ecWz8RXyYUk/2akHjeuxM7r8BKIW01cihcKIV08XFq
6sdDEhGB5l4pVs1t3u2TJ8D7QqS9jjRCqIObeGbEvtdXjrjilGX9Okd9xzl+aIQJ
Of4tXOySUsRxnaWbflONnuTJAYb1SGRp7DzZYTz1lTkIZ2RoPX+4rMDZ2MQ2hlpH
19fvBRHqEJEpkej6mqeLiIpVyLvtmDOFi44sBX056fw1VZS6cwM6Hukb/OBwXNWd
dnc/PVop+2t+PHtkSx+tAYydLqoMml4o3Ud3JQ4nWS9WhyyItMsKcwe3Ov/XJEZV
FNraYsVPJtBbZnpv6XeXF+KbZ7WV52cDfi9sK1g8hDfMVse5/CvWvnH2ka5cstDl
7tqppBhMYSV5QF2gar9Ev1s7VUezQFrqhvHJjlAa7d9dZBbT59DWzski4RIv+Jzc
fzjV41YWfqEkebhi59ysEhtTpxjdbRmKhEb0Plrcq+3iew3p6OQmbD8qqE7flQsv
DV8MXwgFfALnG70C08aHCvGe3Iua94TEIIV8Oehzulp3uYeDSSaq991Sa191DbPc
l5SN7fWqq9KY7D7ZJ2TAsoO/6IKdM2yVED3RTN40LQvABgvSgltxDD4FhrCWhq1t
YPznB48G68WPYODqzPX8
=G5Bc
-----END PGP SIGNATURE-----

--IOxbXRkMrOTwKRKVILma7gRl2kJdRm5nv--
