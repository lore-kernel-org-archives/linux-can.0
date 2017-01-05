From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 4/4] can: peak: add support for PEAK PCAN-PCIe FD CAN-FD
 boards
Date: Thu, 5 Jan 2017 15:14:20 +0100
Message-ID: <02a382a6-5fbc-c5e9-6b3e-d681a72a64f6@pengutronix.de>
References: <1481207924-28977-1-git-send-email-s.grosjean@peak-system.com>
 <1481207924-28977-5-git-send-email-s.grosjean@peak-system.com>
 <4b5d6e27-0680-81b8-66f3-f5ff219eab45@pengutronix.de>
 <421a8a25-b808-1771-63dc-df3cb7431f9b@peak-system.com>
 <ed0777b9-6abd-3015-fd96-3cf79ed7d8d8@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="3d7T3IilN97P5aCcd312ectnu74mOX43B"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:37903 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S937043AbdAEOO5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Jan 2017 09:14:57 -0500
In-Reply-To: <ed0777b9-6abd-3015-fd96-3cf79ed7d8d8@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3d7T3IilN97P5aCcd312ectnu74mOX43B
Content-Type: multipart/mixed; boundary="16aAISoCX1otax5bBh1Q0rsRw6eJGSBRn";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
 Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>
Message-ID: <02a382a6-5fbc-c5e9-6b3e-d681a72a64f6@pengutronix.de>
Subject: Re: [PATCH 4/4] can: peak: add support for PEAK PCAN-PCIe FD CAN-FD
 boards
References: <1481207924-28977-1-git-send-email-s.grosjean@peak-system.com>
 <1481207924-28977-5-git-send-email-s.grosjean@peak-system.com>
 <4b5d6e27-0680-81b8-66f3-f5ff219eab45@pengutronix.de>
 <421a8a25-b808-1771-63dc-df3cb7431f9b@peak-system.com>
 <ed0777b9-6abd-3015-fd96-3cf79ed7d8d8@hartkopp.net>
In-Reply-To: <ed0777b9-6abd-3015-fd96-3cf79ed7d8d8@hartkopp.net>

--16aAISoCX1otax5bBh1Q0rsRw6eJGSBRn
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/05/2017 03:06 PM, Oliver Hartkopp wrote:
> Hello Stephane,
>=20
> On 01/05/2017 02:52 PM, Stephane Grosjean wrote:
>=20
>>>> +
>>>> +    /* put skb in rx queue as echo */
>>>> +    netif_rx(skb);
>>> Please wait until you get a tx-complete interrupt until you echo the =
skb.
>> No "tx-complete" IRQ is provided by the hw but an "LNK record
>> encountered by the reader" interrupt only: this LNK record is put at t=
he
>> end of a 2K DMA page by the writer, to link this page to the next one.=
 I
>> don't imagine saving the N * CAN msgs the page might contain, in some
>> temporary memory until getting (sometimes in the future) this kind of
>> IRQ, for, finally echoing all of these ones in a row, do you?
>>
>=20
> The IFF_ECHO functionality providing the correct timestamp when the CAN=
=20
> frame is seen on the bus is a vital functionality.
>=20
> When you use some reading instance on your host system (e.g. candump)=20
> the CAN frames should be in order and with the correct timestamps to=20
> represent the correct content on the CAN bus. No matter whether you are=
=20
> only reading from the bus or sending with another application.
>=20
> Would it make sense to reduce the number of CAN frames that are pushed =

> into the CAN controller at a time?

As far as I understand the interrupt is triggered when the page is full.
This happens after n messages.

On the other hand, can you put a LNK record after each TX frame in the pa=
ge?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--16aAISoCX1otax5bBh1Q0rsRw6eJGSBRn--

--3d7T3IilN97P5aCcd312ectnu74mOX43B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEES2FAuYbJvAGobdVQPTuqJaypJWoFAlhuVLwACgkQPTuqJayp
JWqj6wf/dc8hQmx8gibhiosHU9txAVr2Y9frYmWKPNKxR3FsJksWMEEQq7v/dCau
SDIUCVwC6rKtyV6C1Cz0dP1IsP67a0ZGH/mV7nM3ygGE1FeE0G3wwWd1VSSJdHo0
pM0MuFBR1GP1VHtrSZCyly4OPADhmiMD1JC4+5rEH+tO9tr56i8hl57WTUDbGVkh
xYwdfgzGAViH/nG2iL4nnExUkKjZsN8v90OSchah0IzOjI8u8MmSXCiokgWVxoEf
u+T6Q50+36of88hd3UTox6Xneu8ZVj/BBYMRYcoA1/7Cu4hQF7AQADzF6A9WxJU8
or/JucYb+b+wj6lswXXx4lTZB/3McA==
=iEsD
-----END PGP SIGNATURE-----

--3d7T3IilN97P5aCcd312ectnu74mOX43B--
