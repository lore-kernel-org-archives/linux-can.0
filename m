From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v4] can/peak_usb: add support for PEAK new CANFD USB adapters
Date: Tue, 13 Jan 2015 14:29:25 +0100
Message-ID: <54B51DB5.2030707@pengutronix.de>
References: <1420538446-8336-1-git-send-email-s.grosjean@peak-system.com> <54AD66C5.10908@pengutronix.de> <54B51B2C.3080404@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="KLJ5k54VFarR4pJCQJKtX8ARkuNBwmS4S"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43303 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285AbbAMN3g (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 13 Jan 2015 08:29:36 -0500
In-Reply-To: <54B51B2C.3080404@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KLJ5k54VFarR4pJCQJKtX8ARkuNBwmS4S
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/13/2015 02:18 PM, Stephane Grosjean wrote:
> Hi Marc,
>=20
> Le 07/01/2015 18:03, Marc Kleine-Budde a =C3=A9crit :
>> On 01/06/2015 11:00 AM, Stephane Grosjean wrote:
>>   @@ -750,9 +795,10 @@ static int peak_usb_create_dev(struct
>> peak_usb_adapter *peak_usb_adapter,
>>       dev->can.clock =3D peak_usb_adapter->clock;
>>       dev->can.bittiming_const =3D &peak_usb_adapter->bittiming_const;=

>>       dev->can.do_set_bittiming =3D peak_usb_set_bittiming;
>> +    dev->can.data_bittiming_const =3D
>> &peak_usb_adapter->data_bittiming_const;
>> +    dev->can.do_set_data_bittiming =3D peak_usb_set_data_bittiming;
>>       dev->can.do_set_mode =3D peak_usb_set_mode;
>> -    dev->can.ctrlmode_supported =3D CAN_CTRLMODE_3_SAMPLES |
>> -                      CAN_CTRLMODE_LISTENONLY;
>> +    dev->can.ctrlmode_supported =3D peak_usb_adapter->ctrlmode_suppor=
ted;
>> All ctrlmode_supported can go into a seperate patch.
>=20
> I'll try but can you please explain why?

Because it's a separate feature. Making the review easier.

[...]

>> What about the following hunks (but not the .ctrlmode_supported) ? The=
y
>> can go into a seperate patch which comes first?
>=20
> So. You want me to do a serie of patches, right?
> - a first patch that would change the existing files
> - another one that would add the ctrl_mode_supported chanegs
> - another one that would add the new files

It's not about existing and new files. A patch should handle a single
topic and be easy to review. If something can be separated it should.

For example, adding the ctrl_mode_supported for the existing adapters
would be such a feature. Making the functions in pcan_usb_pro.c non
static, moving the #defines and adding the function declarations to
pcan_usb_pro.h is another preparation patch, so that the final patch,
that adds the new adapter is smaller and thus easier to review.

>>> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
>>> b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
>>> index 4cfa3b8..a764045 100644
>>> --- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
>>> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
>>> @@ -27,14 +27,6 @@
>>>     MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB Pro adapter");
>>>   -/* PCAN-USB Pro Endpoints */
>>> -#define PCAN_USBPRO_EP_CMDOUT        1
>>> -#define PCAN_USBPRO_EP_CMDIN        (PCAN_USBPRO_EP_CMDOUT |
>>> USB_DIR_IN)
>>> -#define PCAN_USBPRO_EP_MSGOUT_0        2
>>> -#define PCAN_USBPRO_EP_MSGIN        (PCAN_USBPRO_EP_MSGOUT_0 |
>>> USB_DIR_IN)
>>> -#define PCAN_USBPRO_EP_MSGOUT_1        3
>>> -#define PCAN_USBPRO_EP_UNUSED        (PCAN_USBPRO_EP_MSGOUT_1 |
>>> USB_DIR_IN)
>>> -
>>>   #define PCAN_USBPRO_CHANNEL_COUNT    2
>>>     /* PCAN-USB Pro adapter internal clock (MHz) */
>>> @@ -322,8 +314,8 @@ static int pcan_usb_pro_wait_rsp(struct
>>> peak_usb_device *dev,
>>>       return (i >=3D PCAN_USBPRO_RSP_SUBMIT_MAX) ? -ERANGE : err;
>>>   }
>=20
>>>   +extern int pcan_usb_pro_probe(struct usb_interface *intf);
>>> +extern int pcan_usb_pro_send_req(struct peak_usb_device *dev, int
>>> req_id,
>>> +                                         int req_value, void *req_ad=
dr,
>>> +                         int req_size);
>>> +extern void pcan_usb_pro_restart_complete(struct urb *urb);
>> IIRC we're killing the "extern" in function definitions in the kernel.=

>=20
> Ok. So I remove all "extern" keywords even from existing files, right?

Up to you, this probably would be another patch. However, please don't
add new "extern"s :)

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--KLJ5k54VFarR4pJCQJKtX8ARkuNBwmS4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUtR24AAoJECte4hHFiupUxswP/RipE4z5Y4OCf17LUpzJn/BG
q6veUZPMU9uX48nEOkf1sNrn6nu9DNa2qgbT8KaszTq8R4X0xEh6MFHFoQ8iZu+G
CzWfg8kuWMdcHPRbic6Hd60tGbBNg2M6GZk09PyIwl84I9z5tkhgiVKgNjiJo6Di
oqpk01R9t5GHIHii7qz5HtIJozRkEyABwf+08Kp1a4MZ+vZlaU+N/b87AlaqVjo7
BSz7ergndYLqOkTi0bzrjQ3pBxddjzfjw3ECWZn4rHsUlpsyL5M9R4LvoZRwUHQU
Jb4VRWgUbS7bUcNvFf53UjWaqRyc/1Ujp94CO32pFIctIfzub/juHDXgaRO8inOy
QuTUlR60SVWQffdQ5+eYSfLiYP1xOH3HyC+j6OflxG4LmWlTM4mVnMbp2Bo4YzRZ
w355OXAecoZtHDfjCXVWNxhYslgOhUtLLL4NqV4Hdp5jsajFCufyY/V8aZmeAKTT
NfnBt60P9KaPDy7v6EWpdRNvJuyQfkXXYW0tGoUCKeqUn0RnslGgfXy1wEzK4xX7
D2Of+QFVWvyPqL7g7gUQ/R3egb2voXoANsfIgjp0hiCkGNOass8RMbWZmQxRJlqR
E96YKMS+zglPupsUV0FesDxKRe5lpXSIQf3brcKP1HzxqxYAhmaAFOxCiNHNOM35
7skhZm+CQvU2si0uIgV9
=dY5o
-----END PGP SIGNATURE-----

--KLJ5k54VFarR4pJCQJKtX8ARkuNBwmS4S--
