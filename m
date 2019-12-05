From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/2] net: m_can: Make wake-up gpio an optional
Date: Thu, 5 Dec 2019 15:39:04 +0100
Message-ID: <809b9ff1-88e3-4e46-33e0-856db37898b2@pengutronix.de>
References: <20191204175112.7308-1-dmurphy@ti.com>
 <20191204175112.7308-2-dmurphy@ti.com>
 <b9eaa5c4-13bc-295f-dcbf-d2a846243682@geanix.com>
 <827b022e-9188-7bcf-25e3-3777df3b08a5@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="iZU9bZITvtgiwIRdmRwqqWeLtKpNHVsed"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <827b022e-9188-7bcf-25e3-3777df3b08a5@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>, Sean Nyekjaer <sean@geanix.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iZU9bZITvtgiwIRdmRwqqWeLtKpNHVsed
Content-Type: multipart/mixed; boundary="Mnnmu6BcRlpk8J2MfsWkjfPCqrE9aKPjY";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Dan Murphy <dmurphy@ti.com>, Sean Nyekjaer <sean@geanix.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Message-ID: <809b9ff1-88e3-4e46-33e0-856db37898b2@pengutronix.de>
Subject: Re: [PATCH 2/2] net: m_can: Make wake-up gpio an optional
References: <20191204175112.7308-1-dmurphy@ti.com>
 <20191204175112.7308-2-dmurphy@ti.com>
 <b9eaa5c4-13bc-295f-dcbf-d2a846243682@geanix.com>
 <827b022e-9188-7bcf-25e3-3777df3b08a5@ti.com>
In-Reply-To: <827b022e-9188-7bcf-25e3-3777df3b08a5@ti.com>

--Mnnmu6BcRlpk8J2MfsWkjfPCqrE9aKPjY
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 12/5/19 2:26 PM, Dan Murphy wrote:
> On 12/5/19 1:39 AM, Sean Nyekjaer wrote:
>>
>>
>> On 04/12/2019 18.51, Dan Murphy wrote:
>>> The device has the ability to disable the wake-up pin option.
>>> The wake-up pin can be either force to GND or Vsup and does not have =
to
>>> be tied to a GPIO.=C2=A0 In order for the device to not use the wake-=
up=20
>>> feature
>>> write the register to disable the WAKE_CONFIG option.
>>>
>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>> CC: Sean Nyekjaer <sean@geanix.com>
>> Reviewed-by: Sean Nyekjaer <sean@geanix.com>
>>> ---
>>
>>
>> Hi Dan,
>>
>> I would add tcan4x5x to the subject of this patch ->
>> "net: m_can: tcan4x5x Make wake-up gpio an optional"
>>
> Do you want me to submit v2 with the $subject change?
>=20
> Or would you fix it up when committing it?

I'll change the subject while applying.

Dan, what about maintainerchip of the tcan4x5?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--Mnnmu6BcRlpk8J2MfsWkjfPCqrE9aKPjY--

--iZU9bZITvtgiwIRdmRwqqWeLtKpNHVsed
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3pFogACgkQWsYho5Hk
nSD7Cwf/fbv3hoVGUGGFAH8BxqgHR6oOtr1zZBZJpo6RGumAWrabIJmmrm2sZoHZ
eurm7p3YAefNpOUaJaBudQyLfZ/Bj4NyWE/aGU4rMdAVLbFQU30aMrKFn9DRdI/L
D1pJE2S/kcfXSYIKih58c22CcLSqCFUwhn1xSEb29LAmIIpvoQTXsUBOymQFNKEO
Z5xHCudVHR9axcONsiqs0oUPW+apz8buQ/CYCvMVbyBUtF/5HbHnjGa5176bC4fH
Bh4NR4hN42beMksSjXMCN6onuNgf9AuX8kK6kiqsjBInYj6p8GttrlTCieXnL/8x
JYrlKCHuDf9bosQY6rPmR/o1+4Oikw==
=7SuL
-----END PGP SIGNATURE-----

--iZU9bZITvtgiwIRdmRwqqWeLtKpNHVsed--
