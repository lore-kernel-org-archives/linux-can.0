From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: SocketCAN stops read after RX overflow, is it normal?
Date: Mon, 12 Oct 2015 11:50:45 +0200
Message-ID: <561B8275.1060504@pengutronix.de>
References: <55E6CCC8.7010908@picquet.fr> <55E80C74.8060600@pengutronix.de>
 <561B69B2.9010804@picquet.fr> <561B7556.3050206@pengutronix.de>
 <561B7781.4040906@picquet.fr> <561B7A3C.20500@pengutronix.de>
 <561B818F.8060100@picquet.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="tXokUpnStHCpuM0LcI9CTA64UfIefQKoI"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:50192 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308AbbJLJuv (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 12 Oct 2015 05:50:51 -0400
In-Reply-To: <561B818F.8060100@picquet.fr>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Guillaume Picquet <guillaume@picquet.fr>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tXokUpnStHCpuM0LcI9CTA64UfIefQKoI
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/12/2015 11:46 AM, Guillaume Picquet wrote:
>=20
>=20
> Le 12/10/2015 11:15, Marc Kleine-Budde a =C3=A9crit :
>> On 10/12/2015 11:04 AM, Guillaume Picquet wrote:
>>> Le 12/10/2015 10:54, Marc Kleine-Budde a =C3=A9crit :
>>>> On 10/12/2015 10:05 AM, Guillaume Picquet wrote:
>>>>> I've received a patched firmware from my provider, tested it and so=
 far
>>>>> so good.
>>>> Good to hear that. Can you send the patches or at91_can.c to the lis=
t?
>>> It's your patch I gave my provider.
>>>
>>> https://git.kernel.org/cgit/linux/kernel/git/mkl/linux-can-next.git/c=
ommit/?h=3Dat91-next&id=3D7234e9dee7d0df75de7ae14443a2306435750594
>> Ah, good to hear that this works for your usecase aswell. Can I add yo=
ur
>> Tested-by Tag to the patch?
> Yes why not, But I can not guarantee that my provider did not modify th=
e=20
> patch.

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--tXokUpnStHCpuM0LcI9CTA64UfIefQKoI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWG4J1AAoJEP5prqPJtc/H1kQH/0E+exRGNPTMs7pbZ4qkw4ah
gz35YdytmxmVEJAYnb3ez1z60bV++yy0vD5ItiIwmlPO0TzpFnJ6ujwX+2dMWMz7
KrHgCkZDyd/erz7PyftY9dIijtIHXbjCBYLslfr1C3UZfOEcpPsekd5hG7ZWV7nB
fz/iw8CLWeAAAbreLovFEJZ/sXjhAsc9zakVydzRI2HFiRekOgyDvWDFgzO6kOXM
wfh3BQvhEJwUU8b+t3zB6kP2clUWGpbeeQdQrjx8yfUNkyur7qPGBvdCdwnZJQLt
YpupiuMcn2fqcfumkvsPmb8wvlPVP33NDsyevbb966aLr03p9IRc9Q49p/uv9l8=
=kRtc
-----END PGP SIGNATURE-----

--tXokUpnStHCpuM0LcI9CTA64UfIefQKoI--
