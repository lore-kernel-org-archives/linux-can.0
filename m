From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3] can: mcba_usb: Add support for Microchip CAN BUS
 Analyzer
Date: Fri, 14 Apr 2017 14:24:10 +0200
Message-ID: <1c65544f-e024-0243-2343-881f0790bcca@pengutronix.de>
References: <20170125130201.6432-1-remigiusz.kollataj@mobica.com>
 <51ef5231-673f-6a77-74ab-c0560b82ed27@pengutronix.de>
 <CAKT-o-d6bo075gkp_=t4LSKjw_WpH68G2wKQYNSOEP0F-sYNWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Rbxm1hKK6b5UppEuClQ7qhk5Q2ChE6DVE"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:33727 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750784AbdDNMYa (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 14 Apr 2017 08:24:30 -0400
In-Reply-To: <CAKT-o-d6bo075gkp_=t4LSKjw_WpH68G2wKQYNSOEP0F-sYNWA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?= <remigiusz.kollataj@mobica.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Rbxm1hKK6b5UppEuClQ7qhk5Q2ChE6DVE
Content-Type: multipart/mixed; boundary="vw5bASbWmXa76QBnUwPVSghb7kau6Uf7Q";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?=
 <remigiusz.kollataj@mobica.com>
Cc: linux-can@vger.kernel.org
Message-ID: <1c65544f-e024-0243-2343-881f0790bcca@pengutronix.de>
Subject: Re: [PATCH v3] can: mcba_usb: Add support for Microchip CAN BUS
 Analyzer
References: <20170125130201.6432-1-remigiusz.kollataj@mobica.com>
 <51ef5231-673f-6a77-74ab-c0560b82ed27@pengutronix.de>
 <CAKT-o-d6bo075gkp_=t4LSKjw_WpH68G2wKQYNSOEP0F-sYNWA@mail.gmail.com>
In-Reply-To: <CAKT-o-d6bo075gkp_=t4LSKjw_WpH68G2wKQYNSOEP0F-sYNWA@mail.gmail.com>

--vw5bASbWmXa76QBnUwPVSghb7kau6Uf7Q
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/14/2017 10:25 AM, Ko=C5=82=C5=82=C4=85taj, Remigiusz wrote:
> Hi Marc,
>=20
> Thanks for the review. My answers/comments inline.
>=20
> On 13 April 2017 at 17:56, Marc Kleine-Budde <mkl@pengutronix.de> wrote=
:
>>
>> On 01/25/2017 02:02 PM, Remigiusz Ko=C5=82=C5=82=C4=85taj wrote:
>>> SocketCAN driver for Microchip CAN BUS Analyzer
>>> (http://www.microchip.com/development-tools/)
>>>
>>> Changes since v2:
>>> - improved/simplified CAN ID conversion
>>> - functions for transmission of skb and cmd separated
>>> - fixed/improved netif_stop_queue handling
>>> - style/cosmetic corrections
>>>
>>> Changes since v1:
>>> - Termination handling reimplemented to fit new netlink API
>>> (IFLA_CAN_TERMINATION)
>>> - Bitrate handling reimplemented to fit new netlink API
>>> (IFLA_CAN_BITRATE)
>>> - CAN ID conversion refactored (changed from macro to inline function=
s)
>>> - CAN DLC handling using get_can_dlc()
>>> - Endianness handling for can_speed introduced
>>> - Debugging removed
>>> - Redundant error prints removed
>>> - Style/cosmetic corrections (i.e. macro names, redefs, inits etc.)
>>>
>>> Signed-off-by: Remigiusz Ko=C5=82=C5=82=C4=85taj <remigiusz.kollataj@=
mobica.com>
>>
>> Can you pleeas add LED support, see commit:
>>
>>     adccadb92f05 can: flexcan: add LED trigger support
>>
>> as an example. More comments inline.
>>
>=20
> In MBCA leds are controlled by device itself - CAN status leds are
> connected directly CANTX and CANRX pins of PIC controller and CAN
> Error led is driven by firmware.

With LED support in the driver, you can use CAN RX and/or TX events to
drive generic LEDs.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--vw5bASbWmXa76QBnUwPVSghb7kau6Uf7Q--

--Rbxm1hKK6b5UppEuClQ7qhk5Q2ChE6DVE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAljwv2oACgkQHv7KIOw4
HPaJ7wf9GNV/JUdUg7lS+F6JYkXacQUeTHxcH+xHPhgaqb/4t/EefY1T4f0df6Jy
D1+qkpBnvlN12ynEgSYk2Bjb+gr0EMgO50HF0W/pcIaqM+M/IFQCZq5p2t9qxpHw
i+kJ0WAdfIRHaW0yk/ehI1N7fD5AGS0skLu8fR8Gy8m5dIUC0YC+r+8Kv/H7dfo/
W2Hc7/tDpiRxc8M0JTGT/vM0VMfrxKHPvHs3z/BK0uNHLKm5rgdljpzGIsXPZ/lH
AVOc3lY+a6AneYxlqOFSkSTLwaDbM2Ngy0KI2ZBuls3d149dKgs2vnoJAFbAGKec
CyNjahNQDQ21lJipx80uPKnYCp7Szw==
=6H4j
-----END PGP SIGNATURE-----

--Rbxm1hKK6b5UppEuClQ7qhk5Q2ChE6DVE--
