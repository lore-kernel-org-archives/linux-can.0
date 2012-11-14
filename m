From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] Use strcmp instead of strncmp
Date: Wed, 14 Nov 2012 11:10:13 +0100
Message-ID: <50A36E05.4050708@pengutronix.de>
References: <1352821642-18791-1-git-send-email-alexander.stein@systec-electronic.com> <50A2AD0A.6040005@pengutronix.de> <20121114085537.GB82180@airbook.eia.lan> <7396967.nBD5445xda@ws-stein> <20121114100441.GA82249@airbook.eia.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1BFDE338246D01A973C1DF97"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58970 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161008Ab2KNKKT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 14 Nov 2012 05:10:19 -0500
In-Reply-To: <20121114100441.GA82249@airbook.eia.lan>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1BFDE338246D01A973C1DF97
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/14/2012 11:04 AM, Kurt Van Dijck wrote:
> On Wed, Nov 14, 2012 at 10:07:15AM +0100, Alexander Stein wrote:
>> Hello,
>>
>> On Wednesday 14 November 2012 09:55:37, Kurt Van Dijck wrote:
>>> On Tue, Nov 13, 2012 at 09:26:50PM +0100, Marc Kleine-Budde wrote:
>>>> On 11/13/2012 04:47 PM, Alexander Stein wrote:
>>>>> This bug was detected by the clang warning:
>>>>> libsocketcan.c:384:16: warning: argument to 'sizeof' in 'strncmp' c=
all
>>>>> is the same expression as the source; did you mean to provide an
>>>>> explicit length? [-Wsizeof-pointer-memaccess]
>>>>> sizeof(name)) !=3D 0)
>>>>> ~~~~~~~^~~~~~
>>> strlen() requires a null terminator. Is that always present?
>>> Unfortunately, I've no access to the libsocketcan code today...
>>>>>
>>>>> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.c=
om>
>>>>> ---
>>>>>  src/libsocketcan.c |    3 ++-
>>>>>  1 files changed, 2 insertions(+), 1 deletions(-)
>>>>>
>>>>> diff --git a/src/libsocketcan.c b/src/libsocketcan.c
>>>>> index fedcbdc..3ad2a6c 100644
>>>>> --- a/src/libsocketcan.c
>>>>> +++ b/src/libsocketcan.c
>>>>> @@ -364,6 +364,7 @@ static int do_get_nl_link(int fd, __u8 acquire,=
=20
>> const char *name, void *res)
>>>>>  		     nl_msg =3D NLMSG_NEXT(nl_msg, u_msglen)) {
>>>>>  			int type =3D nl_msg->nlmsg_type;
>>>>>  			int len;
>>>>> +			int namelen =3D strlen(name);
>>>>> =20
>>>>>  			if (type =3D=3D NLMSG_DONE) {
>>>>>  				done++;
>>>>> @@ -381,7 +382,7 @@ static int do_get_nl_link(int fd, __u8 acquire,=
=20
>> const char *name, void *res)
>>>>> =20
>>>>>  			if (strncmp
>>>>>  			    ((char *)RTA_DATA(tb[IFLA_IFNAME]), name,
>>>>> -			     sizeof(name)) !=3D 0)
>>>>> +			     namelen) !=3D 0)
>>>>
>>>> What about using strcmp() instead. AFAIK it will compare until it fi=
nds
>>>> the end of the string in one of the strings, so it should be no
>>>> difference here?
>>> if name contains a null terminator, using strcmp() is even better.
>>
>> name is passed directly from public API functions like can_get_state. =
So the=20
>> user has to provide the null terminator. As this cannot be garuanteed =

> I think we should assume that the user passes a null terminated string.=

> Otherwise, we must question if the user passes a valid address. I don't=

> like to go that way.
>=20
> strcmp() will just work.

+1

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig1BFDE338246D01A973C1DF97
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlCjbggACgkQjTAFq1RaXHPIRgCggXIDwb+ATmDdihVwEj8u43N+
p/MAoIq4elPc6lAnNlMh1PLX0WdcRIpO
=fWPT
-----END PGP SIGNATURE-----

--------------enig1BFDE338246D01A973C1DF97--
