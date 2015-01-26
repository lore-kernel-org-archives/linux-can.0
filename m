From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 7/7 v9] can/peak_usb: add support for PEAK new CANFD USB
 adapters
Date: Mon, 26 Jan 2015 22:08:13 +0100
Message-ID: <54C6ACBD.2020806@pengutronix.de>
References: <1422009085-11858-1-git-send-email-s.grosjean@peak-system.com> <1422009085-11858-8-git-send-email-s.grosjean@peak-system.com> <54C64633.9080204@pengutronix.de> <54C65912.5020309@peak-system.com> <54C659C0.4040207@pengutronix.de> <54C66063.9050500@peak-system.com> <54C6628D.7010902@pengutronix.de> <54C6ABE1.8000504@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="j8qB5cc1DNuiFkwXffPaSrfnvth3wBuJ2"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47455 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755187AbbAZVIU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 Jan 2015 16:08:20 -0500
In-Reply-To: <54C6ABE1.8000504@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Stephane Grosjean <s.grosjean@peak-system.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--j8qB5cc1DNuiFkwXffPaSrfnvth3wBuJ2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/26/2015 10:04 PM, Oliver Hartkopp wrote:
> On 26.01.2015 16:51, Marc Kleine-Budde wrote:
>> On 01/26/2015 04:42 PM, Stephane Grosjean wrote:
>>> Le 26/01/2015 16:14, Marc Kleine-Budde a =C3=A9crit :
>>>> On 01/26/2015 04:11 PM, Stephane Grosjean wrote:
>>>>> Hi Mark,
>>>>>
>>>>> Well, the ISO/non-ISO feature is not available for all USB devices =
and
>>>>> is currently always under development.
>>>>> So, we think that it's a bit early to add it in the peak_usb driver=
=2E
>>>> Which mode do the controller support then?
>>>>
>>>> Marc
>>>>
>>> Current versions of the fw run in non-ISO mode.
>>
>> So we have to set .ctrlmode =3D CAN_CTRLMODE_FD_NON_ISO, analogue to
>>
>>      6cfda7fbebe8 can: m_can: tag current CAN FD controllers as non-IS=
O
>=20
> Ack.
>=20
>>
>> e.g.:
>>
>> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/ne=
t/can/usb/peak_usb/pcan_usb_core.c
>> index b2f2694d7d5b..d00bc094b91d 100644
>> --- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
>> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
>> @@ -799,6 +799,7 @@ static int peak_usb_create_dev(struct peak_usb_ada=
pter *peak_usb_adapter,
>>          dev->can.do_set_data_bittiming =3D peak_usb_set_data_bittimin=
g;
>>          dev->can.do_set_mode =3D peak_usb_set_mode;
>>          dev->can.do_get_berr_counter =3D peak_usb_adapter->do_get_ber=
r_counter;
>> +       dev->can.ctrlmode =3D peak_usb_adapter->ctrlmode;
>>          dev->can.ctrlmode_supported =3D peak_usb_adapter->ctrlmode_su=
pported;
>>
>>          netdev->netdev_ops =3D &peak_usb_netdev_ops;
>> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/ne=
t/can/usb/peak_usb/pcan_usb_core.h
>> index 7c213b26f3fb..a8a71ebaa0b4 100644
>> --- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
>> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
>> @@ -46,6 +46,7 @@ struct peak_usb_device;
>>   struct peak_usb_adapter {
>>          char *name;
>>          u32 device_id;
>> +       u32 ctrlmode;
>>          u32 ctrlmode_supported;
>>          struct can_clock clock;
>>          const struct can_bittiming_const bittiming_const;
>> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/=
can/usb/peak_usb/pcan_usb_fd.c
>> index 8aad8f79fc1b..73c4be840dc7 100644
>> --- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
>> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
>> @@ -960,6 +960,7 @@ struct peak_usb_adapter pcan_usb_fd =3D {
>>          .name =3D "PCAN-USB FD",
>>          .device_id =3D PCAN_USBFD_PRODUCT_ID,
>>          .ctrl_count =3D PCAN_USBFD_CHANNEL_COUNT,
>> +       .ctrlmode =3D CAN_CTRLMODE_FD_NON_ISO,
>>          .ctrlmode_supported =3D CAN_CTRLMODE_FD |
>>                          CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENO=
NLY,
>>          .clock =3D {
>> @@ -1028,6 +1029,7 @@ struct peak_usb_adapter pcan_usb_pro_fd =3D {
>>          .name =3D "PCAN-USB Pro FD",
>>          .device_id =3D PCAN_USBPROFD_PRODUCT_ID,
>>          .ctrl_count =3D PCAN_USBPROFD_CHANNEL_COUNT,
>> +       .ctrlmode =3D CAN_CTRLMODE_FD_NON_ISO,
>>          .ctrlmode_supported =3D CAN_CTRLMODE_FD |
>>                          CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENO=
NLY,
>>          .clock =3D {
>>
>> Correct, Oliver?
>=20
> No.
>=20
> I assume it is better to set the ctrlmode directly in the struct can_pr=
iv=20
> element in  pcan_usb_fd_init() after retrieving the firmware version.

Even better.

> IMO it doesn't make sense to transport this info through the mechanic a=
bove=20
> which mostly initialized quasi constant settings for the adapter.

If we check the firmware version, it doesn't make sende to put the
information into that struct (IMHO)

> +/* describes the PCAN-USB Pro FD adapter */
> +struct peak_usb_adapter pcan_usb_pro_fd =3D {
>=20
> be
>=20
> +/* describes the PCAN-USB Pro FD adapter */
> +const struct peak_usb_adapter pcan_usb_pro_fd =3D {

Yes, but it probably needs some more modifications in the driver.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--j8qB5cc1DNuiFkwXffPaSrfnvth3wBuJ2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJUxqzAAAoJECte4hHFiupUXx8P/0mEkxsWKpOW/gx18LeKU4Q7
gLegLKpOuXjKpSQNQDqWBAyZ3QLR6a1WrA1N1BkrSqP7OyuJAb2Jj/mAgpOMPvwh
vbSk0A8l00oHszY732dkZc7pevGS85l6nexNxfQZ/kmp9xzGbFu7oQJmvl+1ZtdC
qHA4n5+KWLi1IzgimNXtRxrgn8T3IpMTzELxssi3vk2+rAY4x0PoNToL76UtuKkA
JD92RXLRTAZGqr/nAPrl6x3EWBQHvY9Vp6Pkjki60PeR/TlP5o7yCmhYhJyusD4/
UhMNGUBfZTCd54bDSQ3e1ZR64AU1cri98VTS5B3JSr6WSJPAd/BmH3WIZmKOnbGF
6vkoU4jqlB1ii9efFLFCJsqvvdoEulHLZLSQl8PGrBlTddelDCWKov5DzUx0LmvO
XR5WPuKUHzpLo1jbgwZ5SK5b3ykIc6wcbFHZbGzFDZVd6EpQ6dtGAno3+mSxYEf7
C6boY9tPkXF3gujZWCjEc9d93C6J2NxiY2BGRfstw6u22zQtzkqBom6qjy44rOzk
iUURjLQnZsIhNvM4VnvFhSj7RK0QagLepj0u6PBL3LdSswE2nDe/4cR8FI2KLsoJ
VIL1/ZuN68CkiUsbGtdCTKojhqKaiQXX6cGYAMPgvuBNlQxiYVfBCus4NKl99jwU
aqlGuOd+bUBAe7/QO/Ln
=N3oQ
-----END PGP SIGNATURE-----

--j8qB5cc1DNuiFkwXffPaSrfnvth3wBuJ2--
