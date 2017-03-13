From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: at91 driver lost CAN messages
Date: Mon, 13 Mar 2017 14:11:58 +0100
Message-ID: <1b40816e-7102-739a-4738-30547d68b523@pengutronix.de>
References: <3f039cfd-cac1-3adb-77d2-87c5e67066f2@lipowsky.de>
 <ee9c0d9d-6cd6-f93b-2f2b-8306777781c3@hartkopp.net>
 <1cfeef11-69e0-53c1-f95a-0340cce5803e@pengutronix.de>
 <5e786553-271f-6fdc-3bd9-2422f93757f5@lipowsky.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="uX7Kin5CtakXtJx79ShgT5HHOwsOKvaDq"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:59177 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750959AbdCMNMG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 13 Mar 2017 09:12:06 -0400
In-Reply-To: <5e786553-271f-6fdc-3bd9-2422f93757f5@lipowsky.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Efim Monjak <emonjak@lipowsky.de>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uX7Kin5CtakXtJx79ShgT5HHOwsOKvaDq
Content-Type: multipart/mixed; boundary="2WWuRC0KRwncPlrCPvQd2txoCg1pn8Snh";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Efim Monjak <emonjak@lipowsky.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Message-ID: <1b40816e-7102-739a-4738-30547d68b523@pengutronix.de>
Subject: Re: at91 driver lost CAN messages
References: <3f039cfd-cac1-3adb-77d2-87c5e67066f2@lipowsky.de>
 <ee9c0d9d-6cd6-f93b-2f2b-8306777781c3@hartkopp.net>
 <1cfeef11-69e0-53c1-f95a-0340cce5803e@pengutronix.de>
 <5e786553-271f-6fdc-3bd9-2422f93757f5@lipowsky.de>
In-Reply-To: <5e786553-271f-6fdc-3bd9-2422f93757f5@lipowsky.de>

--2WWuRC0KRwncPlrCPvQd2txoCg1pn8Snh
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 01:55 PM, Efim Monjak wrote:
>>> In fact I always thought NAPI is too heavy for CAN controllers. NAPI =
was
>>> intended for a very high interrupt load on some ethernet controllers
>>> with some considerable RX FIFO.
>>>
>>> I have a 20 CAN interfaces (SJA1000 driver) Core i7 system receiving
>>> ~22.000 frames/s without any problems, with an one-element FIFO and
>>> without NAPI.
>>>
>>> @Marc: What was the reason to implement NAPI that days? Has it ever b=
een
>>> proved that NAPI had a remarkable positive effect in opposite to a
>>> direct CAN frame processing in the interrupt context?
>> On SMP systems the network stack doesn't seem to guarantee the order o=
f
>> frames when put into the stack in IRQ context.

> As I see Socketcan use a default queuing discipline pfifo_fast.
> This use 3 bands with different priorities, may be here is a problem?

No, queue disciplines are in the TX path, I was talking about RX.

> As I test my application I see a queue of about 163000 bytes can
> contain only 320 CAN frames. It seems the fifo is not configure for
> CAN frames though used PDU is 16 bytes.

Which queue do you mean exactly? Maybe it's the sum of skbs not the
can_frames.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--2WWuRC0KRwncPlrCPvQd2txoCg1pn8Snh--

--uX7Kin5CtakXtJx79ShgT5HHOwsOKvaDq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAljGmp4ACgkQHv7KIOw4
HPalrQf/ZH7P4+XYizsNa4ldoYXoAPqBvFnptoEaeK7IIWUTgzPVEHckasGfC/C/
FKXGgZ/azwzmIwTAjiO8mrm4uMJLNE0oOkxvzjc2BeKaF6fwmHN0Row8kbg47WmB
x/3zepR4dAtjDpZxa8xLR779SubhJQfdOWxNPhQq+bKV3Ih6pPLapN3meomSxJy/
/ZxM+74xXWAZ/j1eZIv6xSQIxMcSAdRXKIUiwaa4tHRererU0HPjZSFcC+RQrS23
sA+em9V2J14OHB2S+OjsxkJhBwbdnzQ8y0TlUPaQNeHe43RJYe3I4elH+FU2x6Pt
qyHLqJEqzKVaJS0PlNhUOvWti1vOcA==
=djaC
-----END PGP SIGNATURE-----

--uX7Kin5CtakXtJx79ShgT5HHOwsOKvaDq--
