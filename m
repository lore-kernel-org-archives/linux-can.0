From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: AW: [BULK]Re: Linux board with 10 CANs
Date: Fri, 15 May 2015 15:17:46 +0200
Message-ID: <5555F1FA.6000305@pengutronix.de>
References: <5555A6A3.7090206@orange.fr>
 <CAGm1_ktyE_CjFwEfi1M48hDxM58HMJNAhQgYC3-8ivJ6AgE1WQ@mail.gmail.com>
 <5555B82B.2010204@pengutronix.de> <5555BD6A.60204@orange.fr>
 <20150515102450.24212.89893@shannon> <5555E93A.7080507@orange.fr>
 <5555EAC6.8010901@pengutronix.de>
 <005401d08f0f$a3b9f960$eb2dec20$@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="SP2vIsjCL8QQVr4jBL0MAdclbBSFuj7fq"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51651 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945915AbbEONR7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 15 May 2015 09:17:59 -0400
in-reply-to: <005401d08f0f$a3b9f960$eb2dec20$@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Uwe Wilhelm (PEAK-System)" <u.wilhelm@peak-system.com>, =?UTF-8?Q?'Fran=c3=a7ois_Beaulier'?= <fbeaulier@orange.fr>, 'Andri Yngvason' <andri.yngvason@marel.com>, 'Yegor Yefremov' <yegorslists@googlemail.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SP2vIsjCL8QQVr4jBL0MAdclbBSFuj7fq
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/15/2015 03:04 PM, Uwe Wilhelm (PEAK-System) wrote:
>=20
>=20
>> -----Urspr=C3=BCngliche Nachricht-----
>> Von: linux-can-owner@vger.kernel.org [mailto:linux-can-
>> owner@vger.kernel.org] Im Auftrag von Marc Kleine-Budde
>> Gesendet: Freitag, 15. Mai 2015 14:47
>> An: Fran=C3=A7ois Beaulier; Andri Yngvason; Yegor Yefremov
>> Cc: linux-can@vger.kernel.org
>> Betreff: [BULK]Re: Linux board with 10 CANs
>>
>> On 05/15/2015 02:40 PM, Fran=C3=A7ois Beaulier wrote:
>>>> Have you considered FPGA?
>>>>
>>>> Andri
>>> I don't know much about FPGA, i can see in the kernel that there are
>>> c_can and m_can drivers, i guess i have to add something like a PCIe
>>
>> c_can and m_can are IP cores by bosch, they are used in various SoCs.
>>
>>> bridge to connect the CAN controllers with the SOC ?
>>> Is there a way to use FPGA that would not lead to driver development =
?
>>> Do you have any link where i can learn more about Linux + FPGA + CAN =
?
>>
>> You have to use an IP core that is already supported by the kernel.
>>
>> Marc
>> --
>=20
> PEAK offer a 2 and a 4 CAN Channel FPGA Solution which support Socket C=
AN. =20
> A 12 Channel CAN card build with this Core is running under a Military =
Label=20
> without any problem with nearly 100% Busload per Channel / 1 Mbit
> But you need 3 free PCIe 1x Lanes. Cost are cheap, because you only pay=
 License,=20

That is 3 IP-Core instances with 4 Channels/1 PCIe Lane each?

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--SP2vIsjCL8QQVr4jBL0MAdclbBSFuj7fq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJVVfH6AAoJEP5prqPJtc/HqQUH/1ZY8NQkb4ag+AnXiB7nD6I/
409aOEZEm7igwxxJ/T4hRWRw9XaFsLNRdoPMwq7/cZMxRsMmRvDrmvDkYPt5MQMH
oJAPWzVF/aRg9KPqUAhdMTod7nRw2YNr9LW0Sw0U2cNajJ5jG9HuhzFIyLUtqZiG
6jrJhueEAcwjY1+E/zks7H3/vc8enScCYdpfg/WO5paCrJr6VqvsX30aw/iAzrXj
xFW+2Af8uBWQttn2KlAy5IwwXbZPLSIf3aPvXNqOOX1lvPsndTP/WJ7w5yzxKpeb
Zd/jISSJ6p6kKyfYJNDaEvmcMg5ZRT/IXHs19tX53otpnl/wRf5/v7mq3/1vqJ8=
=jamU
-----END PGP SIGNATURE-----

--SP2vIsjCL8QQVr4jBL0MAdclbBSFuj7fq--
