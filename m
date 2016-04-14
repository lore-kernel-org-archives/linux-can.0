From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: bit-timing and sample point
Date: Thu, 14 Apr 2016 14:32:10 +0200
Message-ID: <570F8DCA.4090701@pengutronix.de>
References: <570E205B.7030900@pengutronix.de>
 <20160414102608.GC16018@airbook.vandijck-laurijssen.be>
 <570F7547.8030805@pengutronix.de>
 <20160414121932.GA7409@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="5FnDR17o0PP50ATCisv3QHCPo2167l7iI"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:47990 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754363AbcDNMcR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 14 Apr 2016 08:32:17 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
	by metis.ext.pengutronix.de with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
	(Exim 4.80)
	(envelope-from <mkl@pengutronix.de>)
	id 1aqgRS-0000S3-Rz
	for linux-can@vger.kernel.org; Thu, 14 Apr 2016 14:32:15 +0200
Received: from [IPv6:2001:6f8:105b:1122:eb:1158:b41e:d35] (hardanger [IPv6:2001:6f8:105b:1122:eb:1158:b41e:d35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Primary Intermediate Client CA" (verified OK))
	(Authenticated sender: mkl@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B9AE7115604
	for <linux-can@vger.kernel.org>; Thu, 14 Apr 2016 12:32:13 +0000 (UTC)
In-Reply-To: <20160414121932.GA7409@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5FnDR17o0PP50ATCisv3QHCPo2167l7iI
Content-Type: multipart/mixed; boundary="QEKnHkfsdns78xxxtHv8stvAsWigKESJS"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: linux-can <linux-can@vger.kernel.org>
Message-ID: <570F8DCA.4090701@pengutronix.de>
Subject: Re: bit-timing and sample point
References: <570E205B.7030900@pengutronix.de>
 <20160414102608.GC16018@airbook.vandijck-laurijssen.be>
 <570F7547.8030805@pengutronix.de>
 <20160414121932.GA7409@airbook.vandijck-laurijssen.be>
In-Reply-To: <20160414121932.GA7409@airbook.vandijck-laurijssen.be>

--QEKnHkfsdns78xxxtHv8stvAsWigKESJS
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/14/2016 02:19 PM, Kurt Van Dijck wrote:
>> :D - The original algorithm is a simple bute force algorithm. My
>> improvement is to check all sample points (if the bitrate doesn't matc=
h
>> 100%).
>>
>>>> I've changed the
>>>> algorithm to minimize first the bit rate error and then the sample p=
oint
>>>> error within the best bit rate.
>>>>
>>>> The old algorithm always picks a sample point less than the target
>>>> sample point. My question to the CAN exports: Is it better to stay b=
elow
>>>> the sample point or minimize the error (and pick a sample point slig=
htly
>>>> above the nominal sample point)?
>>>
>>> I haven't been doing this for a while :-)
>>
>> I've _never_ done this. :D
>>
>>> The sample point is not put to 100% since nodes are not guaranteed to=
 be
>>> completely in sync. This may interfere when "slightly" in your
>>> definition becomes more than expected. I'm not qualified anymore to
>>> quantify "slightly" in terms of bittiming, yet the sample point is
>>> specified to the back as far as possible for the wiring. Going "sligh=
tly"
>>> above 'eats' the margin you have there, the margin which you may not =
need
>>> for most wirings out there.
>>
>> This example illustrates the "slightly":
>>
>>>>>> nominal                                 real Bitrt   nom  real Sam=
pP
>>>>>> Bitrate TQ[ns] PrS PhS1 PhS2 SJW BRP Bitrate Error SampP SampP Err=
or BTR0 BTR1
>>>>>>  800000    180   2    2    2   1  12  793650  0.8% 80.0% 71.4% 10.=
8% 0x0b 0x13
>>>>>>  800000     90   5    5    3   1   6  793650  0.8% 80.0% 78.5%  1.=
9% 0x05 0x29
>>>>>>  800000     60   8    8    4   1   4  793650  0.8% 80.0% 80.9%  1.=
1% 0x03 0x3f
>>
>> For 800kbit/s the nominal sample point is 80%.
>> The original algorithm chooses 71.4%.
>> The improved (but stays below) chooses 78.5% (error=3D1.9%).
>> But there exists a sample point with a smaller error: 80.9% (error=3D1=
=2E1%).
>=20
> I understood the example :-)
> What I meant with "slightly" being hard to quantify was especially with=

> regard to the bus characteristics. What is the maximal propagation dela=
y
> on the bus?
> There is a point within a node's bit-time after which it is not certain=

> that remotes may have moved on to the next bit-time.
> If you allow samplepoint deviations to both sides, then you assume that=

> the advertised sample point is in the middle of the time fragment where=

> sampling is ideal. If you allow samplepoint deviations only to below,
> then you assume that the advertised sample point is the corner case and=

> raising it would introduce troubles.
> Both assumptions are wrong, the truth is in between, and the advertised=

> sample points mostly are "rules of thumb".
> IMHO, the assumption of going below only makes sense.
> Of course, you can (easily) find examples where the sample point may
> grow over it.
> If I understand the algoritm correctly, there's no limitation in how fa=
r
> beyond the advertised sample point you may get, as long as it's the
> closest. And there, I think, you should put a limit, and until someone
> comes up with a better one, I just take 0 as limit, meaning you go only=

> below :-)

Thanks for your thoughts I'll use algorithm 2 then.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--QEKnHkfsdns78xxxtHv8stvAsWigKESJS--

--5FnDR17o0PP50ATCisv3QHCPo2167l7iI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXD43KAAoJED07qiWsqSVq6FcH/3AcV31r6jRZEdZ9ONbS1VRi
K3v3gxYHe3j80eMg4ozU9er7v0VF6oC+RZz2JZ2t/83jeuIeOIDOwJeO0Qgf+Iqe
PuINI6cmwPIPJG6c0BUYhhSErF/Zj2LeoFOAcHOQvXH8OKjskpT/gUvSYCNofqu9
Wobe7CZRymTQoE3CnLlF2kE7gLTqLejGZABajfpN3SIjyZ+pq/UIPbVdwFM7Fzgp
oyZgjRqpyE26KGfFrTwPXMBrx9pQKVx48X3OuR0SAg1yB5qstF9t97a5ladOyr9W
UhDrOIcLMiHTHil65hqgsT8aes7l4Cij4q++/NRSwxthcvgK21IXae4gzlhJWV0=
=b+ha
-----END PGP SIGNATURE-----

--5FnDR17o0PP50ATCisv3QHCPo2167l7iI--
