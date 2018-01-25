From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 4/4] j1939: remove proc support
Date: Thu, 25 Jan 2018 09:44:38 +0100
Message-ID: <cf9548ff-6d48-fd2b-3c62-a0ab5ed3b0d2@pengutronix.de>
References: <20180124110659.438-1-o.rempel@pengutronix.de>
 <20180124110659.438-4-o.rempel@pengutronix.de>
 <20180124201307.GB4214@airbook.vandijck-laurijssen.be>
 <20180124205026.fxnveeioxsbdhvie@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="bWgfAmNI5ew6kCRhOgs17XlXra5O8THdk"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58731 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751318AbeAYIpJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 25 Jan 2018 03:45:09 -0500
In-Reply-To: <20180124205026.fxnveeioxsbdhvie@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Robert Schwebel <r.schwebel@pengutronix.de>, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bWgfAmNI5ew6kCRhOgs17XlXra5O8THdk
Content-Type: multipart/mixed; boundary="AAGOXf0IcooCKr1WY8r8P3ZpGLmwct5Uk";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Robert Schwebel <r.schwebel@pengutronix.de>,
 Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
Message-ID: <cf9548ff-6d48-fd2b-3c62-a0ab5ed3b0d2@pengutronix.de>
Subject: Re: [PATCH 4/4] j1939: remove proc support
References: <20180124110659.438-1-o.rempel@pengutronix.de>
 <20180124110659.438-4-o.rempel@pengutronix.de>
 <20180124201307.GB4214@airbook.vandijck-laurijssen.be>
 <20180124205026.fxnveeioxsbdhvie@pengutronix.de>
In-Reply-To: <20180124205026.fxnveeioxsbdhvie@pengutronix.de>

--AAGOXf0IcooCKr1WY8r8P3ZpGLmwct5Uk
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 01/24/2018 09:50 PM, Robert Schwebel wrote:
> On Wed, Jan 24, 2018 at 09:13:07PM +0100, Kurt Van Dijck wrote:
>> I'm in favor of stripping all unnecessary, but ...
>=20
> The idea is to make it a step-by-step process: start with mainlining th=
e
> absolutely necessary parts, with interfaces where we actually know that=

> they are right. There might be other functionality which is helpful, bu=
t
> it can be added at a later point in time.
> =20
>>> Date:   Wed, 24 Jan 2018 12:06:59 +0100
>>> From: Oleksij Rempel <o.rempel@pengutronix.de>
>>>
>>> to make upstreaming more simple, remove procfs support.
>>>
>>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>>> ---
>>>  Documentation/networking/j1939.txt |  82 +----------------------
>>>  net/can/j1939/main.c               | 101 ---------------------------=
-
>>>  net/can/j1939/transport.c          | 131 +--------------------------=
----------
>>>  3 files changed, 5 insertions(+), 309 deletions(-)
>>>
>>> diff --git a/Documentation/networking/j1939.txt b/Documentation/netwo=
rking/j1939.txt
>>> index 08f7b035d821..d0e74df97baa 100644
>>> --- a/Documentation/networking/j1939.txt
>>> +++ b/Documentation/networking/j1939.txt
>>> @@ -36,18 +36,7 @@ This file contains
>>>      5.3 SO_J1939_RECV_OWN
>>>      5.4 SO_J1939_SEND_PRIO
>>> =20
>>> -  6 can-j1939 procfs interface
>>> -    6.1 /proc/net/can-j1939/ecu
>>> -    6.2 /proc/net/can-j1939/filter
>>> -    6.3 /proc/net/can-j1939/sock
>>> -    6.4 /proc/net/can-j1939/transport
>>
>> the ecu, filter & sock properties can be dropped, but huge transports,=

>> like those in IsoBUS, remain hidden from an application, but it may be=

>> usefull to indicate that a transfer is pending.
>> Such application relies on /proc/net/can-j1939/transport
>=20
> In fact we'll need an interface for that, but we are not convinced that=

> /proc is the right one: /proc is mainly for "human readable" informatio=
n
> or for debugging and not intended as an interface for software.
>=20
> Do you have an example that shows how this information is being used by=

> an application? That would be pretty helpful in order to learn about
> what the right interface might be (sysfs? netlink? ...)
>=20
>>> -  7 can-j1939 SYSCTL
>>> -    7.1 /proc/sys/net/can-j1939/transport_max_payload_in_bytes
>>> -    7.2 /proc/sys/net/can-j1939/transport_cts_nr_of_frames
>>> -    7.3 /proc/sys/net/can-j1939/transport_tx_retry_ms
>>
>> Those parameters shape the kernels behaviour on transport sessions.
>> It makes sense to configure them globally.
>> Should this be returned to module parameters then?

A module parameter is as global as a sysctl, ....

> Is this information really global? Or is it per interface? What happens=

> if you have a device with more than one CAN bus?
>=20
> It also might be good to be able to support network namespaces, so even=

> global information should be "per namespace" in that case.

=2E.. as long as we don't have namespace support. Then that would be a
sysctl per namespace.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--AAGOXf0IcooCKr1WY8r8P3ZpGLmwct5Uk--

--bWgfAmNI5ew6kCRhOgs17XlXra5O8THdk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlppmPYACgkQHv7KIOw4
HPZ0HAf/SnO7lkq4QAQ/1ARdXA52a8ZDy8467TG1OFMB1XifWsizueijhvMC/rh+
5bQqSYhbpHNMPh5z4NY9LjRx+OwlflFRTAZcXg2PMow85zfp9h/6Bev8f8heXkEe
Tj12Qr61EmXj0+w+w92eR4khTKmfS2OT5ZMTiuDYPGQ+xQMnmkBPF4tgGYPzlnuT
Erz4BEmv6tOl+HIlqbkS6JB9sdXay9oihnckddv3SQudyBHIhKzYaz5PeYbvmugB
FpFgbrtilRQ1oBByzqZ6onKQqu/xQO2IPfHeq2C4FuGMMATtlEhltflgROV3tzmP
TTk/O/zpWVQf8I8T013xHaHEheT7hg==
=0lOE
-----END PGP SIGNATURE-----

--bWgfAmNI5ew6kCRhOgs17XlXra5O8THdk--
