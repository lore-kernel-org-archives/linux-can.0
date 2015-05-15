From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Linux board with 10 CANs
Date: Fri, 15 May 2015 11:11:07 +0200
Message-ID: <5555B82B.2010204@pengutronix.de>
References: <5555A6A3.7090206@orange.fr>
 <CAGm1_ktyE_CjFwEfi1M48hDxM58HMJNAhQgYC3-8ivJ6AgE1WQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="OUB1j5FuuhNAgo2vG7kGSTl1fQjajX5fO"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48619 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919AbbEOJLW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 15 May 2015 05:11:22 -0400
in-reply-to: <CAGm1_ktyE_CjFwEfi1M48hDxM58HMJNAhQgYC3-8ivJ6AgE1WQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Yegor Yefremov <yegorslists@googlemail.com>, =?UTF-8?Q?Fran=c3=a7ois_Beaulier?= <fbeaulier@orange.fr>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OUB1j5FuuhNAgo2vG7kGSTl1fQjajX5fO
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/15/2015 10:20 AM, Yegor Yefremov wrote:
> On Fri, May 15, 2015 at 9:56 AM, Fran=C3=A7ois Beaulier <fbeaulier@oran=
ge.fr> wrote:
>> Hi,
>>
>> I'm starting the design of a CPU board, based on a computer on module =
with a
>> very common SOC like i.mx6 or am335x.
>> I need to fit my board with at least 10 CAN ports, may be more. (The S=
OC
>> have 2 CANs so i need 8 more)
>> The board will run with Linux and of course i want a socketcan interfa=
ce for
>> each bus !
>> CAN bitrate needed is quite low (50kbps) and latency is not critical b=
ut bus
>> load may reach 100% sometimes.
>> As far as possible i want to avoid driver development, or just doing s=
light
>> modifications on an existing driver.
>> I don't want to use MCP2515, i had trouble with it on a previous desig=
n
>> because of the lack of buffer in the chip.
>> I can't imagine putting 8 MCP2515 and not missing any frame, but may b=
e i'm
>> wrong ?
>>
>> Here are the options i have considered, they involve using external MC=
Us to
>> provide enough CAN interfaces :
>>
>> - MCUs with SLCAN : SLCAN have the advantage of simplicity and it shou=
ld
>> offer enough performance at low data rate. Problem is that it would re=
quire
>> 8 UARTS. I could modify SLCAN driver to allow multiple CAN channels on=
 the
>> same UART, and so use MCUs with multiple CANs, does it sounds reasonab=
le ?
>>
>> - MCUs with SPI 1 : adapt MCP2515 driver in a way to make the SPI prot=
ocol
>> manageable on the MCU side (SPI slave). The MCU will be able to provid=
e the
>> buffer for CAN frames that the MCP does not have. This option is just =
a way
>> of trying to go fast, it is not very elegant, and have the limitation =
of one
>> CAN channel per SPI connection / driver instance.
>>
>> - MCUs with SPI 2 : use the Stefano Babic SPI driver posted on this li=
st.
>> This is probably the best choice for a long term and more generic solu=
tion.
>> But i'm afraid it may require too much work to complete. What is the s=
tatus
>> of this driver right now ? Does anyone have an idea of the remaining w=
ork to
>> do to make it ready for mainline ? Stefano are you available to spend =
more
>> time on it ? I'm also wondering whether multiple instances of the driv=
er can
>> run concurently if i put more than one MCU ?
>>
>> Concerning the MCU software i could release it as an open-source proje=
ct,
>> anyone interested in participating ?
>> I'm very familiar with STM32 MCUs so i will probably use an STM32F072 =
(low
>> cost cortex M0 with one CAN).
>>
>> Any idea or advice is welcome, thank you for reading this much too lon=
g
>> post.
>=20
> Is it possible to attach 8 SJA1000s over local bus? The driver is
> already in mainline kernel.

Don't use the mcp251x.

If you have PCIe, there are some dual CAN modules (available in miniPIC,
too). But PCIe ist probably quite cost intensive. USB would be an
option, but I'm not sure if there are modules that can be
connected/soldered to a PCB. As Yegor said, SJA1000s + a CPLD are an
option, too, but IIRC the SJA1000 has a 5V IO interface.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--OUB1j5FuuhNAgo2vG7kGSTl1fQjajX5fO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJVVbgrAAoJEP5prqPJtc/HTKQH/1egy/ojBNj30VxLsC2XRUZD
l+t15+1DyWtuo4H3+zpjuEimfpaY80j+eTljnxHattKkxPKR/GCLDhpiP51/Ux8a
entDJvfZCP/tFmCQTEKqQUGL8+ZTuuz5fKH+0RlIRm/92/v5kAHPjde6jDHKagII
qRO9NWyNf6XyqDCLT5iewsRtxPM2etrni0uiaMIfepQ5Pb/YXml3KUqE+zdcNkMk
qF2oxSJI/g4RDV86RLIbbUh0mm0YrkWMM5A8oPkgTB+jaHXZcTARaxkVQJ9a1bxE
obZYYoHMFrXQDpwcweIaeP1dMpxhWXuM/8WEMBSXQtGCga5/SeKlYnxOFKGo7Fk=
=M2k9
-----END PGP SIGNATURE-----

--OUB1j5FuuhNAgo2vG7kGSTl1fQjajX5fO--
