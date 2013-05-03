From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: kvaser_usb: handle rx msg correctly
Date: Fri, 03 May 2013 11:49:21 +0200
Message-ID: <51838821.6070902@pengutronix.de>
References: <CAJW3KNWxa_a727sgi_EO7nMBVbyVrCz0V3wCJBfvhz0ubbqCfA@mail.gmail.com> <517A968D.20508@pengutronix.de> <20130430214044.GA22921@thinkoso.home> <51824189.8090402@pengutronix.de> <20130502180610.GA14242@thinkoso.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2RVFVOKGNTQAUQNKRWNJC"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48216 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753137Ab3ECJtb (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 3 May 2013 05:49:31 -0400
In-Reply-To: <20130502180610.GA14242@thinkoso.home>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Olivier Sobrie <olivier@sobrie.be>
Cc: Jonas Peterson <jonas.peterson@gmail.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2RVFVOKGNTQAUQNKRWNJC
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 05/02/2013 08:06 PM, Olivier Sobrie wrote:
> Hi Marc,
>=20
> On Thu, May 02, 2013 at 12:35:53PM +0200, Marc Kleine-Budde wrote:
>> On 04/30/2013 11:40 PM, Olivier Sobrie wrote:
>>> --- a/drivers/net/can/usb/kvaser_usb.c
>>> +++ b/drivers/net/can/usb/kvaser_usb.c
>>> @@ -834,22 +834,51 @@ static void kvaser_usb_rx_can_msg(const struct =
kvaser_usb *dev,
>>>  		return;
>>>  	}
>>> =20
>>> -	cf->can_id =3D ((msg->u.rx_can.msg[0] & 0x1f) << 6) |
>>> -		     (msg->u.rx_can.msg[1] & 0x3f);
>>> -	cf->can_dlc =3D get_can_dlc(msg->u.rx_can.msg[5]);
>>> +	switch (msg->id) {
>>> +	case CMD_LOG_MESSAGE:
>>> +		cf->can_id =3D msg->u.log_message.id;
>>
>> No need to mangle the can_id like the CMD_RX_EXT_MESSAGE or
>> CMD_RX_STD_MESSAGE case? What about the extended messages flag?
>=20
> No not needed but I forgot a le32_to_cpu() for the can_id.
> The hw set the CAN_EFF_FLAG when it is an extended frame.

The hardware uses the same bit to mask an extended flag as the linux
kernel does it with CAN_EFF_FLAG? I feel more confident about this if
you add a flag that describes the hard EFF_FLAG and the do the "is EFF
flag set, mask 29 bit and set CAN_EFF_FLAG otherwise mask 11 bit" dance.

Can you please check the driver for other missing leXX_to_cpu and
cpu_to_leXX?

>>> +		cf->can_dlc =3D get_can_dlc(msg->u.log_message.dlc);
>>> +
>>> +		if (msg->u.log_message.flags & MSG_FLAG_REMOTE_FRAME)
>>> +			cf->can_id |=3D CAN_RTR_FLAG;
>>> +		else
>>> +			memcpy(cf->data, &msg->u.log_message.data,
>>> +			       cf->can_dlc);
>>
>> Is this endianness save? But the memcpy was already here. Keep it unti=
l
>> someone with a ppc or sparc complains.
>=20
> msg->u.log_message.dlc is an u8 and I don't see why the memcpy would be=

> a problem.

It's not the dlc I'm talking about. I mean the data. There might be a
problem if you have a dlc of 5. Where is byte 5 located? But I think
it's safe as it is.

>>> +		break;
>>> =20
>>> -	if (msg->id =3D=3D CMD_RX_EXT_MESSAGE) {
>>> +	case CMD_RX_EXT_MESSAGE:
>>>  		cf->can_id <<=3D 18;
>>
>> who sets the can_id in the first place?
>=20
> Damn I shouldn't have changed this by a switch case.
> I fix this and send you an updated patch.

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2RVFVOKGNTQAUQNKRWNJC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlGDiCUACgkQjTAFq1RaXHNYlQCfb96e8yVhxx2BpNfD3WMXy0XN
WG4An2Y8qAcLMQlXjBSK5JzsNEbzrYX8
=xJ+3
-----END PGP SIGNATURE-----

------enig2RVFVOKGNTQAUQNKRWNJC--
