From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: CAN implementation on A20 Allwinner
Date: Thu, 27 Aug 2015 16:37:12 +0200
Message-ID: <55DF2098.4020105@pengutronix.de>
References: <2d24e34ceb8e4fe4b0b7c74b9a36da44@SGPMBX1006.APAC.bosch.com>
 <54770F0F.7050904@hartkopp.net>
 <369acf6bdf8b4ae3840b69bef10b5082@SGPMBX1004.APAC.bosch.com>
 <21623.28007.620480.114111@gargle.gargle.HOWL>
 <58243.88.153.236.115.1417116776.squirrel@webmail.rdts.de>
 <58560.88.153.236.115.1417118037.squirrel@webmail.rdts.de>
 <547DB29B.4070601@pengutronix.de>
 <a3cdd6d97480f7b31a53e94169f8a1eb@mail.rdts.de>
 <55DF0F39.10507@pengutronix.de>
 <c05ac4c76aad5f8e94cb98960ccfbc43@mail.rdts.de>
 <55DF1580.3070806@pengutronix.de>
 <8a0d66b660360693b2b9b4ae7da78cd4@mail.rdts.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="xmrL7JESwJmxDDQMEgERlrakwloVn9j1F"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50282 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752689AbbH0OhW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 27 Aug 2015 10:37:22 -0400
In-Reply-To: <8a0d66b660360693b2b9b4ae7da78cd4@mail.rdts.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
Cc: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>, Pankajkumar Misra <pankaj.kumar@in.bosch.com>, linux-can@vger.kernel.org, linux-can-owner@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xmrL7JESwJmxDDQMEgERlrakwloVn9j1F
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/27/2015 04:29 PM, Gerhard Bertelsmann wrote:
>>> Some regs also have a different address
>>
>> Which one? How may?
>=20
> here a quick overview (not a complete list):
>=20
>    original    address    Allwinner
> SJA1000_MOD    0x00   CAN_MOD_SEL    OK
> SJA1000_CMR    0x01   CAN_CMD_REG    OK
> SJA1000_SR     0x02   CAN_STA_REG    OK but 24 bit (more values)
> SJA1000_IR     0x03   CAN_INT_REG    OK
> SJA1000_IER    0x04   CAN_INTE_REG   OK
>                 0x05   CAN_BUS_TIME   NOK also 24 bit
> SJA1000_BTR0   0x06   CAN_TEWL       NOK CAN TX error warn limit reg
> SJA1000_BTR1   0x07   CAN_ERRC       NOK CAN error counter register
> SJA1000_OCR    0x08   CAN_RMCNT      NOK CAN receive message count reg
>=20
> SJA1000_ALC    0x0B                  NOK
> SJA1000_ECC    0x0C                  NOK
> SJA1000_EWL    0x0D                  NOK
> SJA1000_RXERR  0x0E                  NOK
> SJA1000_TXERR  0x0F                  NOK
> SJA1000_ACCC0  0x10   CAN_AC0        OK  Reset mode: CAN_ACP_CODE but 3=
2=20
> bit
> SJA1000_ACCC1  0x11   CAN_AM0        NOK Reset mode: CAN_ACP_CODE 32 bi=
t
> SJA1000_ACCC2  0x12   CAN_TRBUF2     NOK CAN TX/RX mbuffer 2 reg
> SJA1000_ACCC3  0x13   CAN_TRBUF3     NOK CAN TX/RX mbuffer 3 reg
> SJA1000_ACCM0  0x14   CAN_TRBUF4     NOK CAN TX/RX mbuffer 4 reg
> SJA1000_ACCM1  0x15   CAN_TRBUF5     NOK CAN TX/RX mbuffer 5 reg
> SJA1000_ACCM2  0x16   CAN_TRBUF6     NOK CAN TX/RX mbuffer 6 reg
> SJA1000_ACCM3  0x17   CAN_TRBUF7     NOK CAN TX/RX mbuffer 7 reg
> SJA1000_RMC    0x1D   CAN_TRBUF8     NOK CAN TX/RX mbuffer 8 reg
> SJA1000_RBSA   0x1E   CAN_TRBUF9     NOK CAN TX/RX mbuffer 9 reg
>=20
> more differences than similarities ... A sja1000 module with "quirks"=20
> makes
> no sense to me.

ACK

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--xmrL7JESwJmxDDQMEgERlrakwloVn9j1F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJV3yCYAAoJEP5prqPJtc/HabgIALrkqS4gKwMuptxiFOO69O58
DNvD9mfj0tvioYSQRQo8vrKa8FBvQnLHmDVbWWFaFT/65/HKQ+LLwRhrybpNSxQz
gDZ4NWjTPzr6ACvbgoS3pkksbBJsRlHDSX7CWQNUFiyTs1qYIpcF+noRq1S3uQ66
Un0uaJwrsdDMnukKrWnLpbZIFeHSPnUKfr2UHOMdGyF/kkv/uarBlJmmF/wINSGL
8CRw1bziE8tTs/eJx0msGeeUAQ9gUJUX+t6VyIv/zISrHxdtYxUshQ8uBtpbbbRN
5wCwTVqItQ/zYHpI5hZtqtCPNBpBCtq8JuU2kJDjI+0efh4vGvvewxHoL9FHGHY=
=N5OK
-----END PGP SIGNATURE-----

--xmrL7JESwJmxDDQMEgERlrakwloVn9j1F--
