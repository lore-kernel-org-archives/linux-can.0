From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Informations About CAN API of the Linux Kernel
Date: Mon, 11 Mar 2013 16:10:12 +0100
Message-ID: <513DF3D4.6090605@pengutronix.de>
References: <2B7D120CFC15DC438D721B998AD9D9E9097105AB@SEGOTNC5180-N2.vcn.ds.volvo.net> <513763CC.1070507@pengutronix.de> <20130307124012.GC603@vandijck-laurijssen.be> <5139A78D.9060005@pengutronix.de> <20130308100548.GA496@vandijck-laurijssen.be> <20130308125123.GA28383@pengutronix.de> <20130311092923.GA5114@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2NJNHRJOBWLGFVLIHMHKR"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43159 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821Ab3CKPKV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 11 Mar 2013 11:10:21 -0400
In-Reply-To: <20130311092923.GA5114@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Robert Schwebel <r.schwebel@pengutronix.de>, Sako Youssouf <youssouf.sako@renault-trucks.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2NJNHRJOBWLGFVLIHMHKR
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 03/11/2013 10:29 AM, Kurt Van Dijck wrote:
>=20
>=20
> On Fri, Mar 08, 2013 at 01:51:23PM +0100, Robert Schwebel wrote:
>> Hi Kurt,
>>
>> On Fri, Mar 08, 2013 at 11:05:48AM +0100, Kurt Van Dijck wrote:
>>> Could I just mark j1939 as "EXPERIMENTAL" in Kconfig.
>>> I think that is what I've seen most for 'unstable concepts'.
>>
>> EXPERIMENTAL is considered to be deprecated and might be removed from
>> the kernel, so I wouldn't go down that road. Staging sounds right.
>=20
> I see.
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/CodingStyle?id=3Dv3.9-rc2#n549
>=20
> Is such thing then appropriate?

Does j1939 have a protocol number? Probably. If so, we shouldn't use the
"next free" one for an experimental protocol.

Marc

>=20
> --
> diff --git a/net/can/j1939/Kconfig b/net/can/j1939/Kconfig
> index 74d2a86..0db6545 100644
> --- a/net/can/j1939/Kconfig
> +++ b/net/can/j1939/Kconfig
> @@ -3,7 +3,7 @@
>  #
> =20
>  config CAN_J1939
> -	tristate "SAE J1939"
> +	tristate "SAE J1939 (unstable API)"
>  	depends on CAN
>  	---help---
>  	  SAE J1939
> @@ -12,6 +12,7 @@ config CAN_J1939
>  	  The relevant parts in kernel are
>  	  SAE j1939-21 (datalink & transport protocol)
>  	  & SAE j1939-81 (network management).
> +	  Big fat warning: The API is yet unstable!
> =20
>  config CAN_J1939_DEBUG
>  	bool "debug SAE J1939"
>=20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2NJNHRJOBWLGFVLIHMHKR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlE989gACgkQjTAFq1RaXHNcrgCfRiCVsmuXdD54hggEGr95BwZg
KHkAn36EsTxehVg/5vPbd3N5OEd546bc
=RL25
-----END PGP SIGNATURE-----

------enig2NJNHRJOBWLGFVLIHMHKR--
