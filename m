From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 09/15] can: rx-fifo: Add can_rx_fifo_reset() function
Date: Mon, 03 Nov 2014 13:51:46 +0100
Message-ID: <54577A62.2010803@pengutronix.de>
References: <1412956020-21489-1-git-send-email-david@protonic.nl>	<1412956020-21489-10-git-send-email-david@protonic.nl>	<54576408.5040709@pengutronix.de> <20141103134655.1108332b@archvile>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="JHujiOeEt5RiVlgEb1HIjj38Me9AEcNNU"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45948 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752135AbaKCMv6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 3 Nov 2014 07:51:58 -0500
In-Reply-To: <20141103134655.1108332b@archvile>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JHujiOeEt5RiVlgEb1HIjj38Me9AEcNNU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/03/2014 01:46 PM, David Jander wrote:
> On Mon, 03 Nov 2014 12:16:24 +0100
> Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>=20
>> On 10/10/2014 05:46 PM, David Jander wrote:
>>> This function needs to be called every time the CAN controller is res=
et
>>> and before interrupts are enabled. Otherwise the irq-offload loop get=
s
>>> out of sync. Detect this and BUG() to the user if he forgot.
>>>
>>> Signed-off-by: David Jander <david@protonic.nl>
>>> ---
>>>  drivers/net/can/dev.c   | 20 ++++++++++++++++++--
>>>  include/linux/can/dev.h |  1 +
>>>  2 files changed, 19 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
>>> index 3e1160a..fc35d28 100644
>>> --- a/drivers/net/can/dev.c
>>> +++ b/drivers/net/can/dev.c
>>> @@ -487,8 +487,17 @@ int can_rx_fifo_irq_offload(struct can_rx_fifo *=
fifo)
>>>  		fifo->second_first =3D true;
>>>  	}
>>> =20
>>> -	if (received)
>>> -		napi_schedule(&fifo->napi);
>>> +	if (received) {
>>> +		can_rx_fifo_napi_schedule(fifo);
>>> +	} else {
>>> +		/*
>>> +		 * This should only happen if the CAN conroller was
>>> reset, but
>>> +		 * can_rx_fifo_reset() was not called. BUG();
>>> +		 */
>>> +		netdev_warn(fifo->dev, "%s: No messages found,"
>>> +			    " RX-FIFO out of sync?\n", __func__);
>>> +		BUG();
>>
>> Can you replace the BUG() (which crashes the system) by something less=

>> fatal? E.g. by some of the WARN function [1]? Does it make sense to ca=
ll
>> the fifo_reset() function after this? We'll loose up to a FIFO size
>> amount of CAN frames, but the system stays hopefully working.
>=20
> Ok. We just need to make enough noise, so that the potential driver's a=
uthor
> sees it before release... a WARN*() should do.

ACK, and it will generate a stack-trace, too. However I don't want to
have crashing machines at $CUSTOMER, if there is a subtle bug, what's
not triggered regularly.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--JHujiOeEt5RiVlgEb1HIjj38Me9AEcNNU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUV3piAAoJECte4hHFiupUyIQQAIfTHOxL6usEXH2IV/+QRdq4
GHKEnErizywoN35tGoghIvOk7Stxmvj7bS88O9H/KXC9/hmKLveMfu2R0NEUp5LG
SRO93PlPcPJtS7JsD9ua1YV+KpNlEkF7wOCEDXTR6icSdjsT+ClL4wGoOiRKfZfm
cVTSZKAweuGpO8ELwVpU9i2Bdmpv60QjNMKnDRHvqIrAhspkEOR6bj/Nv6TaQ9FJ
1QYvUDYE9O52JwnC8p5iwJlhQNsD7l3IxDrlPu+MsDy2ePmJB9ThBd4F41L9NPhx
GZ2NB6H5zldRoHyhNgq3setycCc0T0UwmZEVJxT8EjZaGvwvxbmoZpzOgtfd090+
5zcXX1dHmIlzZASvJNGW5v44NlnB5WqDhfadTZC8YiWIct2MAusVhSlRj4BAGAv8
ZPy4COMEZQRI0xYMi5yNl8SdxaX/iQt51MIo4wVr1eW3BzFRY88Zog0c3gm+SOWv
IP5K/3vNs2pplAC2whJDEVRU7Qp9sZUNUcilBNup9aDfa25HyWxj8BJ0zBAQ7Vn5
+PG1+HiI9eyl4nOEQVVUjWWDoQ32Nqz/zJ2cKzsa/xtGvoxKNbty7xCT6z0JXqTY
jns9lE4c4Ndei4emx8OlskDamftbWORY49mTEw9zgwJkxEuJJi5/LxMq3d5Ni4uE
F+395t1svwmCwPOqTbze
=67q7
-----END PGP SIGNATURE-----

--JHujiOeEt5RiVlgEb1HIjj38Me9AEcNNU--
