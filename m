From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 7/7 v8] can/peak_usb: add support for PEAK new CANFD USB
 adapters
Date: Thu, 22 Jan 2015 17:24:03 +0100
Message-ID: <54C12423.5060009@pengutronix.de>
References: <1421940266-6088-1-git-send-email-s.grosjean@peak-system.com> <1421940266-6088-8-git-send-email-s.grosjean@peak-system.com> <54C11A1B.4090100@pengutronix.de> <54C11E4A.3090303@peak-system.com> <54C1218D.80006@pengutronix.de> <54C122FC.9030806@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="rRn7IxPjgr5rVXsQtJP5TrVQ8xxcGGV2e"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35116 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100AbbAVQYK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Jan 2015 11:24:10 -0500
In-Reply-To: <54C122FC.9030806@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Stephane Grosjean <s.grosjean@peak-system.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rRn7IxPjgr5rVXsQtJP5TrVQ8xxcGGV2e
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/22/2015 05:19 PM, Oliver Hartkopp wrote:
>=20
>=20
> On 22.01.2015 17:13, Marc Kleine-Budde wrote:
>> On 01/22/2015 04:59 PM, Stephane Grosjean wrote:
>>>
>>> Le 22/01/2015 16:41, Marc Kleine-Budde a =C3=A9crit :
>>>> On 01/22/2015 04:24 PM, Stephane Grosjean wrote:
>>>>> Add support for the following new PEAK-System technik CANFD USB ada=
pters:
>>>>>
>>>>> PCAN-USB FD             single CANFD channel USB adapter
>>>>> PCAN-USB Pro FD         dual CANFD channels USB adapter
>>>>>
>>>>> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
>>>>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>>>> [...]
>>>>
>>>>> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/n=
et/can/usb/peak_usb/pcan_usb_fd.c
>>>>> new file mode 100644
>>>>> index 0000000..2129549
>>>>> --- /dev/null
>>>>> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
>>>> [...]
>>>>
>>>>> +/* handle device specific info used by the netdevices */
>>>>> +struct pcan_usb_fd_if {
>>>>> +	struct peak_usb_device *dev[PCAN_USB_MAX_CHANNEL];
>>>>> +	struct pcan_ufd_fw_info fw_info;
>>>>> +	struct peak_time_ref    time_ref;
>>>>> +	int                     cm_ignore_count;
>>>>> +	int                     dev_opened_count;
>>>> Please use tab for indention, not space.
>>>>
>>>>> +};
>>>>> +
>>>>> +/* device information */
>>>>> +struct pcan_usb_fd_device {
>>>>> +	struct peak_usb_device  dev;
>>>>> +	struct can_berr_counter bec;
>>>>> +	struct pcan_usb_fd_if  *usb_if;
>>>>> +	u8                     *cmd_buffer_addr;
>>>> dito
>>>>
>>>> Marc
>>>>
>>> Well, I'm afraid I have misunderstood one of your previous reMarks:
>>>
>>>> +/* device information */
>>>> +struct pcan_usb_fd_device {
>>>> +	struct peak_usb_device	dev;
>>>> +	struct pcan_usb_fd_if *	usb_if;
>>>> 	struct pcan_usb_fd_if *usb_if
>>>>> +
>>>>> +	u8 *	cmd_buffer_addr;
>>>> 	u8 *cmd_buffer_addr
>>>>> +
>>>>> +	uint	tx_error_counter;
>>>>> +	uint	rx_error_counter;
>>>> 	unsigned int
>>>>
>>>> Please don't use a tab after the struct foo, u8, unsinged int, etc..=
=2E,
>>>> as it doesn't align.
>>>>
>>>
>>> can u explain a bit more, please ? FYI, checkpatch.pl doesn't see any=

>>> warning nor fatal in these indentations...
>>
>> You have decided for indention in structs in your files, if you do so,=

>> please use TABs consistently everywhere. (Or don't do indention at all=
=2E)
>>
>=20
> I thought between the data type and the variable name is just sonly one=
 single=20
> space.

I prefer a single space, but tab is okay. But if do indention then use
tabs consistently.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--rRn7IxPjgr5rVXsQtJP5TrVQ8xxcGGV2e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJUwSQmAAoJECte4hHFiupUanQP/jdha3ZV4Y1JErWI4KD4/Uac
2e2K39SDpiqn3OU4ZCUJc6nsbvAmHvN5eFzAJGG8cORU19hfnbhK16OJ7oAPvPPL
hDuFg4WVDeO+vCBY7oVRH8F5xvZBVWSRpEyz5RrFyH27brDgIrDNvJj4Rf24fPgV
gZ4ruHlQ1STNcOOq3u7gFYL0YFtQxrNwYLzYXZeHYuRPDxEWF/yYvgqJfnIP6eNy
N3WKnvuqvVG/IbBRAb94VzKVDxXkUX6G7c5u9413xCusVq4x5RVL1nsJ4LIB0tqH
8TQMvpE3e85z8LExAuLkokbCiHKsGZ899/rQbukatti56ltRlImimAnjolb+7DfN
O23XLSG6xOijV7Kbv33MgbbzPcK5cdTTRhhvNfOA+f98U+Q9uj4NozJYJx8DXLqO
IEWXaoaUCCAIgjxXFLEJ3NBtq6yp5RFDjrC3b4L60ttkkdtfsbj07bw7IJLDGHvW
en9bG6ZDj1MNQvRl91B07EhdHak4GfscoM2cIvi11qzJgZCm6K/k7fOM79ItoB7n
H7hLX9SjLQMEBKtM17fEfX6l9qijvk1oSC9+qq7hZ++t27/EmX8XJjm37mzD6LoP
5HhJfWFW8yv26Lv/8Taf551DJeX9Akg5xxLMKAPmBcSR1jtF+TEtrEGx5kEXZeMu
b5SSR46VIEHVxiMqeklB
=B+tU
-----END PGP SIGNATURE-----

--rRn7IxPjgr5rVXsQtJP5TrVQ8xxcGGV2e--
