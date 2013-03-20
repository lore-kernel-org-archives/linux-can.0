From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: j1939 - first steps
Date: Wed, 20 Mar 2013 21:44:18 +0100
Message-ID: <514A1FA2.3050501@pengutronix.de>
References: <5147756D.1060203@hartkopp.net> <20130318214145.GA8685@vandijck-laurijssen.be> <51480B13.8030102@hartkopp.net> <20130320192415.GA4636@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2DLWDHAOQRQFNGGWVHOMJ"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34866 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752541Ab3CTUoV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 20 Mar 2013 16:44:21 -0400
In-Reply-To: <20130320192415.GA4636@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2DLWDHAOQRQFNGGWVHOMJ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 03/20/2013 08:24 PM, Kurt Van Dijck wrote:
> On Tue, Mar 19, 2013 at 07:52:03AM +0100, Oliver Hartkopp wrote:
>> On 18.03.2013 22:41, Kurt Van Dijck wrote:
>>
>>> On Mon, Mar 18, 2013 at 09:13:33PM +0100, Oliver Hartkopp wrote:
>>
>>
>>>> And this (as user):
>>>>
>>>> ./jsr -v vcan0:0x22
>>> you should use 'vcan0:,0x22'.
>>> The format is: 'IFACE:<NAME>[,<ADDR>]'
>>>
>>
>>
>> ./jsr -?
>> jsr: An SAE J1939 send/recv utility
>> Usage: jsr [OPTION...] SOURCE [DEST]
>>
>>   -v, --verbose		Increase verbosity
>>   -p, --priority=3DVAL	J1939 priority (0..7, default 6)
>>   -S, --serialize	Strictly serialize outgoing packets
>>   -s, --size		Packet size, default autodetected
>>
>>   SOURCE	[IFACE:][NAME|SA][,PGN]
>>   DEST			[NAME|SA]
>>
>> Tells me something else ;-)
>=20
> Oliver, how about this change in the docs.
> Would that have avoided this confusion (on both sides).
>=20
> diff --git a/jacd.c b/jacd.c
> index 1358918..088b72c 100644
> --- a/jacd.c
> +++ b/jacd.c
> @@ -39,7 +39,8 @@ static const char help_msg[] =3D
>  	"NAME is the 64bit nodename" "\n"
>  	"\n"
>  	"Example:" "\n"
> -	"jacd -r 100,80-120 -c /tmp/1122334455667788.jacd 1122334455667788" "=
\n"
> +	"	$ jacd -r 100,80-120 -c /tmp/0123456789abcdef.jacd"
> +			" 0123456789abcdef" "\n"
>  	;
> =20
>  #ifdef _GNU_SOURCE
> diff --git a/jspy.c b/jspy.c
> index b48fea1..6b7a215 100644
> --- a/jspy.c
> +++ b/jspy.c
> @@ -37,6 +37,10 @@ static const char help_msg[] =3D
>  	"			(=3D receive traffic not for this ECU)" "\n"
>  	"  -b, --block=3DSIZE	Use a receive buffer of SIZE (default 1024)" "\=
n"
>  	"  -t, --time[=3Da|d|z|A]	Show time: (a)bsolute, (d)elta, (z)ero, (A)=
bsolute w date" "\n"
> +	"\n"
> +	"	NAME, SA & PGN are in hex, without 0x prefix.\n"

What do you use to parse these numbers?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2DLWDHAOQRQFNGGWVHOMJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlFKH6MACgkQjTAFq1RaXHOdTQCeI3AjNQWMBDDZTaTAHeS0QPfJ
V5QAn1Mnzerhz8jCRGOsLp6hu2bDKG4+
=p8VZ
-----END PGP SIGNATURE-----

------enig2DLWDHAOQRQFNGGWVHOMJ--
