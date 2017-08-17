From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [00/14] can: cleanup of af_can/raw + simplifying of ndev->ml_priv
 handling
Date: Thu, 17 Aug 2017 15:03:01 +0200
Message-ID: <c6c4857d-2c5a-9f4b-8800-b24c4bb05097@pengutronix.de>
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <351130f1-b68e-6c0a-a18c-294940816bba@hartkopp.net>
 <dd24463a-6c2a-11e0-3fe1-1cea40923485@pengutronix.de>
 <61b043fa-311c-dd8c-404c-65adcf8e987b@hartkopp.net>
 <7d2b8653-1706-61de-6bb7-7198087dca20@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="m3RPfqMVuNukRtWw8jBJbvGPOgqMpUkAR"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:51781 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750857AbdHQNDG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Aug 2017 09:03:06 -0400
In-Reply-To: <7d2b8653-1706-61de-6bb7-7198087dca20@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--m3RPfqMVuNukRtWw8jBJbvGPOgqMpUkAR
Content-Type: multipart/mixed; boundary="nLVK81RpPWs62EhcA8pMJwIAEHhrndbAJ";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de
Message-ID: <c6c4857d-2c5a-9f4b-8800-b24c4bb05097@pengutronix.de>
Subject: Re: [00/14] can: cleanup of af_can/raw + simplifying of ndev->ml_priv
 handling
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <351130f1-b68e-6c0a-a18c-294940816bba@hartkopp.net>
 <dd24463a-6c2a-11e0-3fe1-1cea40923485@pengutronix.de>
 <61b043fa-311c-dd8c-404c-65adcf8e987b@hartkopp.net>
 <7d2b8653-1706-61de-6bb7-7198087dca20@pengutronix.de>
In-Reply-To: <7d2b8653-1706-61de-6bb7-7198087dca20@pengutronix.de>

--nLVK81RpPWs62EhcA8pMJwIAEHhrndbAJ
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 08/17/2017 03:02 PM, Marc Kleine-Budde wrote:
> On 08/17/2017 02:57 PM, Oliver Hartkopp wrote:
>> Hi Marc,
>>
>> On 08/17/2017 01:57 PM, Marc Kleine-Budde wrote:
>>
>>>
>>> Have you found some time to look at these issues?
>>>
>>
>> I'm going through the code just now ;-)
>>
>> One question:
>>
>> All the midlayer private stuff was also done to cleanly separate the=20
>> network layer stuff in net/can from the driver layer stuff in=20
>> drivers/net/can.
>>
>> Now you introduce a network layer data structure into the driver layer=
=2E
>> I'm not against this - and in fact I can see a bunch of advantages and=
=20
>> simplifications as you intended.
>=20
>> But do you think it's a proper approach from the perspective of layer =

>> separation?
>=20
> No. Another approach is keep the memory allocation in the
> NETDEV_REGISTER hook, but refuse to start the netdev with NOTIFY_DONE.

copy/paste confusion:
NOTIFY_STOP of course

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--nLVK81RpPWs62EhcA8pMJwIAEHhrndbAJ--

--m3RPfqMVuNukRtWw8jBJbvGPOgqMpUkAR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlmVlAYACgkQHv7KIOw4
HPaD/AgAoVmpAHSvbvt0nmU/EVxluyOBc/CDE6p2ygsou9MRwG84KTYwLYrcbt63
K5IYXlDpdRyAqRttcnKRz9twpHLsOOaglatsF2tGFK3DS/GiFgVSeIPiInoZvyHT
H/e1KKf2f9z70BJJfHemyNkIO8SPd1CH2h6+EWFeax0UHxwiLJY/6j6uuqE9WR0/
MaMQxsHprUpsvKVLnfC/YpoTzP8jKQlKUoViww8Wh6KqW4nYHp1ZiIbX7gGQ9XMm
9KgpHhLhUu8iHac704qSnZ/uYxZU5bZvcqd8bQ/CFLviHlWo4IZ91PWKhB02UfZR
WwSIDcXHDVrZe2Kr6Lz3ykC0LqR8nA==
=P5y5
-----END PGP SIGNATURE-----

--m3RPfqMVuNukRtWw8jBJbvGPOgqMpUkAR--
