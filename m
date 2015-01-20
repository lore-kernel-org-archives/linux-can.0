From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can/peak_usb: add adapter BEC callback definition
Date: Tue, 20 Jan 2015 15:50:15 +0100
Message-ID: <54BE6B27.8030007@pengutronix.de>
References: <1421684127-12764-1-git-send-email-s.grosjean@peak-system.com> <1421684127-12764-3-git-send-email-s.grosjean@peak-system.com> <54BE640B.2050509@pengutronix.de> <54BE6A3F.40405@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="QE1R1cNPVHi3GvtS1HcSqQsTcf68d5LHb"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40983 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801AbbATOuT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 20 Jan 2015 09:50:19 -0500
In-Reply-To: <54BE6A3F.40405@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QE1R1cNPVHi3GvtS1HcSqQsTcf68d5LHb
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/20/2015 03:46 PM, Stephane Grosjean wrote:
>=20
> Le 20/01/2015 15:19, Marc Kleine-Budde a =C3=A9crit :
>> On 01/19/2015 05:15 PM, Stephane Grosjean wrote:
>>> Add the definition of a new callback that enable any PEAK-System CAN =
USB
>>> adapter to grant read access to its Bus Error Counters value.
>>> This ability is not supported by all the PEAK-System adapters, thus,
>>> for those, the callback pointer will be initiaized to NULL, which is
>>> correct regarding the linux-can device driver specs.
>>>
>>> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
>>> ---
>>>   drivers/net/can/usb/peak_usb/pcan_usb_core.c | 2 ++
>>>   drivers/net/can/usb/peak_usb/pcan_usb_core.h | 2 ++
>>>   2 files changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/n=
et/can/usb/peak_usb/pcan_usb_core.c
>>> index c23609a..7a73060 100644
>>> --- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
>>> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
>>> @@ -794,6 +794,8 @@ static int peak_usb_create_dev(struct peak_usb_ad=
apter *peak_usb_adapter,
>>>   	dev->can.data_bittiming_const =3D &peak_usb_adapter->data_bittimin=
g_const;
>>>   	dev->can.do_set_data_bittiming =3D peak_usb_set_data_bittiming;
>>>   	dev->can.do_set_mode =3D peak_usb_set_mode;
>>> +	dev->can.do_get_berr_counter =3D
>>> +		peak_usb_adapter->candev_get_berr_counter;
>>>   	dev->can.ctrlmode_supported =3D peak_usb_adapter->ctrlmode_support=
ed;
>>>  =20
>>>   	netdev->netdev_ops =3D &peak_usb_netdev_ops;
>>> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/n=
et/can/usb/peak_usb/pcan_usb_core.h
>>> index a58d971..fb402d2 100644
>>> --- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
>>> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
>>> @@ -70,6 +70,8 @@ struct peak_usb_adapter {
>>>   	int (*dev_stop)(struct peak_usb_device *dev);
>>>   	int (*dev_restart_async)(struct peak_usb_device *dev, struct urb *=
urb,
>>>   					u8 *buf);
>>> +	int (*candev_get_berr_counter)(const struct net_device *netdev,
>>                ^^^^^^
>>
>> I think this prefix can be removed. I've done so in my series.
>=20
> FYI: I added this specific prefix because this is the only callback I'm=
=20
> obliged to use with the "struct net_device *" argument.
> No other way to setup a specific callback to get the BEC.

IC, however the compiler will warn you, if you use the wrong arguments.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--QE1R1cNPVHi3GvtS1HcSqQsTcf68d5LHb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJUvmsnAAoJECte4hHFiupUc/kP/jZbZIaZIds6M/xQOLbWWWnp
auqrgl7T+OOgWuLkv7+rlh90vuHpRFozB5hLuQfJPSOpb5nmqQIn84+rDe2qMq9X
AL14KXzGsx83vL7EpUYXbjlFoo8i4ilpgi/jo7HuOi8DeWpPBYUPhIp6nF9Zp50a
6b74M8IKPjVWes0h16eXz34qEVDwhsOi1/1+T5MY+UQ8K6UQzlbKOpwAVNNscsKi
f/sANPwiBSzEvqmwSiANVOaKGzStI0xOvhtDRgteAFVAIup7OqoYzRjBc0roegQ/
Hi6F1pqnvKbTTLDUxMieP66AE1VtnvayPzSZt+2OtPL02/XZSI2CHqUDtRpSFSAV
tDTNgkFkqTs4LI38i2qaMwXivXBvUJ9toW05wQwplBmV92Dk6UidSVXk4io2au9g
UvXMkXl4hWqIKWFUXAcmAKQOWD1uw9svO31i3zr0GrFIAOAb64ouYyJ9D+3VAren
oWjTFI85sFxwMG/mfzswvkN8MC/hgX49kqoCpRqPuuifLbj8+gASZ48B3RdJJpqM
p4uhgsYvnIYmwV7XgTK7/KZSUtS/MgmSzGDgQbMWmGIjLnpmYXeDO2jHhaiaJ3FD
IitdGUGq6DtJRiflWKNzhxMe0cjeU+f44F8Mehltctaeze8Oxfv+ccw9HCAt83U2
AwZWDVDQpvFYU7s+nc+F
=ifQc
-----END PGP SIGNATURE-----

--QE1R1cNPVHi3GvtS1HcSqQsTcf68d5LHb--
