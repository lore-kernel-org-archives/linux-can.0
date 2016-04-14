From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: bit-timing and sample point
Date: Thu, 14 Apr 2016 12:47:35 +0200
Message-ID: <570F7547.8030805@pengutronix.de>
References: <570E205B.7030900@pengutronix.de>
 <20160414102608.GC16018@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="lOn2dbulAak3mRNwkIR8RnP4iqwh0uEQT"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:42663 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753756AbcDNKrr (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 14 Apr 2016 06:47:47 -0400
In-Reply-To: <20160414102608.GC16018@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>
Cc: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lOn2dbulAak3mRNwkIR8RnP4iqwh0uEQT
Content-Type: multipart/mixed; boundary="hPONbjFgxERVC6lUGctVIlL7KpWi4iEbi"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: linux-can <linux-can@vger.kernel.org>
Cc: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Message-ID: <570F7547.8030805@pengutronix.de>
Subject: Re: bit-timing and sample point
References: <570E205B.7030900@pengutronix.de>
 <20160414102608.GC16018@airbook.vandijck-laurijssen.be>
In-Reply-To: <20160414102608.GC16018@airbook.vandijck-laurijssen.be>

--hPONbjFgxERVC6lUGctVIlL7KpWi4iEbi
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/14/2016 12:26 PM, Kurt Van Dijck wrote:
>> currently I'm reworking the bit timing algorithm.
> Waauw, that's ambitious.

:D - The original algorithm is a simple bute force algorithm. My
improvement is to check all sample points (if the bitrate doesn't match
100%).

>> I've changed the
>> algorithm to minimize first the bit rate error and then the sample poi=
nt
>> error within the best bit rate.
>>
>> The old algorithm always picks a sample point less than the target
>> sample point. My question to the CAN exports: Is it better to stay bel=
ow
>> the sample point or minimize the error (and pick a sample point slight=
ly
>> above the nominal sample point)?
>=20
> I haven't been doing this for a while :-)

I've _never_ done this. :D

> The sample point is not put to 100% since nodes are not guaranteed to b=
e
> completely in sync. This may interfere when "slightly" in your
> definition becomes more than expected. I'm not qualified anymore to
> quantify "slightly" in terms of bittiming, yet the sample point is
> specified to the back as far as possible for the wiring. Going "slightl=
y"
> above 'eats' the margin you have there, the margin which you may not ne=
ed
> for most wirings out there.

This example illustrates the "slightly":

>>>> nominal                                 real Bitrt   nom  real SampP=

>>>> Bitrate TQ[ns] PrS PhS1 PhS2 SJW BRP Bitrate Error SampP SampP Error=
 BTR0 BTR1
>>>>  800000    180   2    2    2   1  12  793650  0.8% 80.0% 71.4% 10.8%=
 0x0b 0x13
>>>>  800000     90   5    5    3   1   6  793650  0.8% 80.0% 78.5%  1.9%=
 0x05 0x29
>>>>  800000     60   8    8    4   1   4  793650  0.8% 80.0% 80.9%  1.1%=
 0x03 0x3f

For 800kbit/s the nominal sample point is 80%.
The original algorithm chooses 71.4%.
The improved (but stays below) chooses 78.5% (error=3D1.9%).
But there exists a sample point with a smaller error: 80.9% (error=3D1.1%=
).

The error is calculated by:

    abs(nominal_sample_point - real_sample_point)
    ---------------------------------------------
                 nominal_sample_point

While iterating algorithm 3 picks configurations with "sample point
error" < "smallest sample point error so far". Algorithm 2 has an
additional "sample point < nominal sample point" to keep the
characteristics of the original algorithm. This code snippet shows the
algorithm 2:

> +               if ((spt <=3D spt_target) && (spt_error < best_spt_erro=
r)) {
> +                       best_spt =3D spt;
> +                       best_spt_error =3D spt_error;
> +                       *tseg1_ptr =3D tseg1;
> +                       *tseg2_ptr =3D tseg2;
> +               }

Algo 3 doesn't have the "(spt <=3D spt_target) && ".

>> See the below table for the output of the calculation. There are three=

>> entries per bit rate:
>> 1) original algorithm
>> 2) improved algorithm, smaple point is always below nominal sample poi=
nt
>> 3) improved algorithm, sample point error is minimized
>>
>>> Bit timing parameters for mscan with 66.666666 MHz ref clock
>>> nominal                                 real Bitrt   nom  real SampP
>>> Bitrate TQ[ns] PrS PhS1 PhS2 SJW BRP Bitrate Error SampP SampP Error =
BTR0 BTR1
>>> 1000000     90   3    4    3   1   6 1010101  1.0% 75.0% 72.7%  3.1% =
0x05 0x26
>>> 1000000     90   3    4    3   1   6 1010101  1.0% 75.0% 72.7%  3.1% =
0x05 0x26
>>> 1000000     45   8    8    5   1   3 1010101  1.0% 75.0% 77.2%  2.9% =
0x02 0x4f
>>
>>>  800000    180   2    2    2   1  12  793650  0.8% 80.0% 71.4% 10.8% =
0x0b 0x13
>>>  800000     90   5    5    3   1   6  793650  0.8% 80.0% 78.5%  1.9% =
0x05 0x29
>>>  800000     60   8    8    4   1   4  793650  0.8% 80.0% 80.9%  1.1% =
0x03 0x3f
>>
>>>  500000    285   2    2    2   1  19  501253  0.3% 87.5% 71.4% 18.4% =
0x12 0x13
>>>  500000    105   7    8    3   1   7  501253  0.3% 87.5% 84.2%  3.8% =
0x06 0x2e
>>>  500000    105   8    8    2   1   7  501253  0.3% 87.5% 89.4%  2.2% =
0x06 0x1f
>>
>>>  250000    570   2    2    2   1  38  250626  0.3% 87.5% 71.4% 18.4% =
0x25 0x13
>>>  250000    285   5    6    2   1  19  250626  0.3% 87.5% 85.7%  2.1% =
0x12 0x1a
>>>  250000    285   5    6    2   1  19  250626  0.3% 87.5% 85.7%  2.1% =
0x12 0x1a
>>
>> Which algorithm is preferred?
>=20
> I prefer (2).
> The improvement over (1) is significant!!

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--hPONbjFgxERVC6lUGctVIlL7KpWi4iEbi--

--lOn2dbulAak3mRNwkIR8RnP4iqwh0uEQT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXD3VHAAoJED07qiWsqSVqWZEIAIctyeKLkOOouMFDpSj3loG3
RRcQp3wY7ZF+Qb+8FKVAVlzorDtVvwlePcHNc+7fN6bL5IkOAO/xEuhqh0Z7lvkB
YIVpjadvcntuzS5pP/UjrJxOOhisMIfZaINsCu9Br9kRJ6cy/2MxtMMNQHpYNC+p
1Nnm2fCnzMRLLF6jE8/INEPXgmH5xI3cwEV/kW+IIYmaSFnDwkctME/Ka36QOxj7
yMMqPdDSudAVFg10AqFYAaAgdnr7DRCOVlxsneVfv6DKCkz2RZqtBn94juotm6+k
OQvQmQqxFaH97+qx0eIGg7qL1ifky9+4TXCLJpSEQLIOpo2KeB3LtSgqHearraM=
=ciZt
-----END PGP SIGNATURE-----

--lOn2dbulAak3mRNwkIR8RnP4iqwh0uEQT--
