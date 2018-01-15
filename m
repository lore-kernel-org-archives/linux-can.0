From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: peak/usb: fix potential bug in packet fragmentation
Date: Mon, 15 Jan 2018 14:57:46 +0100
Message-ID: <c5907a33-a653-a2d3-61ea-ac5c64d06318@pengutronix.de>
References: <20180115104141.4352-1-s.grosjean@peak-system.com>
 <51f04cfe-cb9f-b6f8-25a3-8d6df20dfbad@pengutronix.de>
 <VI1PR0302MB332549CCF19F5E36A661F7FFD6EB0@VI1PR0302MB3325.eurprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="BYAYDzzciYBFbcXn2Ovrn9w8kjZglJXdY"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33449 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967614AbeAON6I (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 15 Jan 2018 08:58:08 -0500
In-Reply-To: <VI1PR0302MB332549CCF19F5E36A661F7FFD6EB0@VI1PR0302MB3325.eurprd03.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?Q?St=c3=a9phane_Grosjean?= <s.grosjean@peak-system.com>, linux-can Mailing List <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BYAYDzzciYBFbcXn2Ovrn9w8kjZglJXdY
Content-Type: multipart/mixed; boundary="bg87yyN6211dC8nL1vI9xrQKrRgYY3YIV";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?UTF-8?Q?St=c3=a9phane_Grosjean?= <s.grosjean@peak-system.com>,
 linux-can Mailing List <linux-can@vger.kernel.org>
Message-ID: <c5907a33-a653-a2d3-61ea-ac5c64d06318@pengutronix.de>
Subject: Re: [PATCH] can: peak/usb: fix potential bug in packet fragmentation
References: <20180115104141.4352-1-s.grosjean@peak-system.com>
 <51f04cfe-cb9f-b6f8-25a3-8d6df20dfbad@pengutronix.de>
 <VI1PR0302MB332549CCF19F5E36A661F7FFD6EB0@VI1PR0302MB3325.eurprd03.prod.outlook.com>
In-Reply-To: <VI1PR0302MB332549CCF19F5E36A661F7FFD6EB0@VI1PR0302MB3325.eurprd03.prod.outlook.com>

--bg87yyN6211dC8nL1vI9xrQKrRgYY3YIV
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 01/15/2018 02:50 PM, St=C3=A9phane Grosjean wrote:
>=20
>=20
>> -----Original Message-----
>> From: Marc Kleine-Budde [mailto:mkl@pengutronix.de]
>> Sent: lundi 15 janvier 2018 13:53
>> To: St=C3=A9phane Grosjean <s.grosjean@peak-system.com>; linux-can Mai=
ling
>> List <linux-can@vger.kernel.org>
>> Subject: Re: [PATCH] can: peak/usb: fix potential bug in packet
>> fragmentation
>>
>> On 01/15/2018 11:41 AM, Stephane Grosjean wrote:
>>> In some rare conditions when running one PCAN USB FD interface other =
a
>>> non high-speed USB controller, one useless USB fragment might be sent=
=2E
>>> This patch fixes the way an USB command is fragmented when its length=

>>> if greater than 64 bytes and when the underlying USB controller is no=
t
>>> a high-speed one.
>>>
>>> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
>>> ---
>>>  drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 20 +++++++++++---------=

>>>  1 file changed, 11 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
>>> b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
>>> index 7ccdc3e30c98..2b03ef0e655d 100644
>>> --- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
>>> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
>>> @@ -184,7 +184,7 @@ static int pcan_usb_fd_send_cmd(struct
>> peak_usb_device *dev, void *cmd_tail)
>>>  void *cmd_head =3D pcan_usb_fd_cmd_buffer(dev);
>>>  int err =3D 0;
>>>  u8 *packet_ptr;
>>> -int i, n =3D 1, packet_len;
>>> +int packet_len;
>>>  ptrdiff_t cmd_len;
>>>
>>>  /* usb device unregistered? */
>>> @@ -201,17 +201,14 @@ static int pcan_usb_fd_send_cmd(struct
>> peak_usb_device *dev, void *cmd_tail)
>>>  }
>>>
>>>  packet_ptr =3D cmd_head;
>>> +packet_len =3D cmd_len;
>>>
>>>  /* firmware is not able to re-assemble 512 bytes buffer in full-spee=
d
>> */
>>> -if ((dev->udev->speed !=3D USB_SPEED_HIGH) &&
>>> -    (cmd_len > PCAN_UFD_LOSPD_PKT_SIZE)) {
>>> +if (unlikely(dev->udev->speed !=3D USB_SPEED_HIGH &&
>>> +     packet_len > PCAN_UFD_LOSPD_PKT_SIZE))
>>>  packet_len =3D PCAN_UFD_LOSPD_PKT_SIZE;
>>> -n +=3D cmd_len / packet_len;
>>> -} else {
>>> -packet_len =3D cmd_len;
>>> -}
>>
>> What about using min() instead of open coding it?
>=20
> The test is:
>=20
> If (a && (p > K)) then p =3D k;
>=20
> And you'd like me to change it into:
>=20
> If (a) then p =3D min(p, K);
>=20
> Right?

Yes... like this:

>> +       if (unlikely(dev->udev->speed !=3D USB_SPEED_HIGH))
>> +               packet_len =3D min(packet_len, PCAN_UFD_LOSPD_PKT_SIZE=
);

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--bg87yyN6211dC8nL1vI9xrQKrRgYY3YIV--

--BYAYDzzciYBFbcXn2Ovrn9w8kjZglJXdY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlpcs1oACgkQHv7KIOw4
HPbtzwf8COhyPeqIlspLGQjLw9PZZkEtpZ3kH4za3wX2G915QMq1UGt2Mj8drDj1
9BIMMEP2X7sd+zSnxdxWj7Qp9WpNcbtkH1TeslbbBCNkF2DLU7+q9Q2JQEfuBPQr
/5ZHv0Vpz+tlM4iPKjdE9n9/DH38pSg7JfaoPxWMXNSdIJM+FadOqtcls/bi2u7D
QILrCrNNZKSeW9cHy76Qn1FaGo704X3V+uANd19XLf5oo817EyhJVn3XusdXl8c0
cnoDQkM7nY82Q/r78M1ffmVfxGsSGxNGKNxI5CoLHGF+RfUnQ+WSatxw4mhhAva+
+AhaZaqVxAiwDSbYyOQLC6brp8Tavw==
=/Y0I
-----END PGP SIGNATURE-----

--BYAYDzzciYBFbcXn2Ovrn9w8kjZglJXdY--
