From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RFC v2 0/7] pch_can/c_can: fix races and add PCH support to
 c_can
Date: Wed, 05 Dec 2012 22:52:38 +0100
Message-ID: <50BFC226.5030609@pengutronix.de>
References: <1354199987-10350-1-git-send-email-wg@grandegger.com> <2955657.EIGT0HjrVV@ws-stein> <50BF4326.4040507@grandegger.com> <4250988.UdN8LQq6de@ws-stein> <50BF85DD.6090809@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBE77F1814DD1041ED31A79F9"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42574 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752647Ab2LEVwn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 5 Dec 2012 16:52:43 -0500
In-Reply-To: <50BF85DD.6090809@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, linux-can@vger.kernel.org, bhupesh.sharma@st.com, tomoya.rohm@gmail.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBE77F1814DD1041ED31A79F9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/05/2012 06:35 PM, Wolfgang Grandegger wrote:
> On 12/05/2012 03:46 PM, Alexander Stein wrote:
>> Hello Wolfgang,
>>
>> On Wednesday 05 December 2012 13:50:46, Wolfgang Grandegger wrote:
>>> Hi Alexander,
>>>
>>> thanks for testing!. Maybe we deal with more than one problem.
>>>
> ...
>>> A few general questions to understand your hardware and setup:
>>>
>>> - Is this a multi-processor system (SMP)? If not, you may not run int=
o
>>>   tx-not-working-any-more problem. Have you ever realized it?
>>
>> This is a Intel E660 single core CPU with HT, so it is a SMP system. I=
'm=20
>> currently not aware that tx is not working anymore.
>=20
> OK, your send rate is very low and therefore it's unlikely that you hit=

> that problem.
>=20
>>> - Did you see the problems below with the old PCH_CAN driver as well.=

>>>
>>> - Do the problems show up with the still existing PCH_CAN driver
>>>   (including the "pch_can: add spinlocks to protect tx objects" patch=
)?
>>
>> With the current version of pch_can from Linuxs' tree and the named pa=
tch I=20
>> get at least some messaged twice.
>=20
> OK, sounds better but also not good.
>=20
>>>> but if I run my heavy CAN load testcase I get errors sometimes.
>>>> This test works as follows: I send a CAN message to 2 other CAN node=
s=20
>>>> configuring some timings (like burst length or time between each can=
=20
>> frame)=20
>>>> and they send 250000 messages each containing a counter. This way I =
can=20
>> detect=20
>>>> any missing or switched message with a high bus load.
>>>> If I use the described software state alone it works, but if I run '=
watch=20
>>>> sensors' in a different ssh session, CAN start to misbehave like mis=
sing=20
>> CAN=20
>>>> frames or switched order. It seems that I2C usage on the PCH influen=
ces=20
>> the=20
>>>> CAN part also:
>>>
>>> - When your app sends/writes messages, does it check for errno=3D=3DE=
NOBUFS?
>>
>> My test application sends only 1 message each test run to start the ot=
her=20
>> nodes. It checks ENOBUFS and returns an error in that case. Though I'v=
e never=20
>> seen that.
>=20
> OK, your TX rate it low.
>=20
>>
>>> - The messages look still ok (not currupted, I mean)?
>>
>> The received frames all look good (despite wrong counter sometimes due=
 to=20
>> wrong order or lost frames).
>>
>>>> Even worse, if I use the following patch to check if PCI writes were=
=20
>>>> successfully, I notices that some writes (or the consecutive read) d=
on't=20
>>>> succeed. And I also get lots of I2C timeouts waiting for a xfer comp=
lete.
>>>
>>> Be careful, there might be some registers changing their values after=

>>> writing. Can you show the value read after writing and the register
>>> offset? The influence on the I2C bus looks more like an overload or
>>> hardware problem. What is your CAN interrupt rate?
>>
>> I get about 33 interrupts per second on i2c. On a successful run I get=
 366886=20
>> interrupts for 500000 messages with the c_can driver.
>=20
> In what time? Is the CAN bus highly loaded.
>=20
>> Here are some failed writes to the CAN controller.
>> [   50.445695] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x4 f=
ailed.=20
>> got: 0x10
>> [   51.043027] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 f=
ailed.=20
>> got: 0x0
>> [... repeats several times]
>> [   64.046031] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 f=
ailed.=20
>> got: 0x0
>> [   64.458286] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24=
 failed.=20
>> got: 0xb8
>> [   64.811025] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 f=
ailed.=20
>> got: 0x0
>> and the last one is repeated all the time.
>=20
> That's wired! Writing 0xe to offset 0x0 does re-enable the interrupts a=
t
> the end of poll-rx. Disabling the interrupts in the isr does not show
> that symptoms. Strange.

The write+read check is racy. The interrupt handler might disable the
interrupts again.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigBE77F1814DD1041ED31A79F9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlC/wiYACgkQjTAFq1RaXHPPhwCfXG1ywFDGPb3XT2Hd3lP06kQU
vyMAn17zYe/ayltRTbXmtoVmrzWWN7qb
=qNQF
-----END PGP SIGNATURE-----

--------------enigBE77F1814DD1041ED31A79F9--
