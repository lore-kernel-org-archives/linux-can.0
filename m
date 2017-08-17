From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [00/14] can: cleanup of af_can/raw + simplifying of ndev->ml_priv
 handling
Date: Thu, 17 Aug 2017 15:06:27 +0200
Message-ID: <7e01b315-3836-4e83-a03d-4ea407e75393@pengutronix.de>
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <351130f1-b68e-6c0a-a18c-294940816bba@hartkopp.net>
 <dd24463a-6c2a-11e0-3fe1-1cea40923485@pengutronix.de>
 <61b043fa-311c-dd8c-404c-65adcf8e987b@hartkopp.net>
 <7d2b8653-1706-61de-6bb7-7198087dca20@pengutronix.de>
 <c6c4857d-2c5a-9f4b-8800-b24c4bb05097@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="diRNFjVgDeN8obWeRPx4tsgPmjA1E8KCg"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:59465 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750926AbdHQNGb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Aug 2017 09:06:31 -0400
In-Reply-To: <c6c4857d-2c5a-9f4b-8800-b24c4bb05097@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--diRNFjVgDeN8obWeRPx4tsgPmjA1E8KCg
Content-Type: multipart/mixed; boundary="BprAc7wsFmPm3OjrPfnSnmRKbLfa6PFSm";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de
Message-ID: <7e01b315-3836-4e83-a03d-4ea407e75393@pengutronix.de>
Subject: Re: [00/14] can: cleanup of af_can/raw + simplifying of ndev->ml_priv
 handling
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <351130f1-b68e-6c0a-a18c-294940816bba@hartkopp.net>
 <dd24463a-6c2a-11e0-3fe1-1cea40923485@pengutronix.de>
 <61b043fa-311c-dd8c-404c-65adcf8e987b@hartkopp.net>
 <7d2b8653-1706-61de-6bb7-7198087dca20@pengutronix.de>
 <c6c4857d-2c5a-9f4b-8800-b24c4bb05097@pengutronix.de>
In-Reply-To: <c6c4857d-2c5a-9f4b-8800-b24c4bb05097@pengutronix.de>

--BprAc7wsFmPm3OjrPfnSnmRKbLfa6PFSm
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 08/17/2017 03:03 PM, Marc Kleine-Budde wrote:
> On 08/17/2017 03:02 PM, Marc Kleine-Budde wrote:
>> On 08/17/2017 02:57 PM, Oliver Hartkopp wrote:
>>> Hi Marc,
>>>
>>> On 08/17/2017 01:57 PM, Marc Kleine-Budde wrote:
>>>
>>>>
>>>> Have you found some time to look at these issues?
>>>>
>>>
>>> I'm going through the code just now ;-)
>>>
>>> One question:
>>>
>>> All the midlayer private stuff was also done to cleanly separate the =

>>> network layer stuff in net/can from the driver layer stuff in=20
>>> drivers/net/can.
>>>
>>> Now you introduce a network layer data structure into the driver laye=
r.
>>> I'm not against this - and in fact I can see a bunch of advantages an=
d=20
>>> simplifications as you intended.
>>
>>> But do you think it's a proper approach from the perspective of layer=
=20
>>> separation?
>>
>> No. Another approach is keep the memory allocation in the
>> NETDEV_REGISTER hook, but refuse to start the netdev with NOTIFY_DONE.=

>=20
> copy/paste confusion:
> NOTIFY_STOP of course

Or even use notifier_from_errno

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--BprAc7wsFmPm3OjrPfnSnmRKbLfa6PFSm--

--diRNFjVgDeN8obWeRPx4tsgPmjA1E8KCg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlmVlNMACgkQHv7KIOw4
HPaWrQf/eX8/Yox7XF1n5iwq2leKv3QzCoA7cap/TRXvaYm5OL37wwTYTcYGjeKD
NEGpduvvPJWS+01h+7sATBqPrVE9ZfOoPeYtSfDX84kt7WOlChk5LoFK3QokPbyu
Sn/Pl7+JQHJpaqFVZZFVgYxJyskRZ6yV9QZSM/ur5Xe/WXkuu+426sdU6FSoOuOc
K8gel+AP6xcQnzSElMlSqNGkhGUWpiPD0nNg9BjgT3vyPmcPc9cCWnSkWwaLIuFU
iuhGQaj3T+uMASHLQ7tv2LdDRyRnlQmD6EgAagKagrdrdQ7uB2S9cCCiUTDv3p68
2q34ZkleY9mPZV5Ekmfug3xSn/Mq4w==
=W4Yb
-----END PGP SIGNATURE-----

--diRNFjVgDeN8obWeRPx4tsgPmjA1E8KCg--
