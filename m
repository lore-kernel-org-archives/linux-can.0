From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH 0/5] can: enable multi-queue for SocketCAN devices
Date: Mon, 11 Jun 2018 06:41:49 +0200
Message-ID: <a2c3f9c2-0c82-a9df-8ae6-b08a8423b132@pengutronix.de>
References: <b7f078ad43104de9bf2e7dbbe6a2a463@de.bosch.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="iPDzjAqulvdlORRS6c4TpbJGYXVfqPPT6"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b7f078ad43104de9bf2e7dbbe6a2a463@de.bosch.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, netdev <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Heiko Schocher <hs@denx.de>, "ZHU Yi (BT-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iPDzjAqulvdlORRS6c4TpbJGYXVfqPPT6
Content-Type: multipart/mixed; boundary="vFlihA8LetR5Egt2HfyGeVsnZa4kIHP84";
 protected-headers="v1"
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 netdev <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Heiko Schocher <hs@denx.de>, "ZHU Yi (BT-FIR/ENG1-Zhu)"
 <Yi.Zhu5@cn.bosch.com>
Message-ID: <a2c3f9c2-0c82-a9df-8ae6-b08a8423b132@pengutronix.de>
Subject: Re: [PATCH 0/5] can: enable multi-queue for SocketCAN devices
References: <b7f078ad43104de9bf2e7dbbe6a2a463@de.bosch.com>
In-Reply-To: <b7f078ad43104de9bf2e7dbbe6a2a463@de.bosch.com>

--vFlihA8LetR5Egt2HfyGeVsnZa4kIHP84
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,


On 07.06.2018 17:14, Jonas Mark (BT-FIR/ENG1) wrote:
> Hi Andy,
>=20
>>> The functionality bases on an external peripheral chip named Companio=
n.
>>> It offers two CAN interfaces, each has 8 prioritized transmit FIFOs a=
s
>>> well as one receive FIFO. Besides CAN, undisclosed additional functio=
ns
>>> can be accessed through the char device.
>>>
>>> A standard SPI interface with two additional lines for flow control i=
s
>>> used. The Companion chip is the SPI slave.
>>
>> Can remoteproc API be utilized here?
>=20
> So far I wasn't aware of the remoteproc API. It appears to me that is
> limited to power on/off and loading firmware in an AMP scenario. Here,
> the Companion has a fixed firmware in it. It must already be running
> quickly after power-up, even before the boot loader.

yes, remoteproc is not quite suitable for this task.

> Does remoteproc also contain a communication framework?

it is using VirtIO

> Do you mean rpmsg? Here, I do not see how we could benefit from it.

using same message format instead of inventing new one will be really
good step:
https://github.com/OpenAMP/open-amp/wiki/RPMsg-Messaging-Protocol
(less code duplicating same functionality)

Looks like every company trying to solve the same problem over and over
again. We have point to point link between two systems. Each system has
multiple functionalities/applications so we should be able to address
this functionality. So we end to some thing with source address and
destination address. In all protocols used for inter processor/chip
communication, the difference is only the layout of 3 common fields:
source, destination and size. In many cases the ISO/OSI layer model is
badly broken and

> Can you point me to an example where rpmsg is used over SPI?

RPMsg is just transport layer, 5 or 6 wire SPI is in this case Physical
layer with flow control support. Currently i'm not sure if VirtIO with
queue support do make sense here.

> Greetings,
> Mark


--vFlihA8LetR5Egt2HfyGeVsnZa4kIHP84--

--iPDzjAqulvdlORRS6c4TpbJGYXVfqPPT6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEpENFL0P3hvQ7p0DDdQOiSHVI77QFAlsd/ZUACgkQdQOiSHVI
77TaMwf/X4Yl2Mi0EqVaL5X7z4/3gXNhpJxAohpOLwR+/Nks1SLGVANiarkzrDOg
Ojj6Ejrc2ycctLBPCOl83W/CfmlHN1py6bQN/WhvABa8ykRPmBctgQYOeIDtvwTy
bvKXziu25g7I4RDUw2I6OmHRe93LlHOv/bHTBScZrXsfwFlYbRzkKfy03Ih1qwf2
rUmjexMxUcXn8ud5cFXC0tJ2Qs72QUaZ7iYhp6Yww6fnCNg+rbwEBhDO2TBHQVtL
cO5TrvTJPrq0WNdX858zFtZqVQvz5IyUyrWAg1MjPoRoT+Edw1tLUc4pq/1x8pPZ
CC4D5U0KG7/eYNyinYh7dqpLYM2aJg==
=mEgW
-----END PGP SIGNATURE-----

--iPDzjAqulvdlORRS6c4TpbJGYXVfqPPT6--
