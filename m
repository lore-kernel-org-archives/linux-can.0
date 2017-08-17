From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [00/14] can: cleanup of af_can/raw + simplifying of ndev->ml_priv
 handling
Date: Thu, 17 Aug 2017 16:08:22 +0200
Message-ID: <e5fc9061-c463-1c58-40a8-661acd05ee82@pengutronix.de>
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <351130f1-b68e-6c0a-a18c-294940816bba@hartkopp.net>
 <dd24463a-6c2a-11e0-3fe1-1cea40923485@pengutronix.de>
 <61b043fa-311c-dd8c-404c-65adcf8e987b@hartkopp.net>
 <7d2b8653-1706-61de-6bb7-7198087dca20@pengutronix.de>
 <c6c4857d-2c5a-9f4b-8800-b24c4bb05097@pengutronix.de>
 <7e01b315-3836-4e83-a03d-4ea407e75393@pengutronix.de>
 <37e54c7f-9085-fc6c-716f-a217e3939fa4@hartkopp.net>
 <9d84e955-bce1-a6e9-0d07-a4a2bab98e52@pengutronix.de>
 <551518df-734a-bea1-8685-eda3773b3474@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="02BtREdSwnx6Wih1LANL2W3erJjCJi5fN"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:38325 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751620AbdHQOI3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Aug 2017 10:08:29 -0400
In-Reply-To: <551518df-734a-bea1-8685-eda3773b3474@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--02BtREdSwnx6Wih1LANL2W3erJjCJi5fN
Content-Type: multipart/mixed; boundary="WmSWw2jQU9vVheMg16bd03b0tIqaM97lW";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de
Message-ID: <e5fc9061-c463-1c58-40a8-661acd05ee82@pengutronix.de>
Subject: Re: [00/14] can: cleanup of af_can/raw + simplifying of ndev->ml_priv
 handling
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <351130f1-b68e-6c0a-a18c-294940816bba@hartkopp.net>
 <dd24463a-6c2a-11e0-3fe1-1cea40923485@pengutronix.de>
 <61b043fa-311c-dd8c-404c-65adcf8e987b@hartkopp.net>
 <7d2b8653-1706-61de-6bb7-7198087dca20@pengutronix.de>
 <c6c4857d-2c5a-9f4b-8800-b24c4bb05097@pengutronix.de>
 <7e01b315-3836-4e83-a03d-4ea407e75393@pengutronix.de>
 <37e54c7f-9085-fc6c-716f-a217e3939fa4@hartkopp.net>
 <9d84e955-bce1-a6e9-0d07-a4a2bab98e52@pengutronix.de>
 <551518df-734a-bea1-8685-eda3773b3474@hartkopp.net>
In-Reply-To: <551518df-734a-bea1-8685-eda3773b3474@hartkopp.net>

--WmSWw2jQU9vVheMg16bd03b0tIqaM97lW
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 08/17/2017 03:54 PM, Oliver Hartkopp wrote:
> On 08/17/2017 03:17 PM, Marc Kleine-Budde wrote:
>=20
>> The code gets complicated, as during NETDEV_REGISTER the malloc may
>> fail. But we can cancel the register with return
>> notifier_from_errno(-ENOMEM);
>=20
> So this would lead to a netdevice completely failing to register then?
> Nice!
>=20
>>> With NETDEV_REGISTER the memory would be allocated. Ok.
>>>
>>> An how would the memory be free'd then?
>>
>> NETDEV_UNREGISTER... But we have a problem, as j1939 needs per device
>> memory, too. Which is kfree()ed in a NETDEV_UNREGISTER hook, too. The
>> order of the hooks in not guaranteed.
>=20
> Yes. That's the same problem I was working around with=20
> 'd->remove_on_zero_entries' %-/

Using proper refcounting ...but it gets quite complicatd with j1939.

> Just to get an impression about the j1939 data structures:
>=20
> Would the per-device memory increase significantly when CAN_J1939 is=20
> enabled? Or is it some array of pointers which would be added?

An array with 256 members

> 	struct addr_ent {
> 		ktime_t rxtime;
> 		struct j1939_ecu *ecu;
> 		/* count users, to help transport protocol */
> 		int nusers;
> 	} ents[256];

and some more stuff. Sums up to sizeof(priv)=3D4184 Byte on armv5 (32bit)=
=2E

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--WmSWw2jQU9vVheMg16bd03b0tIqaM97lW--

--02BtREdSwnx6Wih1LANL2W3erJjCJi5fN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlmVo1cACgkQHv7KIOw4
HPZlxQgA1O0hzN+Lf5islmCpx46VyT9N1zFOWpaS5S3UhheGAjxPvulTmV4rBlVK
gG7rnyVqWbtTDpyiP/ojU58CLtNMzZuM8ClwVivDN6nvkod/RpF+uibwfrrFkxDB
jg8Tk50OD13f5aO7wVao6McHoibLXj+eFUyl/PA8ZP499F6VtoRLRBn4qgE7SL39
6a6M5Tm7JGMTnfx8R3DRLaqOH6CLsLkHhT+Cba1Vq7GSKqVGt/f5pKzpxOYvveHs
lM51BC7vmKxVsr4RVwaqFAaIbk+U56KCd0AVyyDmO87yUMPrSbkkP8/Uiav8Ea0Y
aXv7mN6faMSB15IfRXiEW0+3oF2Xaw==
=8Jsp
-----END PGP SIGNATURE-----

--02BtREdSwnx6Wih1LANL2W3erJjCJi5fN--
