From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 7/7 v8] can/peak_usb: add support for PEAK new CANFD USB
 adapters
Date: Thu, 22 Jan 2015 17:13:01 +0100
Message-ID: <54C1218D.80006@pengutronix.de>
References: <1421940266-6088-1-git-send-email-s.grosjean@peak-system.com> <1421940266-6088-8-git-send-email-s.grosjean@peak-system.com> <54C11A1B.4090100@pengutronix.de> <54C11E4A.3090303@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="g0tthVIMM49BcdeRldvjNb8Mg7SdP8hNP"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33041 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752499AbbAVQNQ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Jan 2015 11:13:16 -0500
In-Reply-To: <54C11E4A.3090303@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--g0tthVIMM49BcdeRldvjNb8Mg7SdP8hNP
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/22/2015 04:59 PM, Stephane Grosjean wrote:
>=20
> Le 22/01/2015 16:41, Marc Kleine-Budde a =C3=A9crit :
>> On 01/22/2015 04:24 PM, Stephane Grosjean wrote:
>>> Add support for the following new PEAK-System technik CANFD USB adapt=
ers:
>>>
>>> PCAN-USB FD             single CANFD channel USB adapter
>>> PCAN-USB Pro FD         dual CANFD channels USB adapter
>>>
>>> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
>>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> [...]
>>
>>> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net=
/can/usb/peak_usb/pcan_usb_fd.c
>>> new file mode 100644
>>> index 0000000..2129549
>>> --- /dev/null
>>> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
>> [...]
>>
>>> +/* handle device specific info used by the netdevices */
>>> +struct pcan_usb_fd_if {
>>> +	struct peak_usb_device *dev[PCAN_USB_MAX_CHANNEL];
>>> +	struct pcan_ufd_fw_info fw_info;
>>> +	struct peak_time_ref    time_ref;
>>> +	int                     cm_ignore_count;
>>> +	int                     dev_opened_count;
>> Please use tab for indention, not space.
>>
>>> +};
>>> +
>>> +/* device information */
>>> +struct pcan_usb_fd_device {
>>> +	struct peak_usb_device  dev;
>>> +	struct can_berr_counter bec;
>>> +	struct pcan_usb_fd_if  *usb_if;
>>> +	u8                     *cmd_buffer_addr;
>> dito
>>
>> Marc
>>
> Well, I'm afraid I have misunderstood one of your previous reMarks:
>=20
>> +/* device information */
>> +struct pcan_usb_fd_device {
>> +	struct peak_usb_device	dev;
>> +	struct pcan_usb_fd_if *	usb_if;
>> 	struct pcan_usb_fd_if *usb_if
>>> +
>>> +	u8 *	cmd_buffer_addr;
>> 	u8 *cmd_buffer_addr
>>> +
>>> +	uint	tx_error_counter;
>>> +	uint	rx_error_counter;
>> 	unsigned int
>>
>> Please don't use a tab after the struct foo, u8, unsinged int, etc...,=

>> as it doesn't align.
>>
>=20
> can u explain a bit more, please ? FYI, checkpatch.pl doesn't see any=20
> warning nor fatal in these indentations...

You have decided for indention in structs in your files, if you do so,
please use TABs consistently everywhere. (Or don't do indention at all.)

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--g0tthVIMM49BcdeRldvjNb8Mg7SdP8hNP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJUwSGYAAoJECte4hHFiupUF/gP/3Wrri6EkVr8UFFycVjVDkhU
iwgMJ27RTo77xffd1TsRq8/7B8n/OstxrbFAGsGeI/bb984jJWLaQxuKo+PgE3sd
rAAr0ovEGRev5SJ5vdcY5gmXo14hH7S5Qlzw8Yuui3NW2cX3RMwiDMtGTxgETo43
zha+I0SqtQmZ3T6C9QZWFXQXwOdRcoe0XQiXFzikdGTyO9jN0VA6CDDNBngiDDjy
EbU4h8buz66PPkvIReg82P4GycDZ51AckMPKzDT1poBd7z5X3pCdOBV8rXw1K++Q
HVrb6V/6BOtXSUHJmTXjSZM1J9EUNfy0RdTUc7krUUUhX5zn4+OOmNCm9SiPCZ9m
Xl3gFNYlYr9JJIpjfwoGSMn9HTm60C7xNMTxmgOVc1rgjhtr0p7sA7Vuyu5xWe74
OcMnPaom+hI0DtUZJMLcDPZgHkhKhyBzRFZcVTkSVO6AK5BtHYXx6TpLGa4VxRPi
pXVKV619dLueli+NYhM1INq6zV8YUHi+BA+6T4Y5mfZseeSmvtCVClIXjtX8GIC1
ziMOhFdxWmy19IFtzr3XhVX6L2LQ9Jizn/en8oNMMBFr0DAApCoFI4b0Jnu8V2Fr
K8L3JBYpD8ByDDLEy0zpqUlhlQ/Ot9z6Na4iriYwuLHwK3Kt/0aIjxq5FQylNo06
sqsnoD1cBwMhJ5CqvWb9
=leVY
-----END PGP SIGNATURE-----

--g0tthVIMM49BcdeRldvjNb8Mg7SdP8hNP--
