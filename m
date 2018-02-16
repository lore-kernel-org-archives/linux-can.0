From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 1/2] can: kvaser_usb: Simplify struct
 kvaser_msg_cardinfo
Date: Fri, 16 Feb 2018 11:38:49 +0100
Message-ID: <afeb955d-9140-991d-ad76-07e43d30d81a@pengutronix.de>
References: <20180216091337.13924-1-jimmyassarsson@gmail.com>
 <588ce8c3-5a21-b678-50b2-a9d9d6949d63@pengutronix.de>
 <a925cc41-9719-1bad-ae75-0a9e8b7dde24@kvaser.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="nh1i9wCZ03eBiV6KCTZKFj7xDN65if9Xm"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60667 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933559AbeBPKjh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 16 Feb 2018 05:39:37 -0500
In-Reply-To: <a925cc41-9719-1bad-ae75-0a9e8b7dde24@kvaser.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Jimmy Assarsson <extja@kvaser.com>, Jimmy Assarsson <jimmyassarsson@gmail.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nh1i9wCZ03eBiV6KCTZKFj7xDN65if9Xm
Content-Type: multipart/mixed; boundary="Rn9xF8ncOtmkvZ9atT7Q8velFi1502rs5";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jimmy Assarsson <extja@kvaser.com>,
 Jimmy Assarsson <jimmyassarsson@gmail.com>, linux-can@vger.kernel.org
Message-ID: <afeb955d-9140-991d-ad76-07e43d30d81a@pengutronix.de>
Subject: Re: [PATCH v2 1/2] can: kvaser_usb: Simplify struct
 kvaser_msg_cardinfo
References: <20180216091337.13924-1-jimmyassarsson@gmail.com>
 <588ce8c3-5a21-b678-50b2-a9d9d6949d63@pengutronix.de>
 <a925cc41-9719-1bad-ae75-0a9e8b7dde24@kvaser.com>
In-Reply-To: <a925cc41-9719-1bad-ae75-0a9e8b7dde24@kvaser.com>

--Rn9xF8ncOtmkvZ9atT7Q8velFi1502rs5
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 02/16/2018 11:32 AM, Jimmy Assarsson wrote:
> On 2018-02-16 11:24, Marc Kleine-Budde wrote:
>> On 02/16/2018 10:13 AM, Jimmy Assarsson wrote:
>>> serial_number_high can be removed from the struct since it is never u=
sed in
>>> the USBcan II firmware.
>>>
>>> Signed-off-by: Jimmy Assarsson <jimmyassarsson@gmail.com>
>>> ---
>>> Changes in v2:
>>>    - Made this a separate patch.
>>>
>>>   drivers/net/can/usb/kvaser_usb.c | 16 ++++------------
>>>   1 file changed, 4 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/k=
vaser_usb.c
>>> index 63587b8e6825..ee10beaa5da3 100644
>>> --- a/drivers/net/can/usb/kvaser_usb.c
>>> +++ b/drivers/net/can/usb/kvaser_usb.c
>>> @@ -196,19 +196,11 @@ struct kvaser_msg_simple {
>>>   struct kvaser_msg_cardinfo {
>>>   	u8 tid;
>>>   	u8 nchannels;
>>> -	union {
>>> -		struct {
>>> -			__le32 serial_number;
>>> -			__le32 padding;
>>> -		} __packed leaf0;
>>> -		struct {
>>> -			__le32 serial_number_low;
>>> -			__le32 serial_number_high;
>>> -		} __packed usbcan0;
>>> -	} __packed;
>>> +	__le32 serial_number;
>>> +	__le32 padding0;
>>>   	__le32 clock_resolution;
>>>   	__le32 mfgdate;
>>> -	u8 ean[8];
>>> +	u32 ean[2];
>>
>> Nitpick: This doesn't belong into this patch. Please use __le32 instea=
d
>> of u32.
>=20
> Oh, my bad. Should I post an updated version of the patch?

Please send a v3.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Rn9xF8ncOtmkvZ9atT7Q8velFi1502rs5--

--nh1i9wCZ03eBiV6KCTZKFj7xDN65if9Xm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlqGtLkACgkQk9IU1zQo
ZfGMwwgAtIYse445NczIIecLP/sl9cX76Ao/LYdbCT+FPr7cCQQ/UheAEy0dwvE3
iE+ijdUOLGyCxs4FUxAdh7GtrY1dclfnmCoIl+H0PaxKDHnQRAMDQ2DrtdsoDbzK
YbVxlDS/V45auFbltpx1yD0x/J92bIADg/4HSPepGcXqpo3LDhtZX0JQDoh9X16m
uO96BVgSgnsmM8Mjvd3/u+MRzHC7wPIFjzxDZ/ZPY/SqPPQYcGTgk6+0w4H79ue6
TTz4gRN9uhsuMY50InliNF6LAredDnww/JIQL8pzOfNtul6vwzrJKVEfWgH843jg
zBclToBhiZxnb8vZmy08YIg6/DpBQw==
=VFiV
-----END PGP SIGNATURE-----

--nh1i9wCZ03eBiV6KCTZKFj7xDN65if9Xm--
