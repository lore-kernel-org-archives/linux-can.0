From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Associate physical device with device name
Date: Fri, 9 Feb 2018 14:24:53 +0100
Message-ID: <771a0c6e-c94c-7dc2-ffa0-06507aab077d@pengutronix.de>
References: <e8998556-5e13-1cec-f404-70c4679ca9c3@kvaser.com>
 <87ddf56f-c829-6aad-5b86-474359d282d4@pengutronix.de>
 <f1dbf319-eda5-6901-c5e4-d08651e2c1fe@kvaser.com>
 <464f89e6-82c8-a2fd-25e2-f847508b41a3@pengutronix.de>
 <35989d02-3134-1a84-8bec-61a863fa0bf3@kvaser.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="sf7ImK5sbP7ZtvDO04HhG5n3rRv3ZXi41"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59169 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750973AbeBINZe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 9 Feb 2018 08:25:34 -0500
In-Reply-To: <35989d02-3134-1a84-8bec-61a863fa0bf3@kvaser.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Jimmy Assarsson <extja@kvaser.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sf7ImK5sbP7ZtvDO04HhG5n3rRv3ZXi41
Content-Type: multipart/mixed; boundary="XkAOU4LmCGOmdK4cuF35TFg2UxXq6YbPt";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jimmy Assarsson <extja@kvaser.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Message-ID: <771a0c6e-c94c-7dc2-ffa0-06507aab077d@pengutronix.de>
Subject: Re: Associate physical device with device name
References: <e8998556-5e13-1cec-f404-70c4679ca9c3@kvaser.com>
 <87ddf56f-c829-6aad-5b86-474359d282d4@pengutronix.de>
 <f1dbf319-eda5-6901-c5e4-d08651e2c1fe@kvaser.com>
 <464f89e6-82c8-a2fd-25e2-f847508b41a3@pengutronix.de>
 <35989d02-3134-1a84-8bec-61a863fa0bf3@kvaser.com>
In-Reply-To: <35989d02-3134-1a84-8bec-61a863fa0bf3@kvaser.com>

--XkAOU4LmCGOmdK4cuF35TFg2UxXq6YbPt
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 02/09/2018 12:21 PM, Jimmy Assarsson wrote:
>>> No, they are not identical. The EAN and serial number is stored on th=
e
>>> device.
>>
>> How to read them?
>=20
> It is part of the "kvaser_msg_cardinfo" command, see
> https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git/tree/=
drivers/net/can/usb/kvaser_usb.c#n198

ok

>>> Which makes a single device unique. It is possible to fetch these
>>> from the device. And same applies to all Kvaser CAN interfaces,
>>> regardless if they are connected via USB, PCI-express or ethernet.
>> What's the output of the udev when using the proper path to your devic=
e?
>>
>> "udevadm info --path=3D/devices/pci0000:00/0000:00:14.0/usb1/1-2/ -a"
>=20
> All devices with the same EAN look identical, since we do not set seria=
l
> number in the USB descriptor.

That should be done on the next FW revision.

Ok - I see two possibilities.

1) sysfs file
Add a file to sysfs that contains the serial number, see:
http://lxr.bootlin.com/linux/latest/source/drivers/net/can/softing/softin=
g_main.c#L718

2) ethtool eeprom
You can export the serial number via ethtool's dump eeprom functionality.=


Better try 1).

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--XkAOU4LmCGOmdK4cuF35TFg2UxXq6YbPt--

--sf7ImK5sbP7ZtvDO04HhG5n3rRv3ZXi41
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlp9oSUACgkQk9IU1zQo
ZfH7YAf9FauHCMCaWaiYNP4tp4PaiDtnoZTxQgAncfx6cvNgOYgn44czCpZ7wGV3
ex68VyYMlVZ9ZG6cXF3QebZi1PnymmlwA2D2nxyn178bd5NToipfKCDBkK2AQZvS
Kne8FLJLg5EnzFjeGoxDpryKr4yiQMaDk76XRVG5x9m+/ylE/g3t3EiOHGx9P6Zc
p4Jpkwp6Ur9Vua6jc7785T+fOYj2o5I14gtR170GYX+EoboI753wQMyETtaP90SU
CHXCOa+onBr4/h5V9NVNJ5eFWYpsq+kIylJJKa9msEU6n5a9GBUuY/fraaAJGSza
ZthKtfNlPwkyJKyGPpMjYkf+lUXXsA==
=Dxx/
-----END PGP SIGNATURE-----

--sf7ImK5sbP7ZtvDO04HhG5n3rRv3ZXi41--
