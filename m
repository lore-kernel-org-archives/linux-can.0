From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: bit-timing and sample point
Date: Wed, 13 Apr 2016 12:32:59 +0200
Message-ID: <570E205B.7030900@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="C9DDCxgq7GFlgoxuxar7BUWLvO78AAGwQ"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:44280 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932517AbcDMKdG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 13 Apr 2016 06:33:06 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
	by metis.ext.pengutronix.de with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
	(Exim 4.80)
	(envelope-from <mkl@pengutronix.de>)
	id 1aqI6a-00075k-Fb
	for linux-can@vger.kernel.org; Wed, 13 Apr 2016 12:33:04 +0200
Received: from [IPv6:2001:6f8:105b:1122:24df:9500:877e:8803] (hardanger [IPv6:2001:6f8:105b:1122:24df:9500:877e:8803])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Primary Intermediate Client CA" (verified OK))
	(Authenticated sender: mkl@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 164BE114A8F
	for <linux-can@vger.kernel.org>; Wed, 13 Apr 2016 10:33:03 +0000 (UTC)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--C9DDCxgq7GFlgoxuxar7BUWLvO78AAGwQ
Content-Type: multipart/mixed; boundary="DeH7v57jof7GcdEB9wLSwRKHa9Lu2iTd2"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: linux-can <linux-can@vger.kernel.org>
Message-ID: <570E205B.7030900@pengutronix.de>
Subject: bit-timing and sample point

--DeH7v57jof7GcdEB9wLSwRKHa9Lu2iTd2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

currently I'm reworking the bit timing algorithm. I've changed the
algorithm to minimize first the bit rate error and then the sample point
error within the best bit rate.

The old algorithm always picks a sample point less than the target
sample point. My question to the CAN exports: Is it better to stay below
the sample point or minimize the error (and pick a sample point slightly
above the nominal sample point)?

See the below table for the output of the calculation. There are three
entries per bit rate:
1) original algorithm
2) improved algorithm, smaple point is always below nominal sample point
3) improved algorithm, sample point error is minimized

> Bit timing parameters for mscan with 66.666666 MHz ref clock
> nominal                                 real Bitrt   nom  real SampP
> Bitrate TQ[ns] PrS PhS1 PhS2 SJW BRP Bitrate Error SampP SampP Error BT=
R0 BTR1
> 1000000     90   3    4    3   1   6 1010101  1.0% 75.0% 72.7%  3.1% 0x=
05 0x26
> 1000000     90   3    4    3   1   6 1010101  1.0% 75.0% 72.7%  3.1% 0x=
05 0x26
> 1000000     45   8    8    5   1   3 1010101  1.0% 75.0% 77.2%  2.9% 0x=
02 0x4f

>  800000    180   2    2    2   1  12  793650  0.8% 80.0% 71.4% 10.8% 0x=
0b 0x13
>  800000     90   5    5    3   1   6  793650  0.8% 80.0% 78.5%  1.9% 0x=
05 0x29
>  800000     60   8    8    4   1   4  793650  0.8% 80.0% 80.9%  1.1% 0x=
03 0x3f

>  500000    285   2    2    2   1  19  501253  0.3% 87.5% 71.4% 18.4% 0x=
12 0x13
>  500000    105   7    8    3   1   7  501253  0.3% 87.5% 84.2%  3.8% 0x=
06 0x2e
>  500000    105   8    8    2   1   7  501253  0.3% 87.5% 89.4%  2.2% 0x=
06 0x1f

>  250000    570   2    2    2   1  38  250626  0.3% 87.5% 71.4% 18.4% 0x=
25 0x13
>  250000    285   5    6    2   1  19  250626  0.3% 87.5% 85.7%  2.1% 0x=
12 0x1a
>  250000    285   5    6    2   1  19  250626  0.3% 87.5% 85.7%  2.1% 0x=
12 0x1a

Which algorithm is preferred?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--DeH7v57jof7GcdEB9wLSwRKHa9Lu2iTd2--

--C9DDCxgq7GFlgoxuxar7BUWLvO78AAGwQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXDiBbAAoJED07qiWsqSVqKMcH/1kEJFaOMQMBgpyJZ1CiBWm8
F/HhMNSyxx9SgresfNpoP2oashlkwaaSsu2aaq2Dg7rQXO5HJV/jQxjaZGs3TrWE
3jc5v6WrkWc2QVT2HwSYog4lIbKY3EOMY7ZNHW+yNYeTOJR3FW9bj5a98DuH3Qz3
5YO/6Qc5Lt3pNP/ZuhaIytsGmci/qa/W4HE+2gs4N1klM8iPw0eUtQC1NVVWAR1v
uK6Gh+lZGapA6q5xEzik80SCEf1BXwWxsR6QUtE8XUX+zyMtZWCU8g37o9uvkM09
sjn8gn+WrU3U1jbvyn7MEfrdfM7zfBMVN2hPUbJy+Na6enWhsaC8eaweDeHgfQ4=
=JDUF
-----END PGP SIGNATURE-----

--C9DDCxgq7GFlgoxuxar7BUWLvO78AAGwQ--
