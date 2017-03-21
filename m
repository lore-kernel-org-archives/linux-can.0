From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/3] can: m_can: Enable M_CAN IP version dependent
 initialization
Date: Tue, 21 Mar 2017 11:30:38 +0100
Message-ID: <e5834c2f-0860-1c34-c585-d9538852e760@pengutronix.de>
References: <1489154417-19669-1-git-send-email-mario.huettel@de.bosch.com>
 <1489154417-19669-4-git-send-email-mario.huettel@de.bosch.com>
 <4f1f7a6f-457f-b1f8-036e-745b5b2c48d5@hartkopp.net>
 <c3d26079-554b-104d-4836-825a8496b66f@de.bosch.com>
 <ffca3229-39f1-cc10-8086-72d7d94bdaef@hartkopp.net>
 <fe3184ee-6f56-33be-db57-4ecb5a9b1cad@hartkopp.net>
 <e04f267c-3f2d-50e6-0e94-982202c994e4@grandegger.com>
 <4e92ae71-e310-ff42-36fc-f734d9fe22c2@hartkopp.net>
 <167b6fb9-870c-60ca-2ae1-605bd8a0cd91@grandegger.com>
 <e4e32b30-8175-ae44-2afe-0f6099fcf963@hartkopp.net>
 <e9fd262d-7185-376d-6841-f66b460503cf@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="e3Wac3ujnF9PQBsHM4QefLgCul20xU3v0"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:51805 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752227AbdCUKvl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 21 Mar 2017 06:51:41 -0400
In-Reply-To: <e9fd262d-7185-376d-6841-f66b460503cf@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "Mario.Huettel" <Mario.Huettel@de.bosch.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--e3Wac3ujnF9PQBsHM4QefLgCul20xU3v0
Content-Type: multipart/mixed; boundary="iRkwSmBASFLIanjc8PJKH9dlJNDngjam6";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Wolfgang Grandegger <wg@grandegger.com>,
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "Mario.Huettel" <Mario.Huettel@de.bosch.com>, linux-can@vger.kernel.org
Message-ID: <e5834c2f-0860-1c34-c585-d9538852e760@pengutronix.de>
Subject: Re: [PATCH 2/3] can: m_can: Enable M_CAN IP version dependent
 initialization
References: <1489154417-19669-1-git-send-email-mario.huettel@de.bosch.com>
 <1489154417-19669-4-git-send-email-mario.huettel@de.bosch.com>
 <4f1f7a6f-457f-b1f8-036e-745b5b2c48d5@hartkopp.net>
 <c3d26079-554b-104d-4836-825a8496b66f@de.bosch.com>
 <ffca3229-39f1-cc10-8086-72d7d94bdaef@hartkopp.net>
 <fe3184ee-6f56-33be-db57-4ecb5a9b1cad@hartkopp.net>
 <e04f267c-3f2d-50e6-0e94-982202c994e4@grandegger.com>
 <4e92ae71-e310-ff42-36fc-f734d9fe22c2@hartkopp.net>
 <167b6fb9-870c-60ca-2ae1-605bd8a0cd91@grandegger.com>
 <e4e32b30-8175-ae44-2afe-0f6099fcf963@hartkopp.net>
 <e9fd262d-7185-376d-6841-f66b460503cf@grandegger.com>
In-Reply-To: <e9fd262d-7185-376d-6841-f66b460503cf@grandegger.com>

--iRkwSmBASFLIanjc8PJKH9dlJNDngjam6
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/19/2017 09:33 PM, Wolfgang Grandegger wrote:
> Am 19.03.2017 um 21:16 schrieb Oliver Hartkopp:
>>
>>
>> On 03/19/2017 08:12 PM, Wolfgang Grandegger wrote:
>>> Am 19.03.2017 um 18:43 schrieb Oliver Hartkopp:
>>
>>>>>>> If I understood the frame flow correctly the 'non originating' so=
cket
>>>>>>> receives two frames:
>>>>>>>
>>>>>>> 1. the frame from the completed TX operation (echo_skb / IFF_ECHO=
)
>>>>>>> 2. the frame received from the RX path from the hw loopback short=
cut
>>>>>
>>>>> Yep.
>>>>>
>>>>>>> I would suggest to drop the frame coming from the RX path (case 2=
)
>>>>>>> when
>>>>>>> the CAN_CTRLMODE_LOOPBACK gets enabled.
>>>>>
>>>>> Why? Mario, what is you motivation/use case?
>>>>
>>>> This was just my (Olivers) suggestion.
>>>>
>>>> The effect with CAN_CTRLMODE_LOOPBACK enabled would then be similar =
to
>>>> using a virtual CAN interface.
>>>>
>>>>>> Do we have an agreement on this?
>>>>>> Did we ever discuss this topic in this detailed manner before?
>>>>>
>>>>> As I see it, the CAN_CTRLMODE_LOOPBACK provides a internal hardware=

>>>>> loopback to test the send and receive software (including echo skb)=
=2E It
>>>>> has noting to to with echo skbs.
>>>>
>>>> Agreed.
>>>>
>>>> But the question is what happens to the IFF_ECHO 'mechanism' when th=
e
>>>> CAN controller is switched into CAN_CTRLMODE_LOOPBACK?
>>>
>>> Nothing special. The software does *not* known that the message was
>>> looped back by the hardware. The TX and RX is treated a usual.
>>>
>>>> Do we get a virtual CAN behavior (from IFF_ECHO on driver level) or =
do
>>>> we get IFF_ECHO AND a reception due to the controllers loopback?
>>>
>>> The latter: The echoed message when TX is done and the RX (from the
>>> hardware loopback).
>>
>> But this would be different to normal operation then!
>=20
> Depends on the intended usage. For testing if TX and RX software works =

> that's just fine.
>=20
>> When you have a second CAN interface on a real CAN bus that only ACKs
>> your frames but doesn't send own traffic, you only see your echo'ed
>> frames in the system (due to successful TX irq notification) - but no =
RX
>> frames.
>=20
> Using the loopback as a virtual CAN device came never into my mind.
>=20
>>>>> The loopback mode never got big
>>>>> attention. I think it's rarely used and if, then just for testing
>>>>> purposes. That's maybe the reason why this issue was never discusse=
d.
>>
>> So you vote for "The echoed message when TX is done and the RX (from t=
he
>> hardware loopback)." - which reflects the current implementation in
>> SJA1000 and M_CAN.
>>
>> But my question is:
>>
>> Are developers using CAN_CTRLMODE_LOOPBACK to
>>
>> 1. Run their CAN controller without a working CAN bus hardware
>> 2. To test the hardware loopback mode of the controller
>>
>> For case 1 the RX frames should be dropped and only the echo'ed frames=

>> should be provided to the system.
>=20
> Yes, feedback would really be useful.
>=20
> In the past I used it for the following purpose. After configuring and =

> starting the controller, I'm not able to get messages out to the bus or=
=20
> receive from it. To understand if it's a software or hardware problem, =
I=20
> switch to loopback mode. If it still doesn't work, it's software.

=46rom my point of view, the CAN_CTRLMODE_LOOPBACK mode should behave lik=
e
an external loopback connector, but controllable by software. Like a
short-circuit between RX and TX for RS232.

So you would receive the echo packges on TX and the "real" packages on
"RX". If you want a virtual CAN interface, make use of a vcan interace.

my 2=C2=A2,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--iRkwSmBASFLIanjc8PJKH9dlJNDngjam6--

--e3Wac3ujnF9PQBsHM4QefLgCul20xU3v0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAljRAM4ACgkQHv7KIOw4
HPaIpggAiROVunAQBnYkU1kv0mBShAmZB4K8/8BzEB9O+ca/I9mBkKD/hjVYSjZc
7P1hLwiIxxVb/bF8XYgI8UNpevbLVYZfmSXMi/Qs92kFk9GLTRtxVd9/xvqPnbOW
zli5QKkkTUdv9wta3UczxAips6Qdu8Y1225VeiZmY4X10oy7tcNU/n5fGyFV4z+X
frZpZDEgtY1lsBnFBUX/9EudPzGtIgNCd8gwucr+Usj6cCeaveYHeXjY4EZtX24B
5/vF/ytvUp/lE+t+WxuTOWJpiBhz1A0/GXPk/+GF2QeyWRxjtXsTbkkFsmODastF
9ubvVsQXQAs1K4stL+uflJrN9UcmVw==
=V9BT
-----END PGP SIGNATURE-----

--e3Wac3ujnF9PQBsHM4QefLgCul20xU3v0--
