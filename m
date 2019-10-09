From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/6] net: can: xilinx_can: Fix flags field initialization
 for axi can and canps
Date: Wed, 9 Oct 2019 09:17:49 +0200
Message-ID: <644fb76f-8169-4911-2293-92ae2dfe4e1c@pengutronix.de>
References: <1552908766-26753-1-git-send-email-appana.durga.rao@xilinx.com>
 <1552908766-26753-3-git-send-email-appana.durga.rao@xilinx.com>
 <d1bedb13-f66f-b0fd-bd6d-9f95b64fc405@bitwise.fi>
 <MN2PR02MB64004059908C95EB5E16746FDC950@MN2PR02MB6400.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="o6gGPgD5ZTyYWoRyGFKHldQgJZ9IWZIQR"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <MN2PR02MB64004059908C95EB5E16746FDC950@MN2PR02MB6400.namprd02.prod.outlook.com>
Sender: netdev-owner@vger.kernel.org
To: Appana Durga Kedareswara Rao <appanad@xilinx.com>, Anssi Hannula <anssi.hannula@bitwise.fi>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "davem@davemloft.net" <davem@davemloft.net>, Michal Simek <michals@xilinx.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--o6gGPgD5ZTyYWoRyGFKHldQgJZ9IWZIQR
Content-Type: multipart/mixed; boundary="r6Se4r1d84yFfg5K20EFRv9UIXwPXokF8";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Appana Durga Kedareswara Rao <appanad@xilinx.com>,
 Anssi Hannula <anssi.hannula@bitwise.fi>
Cc: "wg@grandegger.com" <wg@grandegger.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 Michal Simek <michals@xilinx.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Message-ID: <644fb76f-8169-4911-2293-92ae2dfe4e1c@pengutronix.de>
Subject: Re: [PATCH 2/6] net: can: xilinx_can: Fix flags field initialization
 for axi can and canps
References: <1552908766-26753-1-git-send-email-appana.durga.rao@xilinx.com>
 <1552908766-26753-3-git-send-email-appana.durga.rao@xilinx.com>
 <d1bedb13-f66f-b0fd-bd6d-9f95b64fc405@bitwise.fi>
 <MN2PR02MB64004059908C95EB5E16746FDC950@MN2PR02MB6400.namprd02.prod.outlook.com>
In-Reply-To: <MN2PR02MB64004059908C95EB5E16746FDC950@MN2PR02MB6400.namprd02.prod.outlook.com>

--r6Se4r1d84yFfg5K20EFRv9UIXwPXokF8
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 10/9/19 6:01 AM, Appana Durga Kedareswara Rao wrote:
> Hi,
>=20
> <Snip>
>> On 18.3.2019 13.32, Appana Durga Kedareswara rao wrote:
>>> AXI CAN IP and CANPS IP supports tx fifo empty feature, this patch
>>> updates the flags field for the same.
>>>
>>> Signed-off-by: Appana Durga Kedareswara rao
>>> <appana.durga.rao@xilinx.com>
>>> ---
>>>  drivers/net/can/xilinx_can.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/net/can/xilinx_can.c
>>> b/drivers/net/can/xilinx_can.c index 2de51ac..22569ef 100644
>>> --- a/drivers/net/can/xilinx_can.c
>>> +++ b/drivers/net/can/xilinx_can.c
>>> @@ -1428,6 +1428,7 @@ static const struct dev_pm_ops xcan_dev_pm_ops
>> =3D
>>> {  };
>>>
>>>  static const struct xcan_devtype_data xcan_zynq_data =3D {
>>> +	.flags =3D XCAN_FLAG_TXFEMP,
>>>  	.bittiming_const =3D &xcan_bittiming_const,
>>>  	.btr_ts2_shift =3D XCAN_BTR_TS2_SHIFT,
>>>  	.btr_sjw_shift =3D XCAN_BTR_SJW_SHIFT,
>>
>> Thanks for catching this, this line seemed to have been incorrectly re=
moved by
>> my 9e5f1b273e ("can: xilinx_can: add support for Xilinx CAN FD core").=

>>
>> But:
>>
>>> @@ -1435,6 +1436,7 @@ static const struct xcan_devtype_data
>>> xcan_zynq_data =3D {  };
>>>
>>>  static const struct xcan_devtype_data xcan_axi_data =3D {
>>> +	.flags =3D XCAN_FLAG_TXFEMP,
>>>  	.bittiming_const =3D &xcan_bittiming_const,
>>>  	.btr_ts2_shift =3D XCAN_BTR_TS2_SHIFT,
>>>  	.btr_sjw_shift =3D XCAN_BTR_SJW_SHIFT,
>>
>>
>> Are you sure this is right?
>> In the documentation [1] there does not seem to be any TXFEMP interrup=
t, it
>> would be interrupt bit 14 but AXI CAN 5.0 seems to only go up to 11.
>>
>> Or maybe it is undocumented or there is a newer version somewhere?
>=20
> Sorry for the delay in the reply.=20
> Agree TXFEMP interrupt feature is not supported by the Soft IP CAN.
> Since this patch already got applied will send a separate patch to fix =
this.

Please base your patch on net/master and add the appropriate fixes tag:

Fixes: 3281b380ec9f ("can: xilinx_can: Fix flags field initialization for=
 axi can and canps")

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--r6Se4r1d84yFfg5K20EFRv9UIXwPXokF8--

--o6gGPgD5ZTyYWoRyGFKHldQgJZ9IWZIQR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl2diZ0ACgkQWsYho5Hk
nSDwGwf+Oxe0LBV8cKXYL5gwSl2c4iMUIorM6JCFmH1Uavtlp11+g91f3qyPCpyq
MVHHsIeBIbta2dN1oBY7tGBmBH5s4MNdxhFlc8EajUeYf6sZBD+BK243TSJVC7hF
pjVtdIEhiPkZcveLzF2TIaBMVPqLiJyKmsJvgVlXLUY9TYOi7BGqu0NoTvEOjNJ9
HThgvSUH/zfJrWIT5m6DMxg+39QacVCjfTtlXIhefPsr/F6IPZ855qItY9mNGsPh
2qC24k6Pq70Q4h7uGtKO+/dU1Uy0Ru/t7BOlhzcEG/cwVuLE/x3tW2ccnNKdeBoq
MLDHd+vQ3kqakVr4m010yE8l/cBiPA==
=mgwU
-----END PGP SIGNATURE-----

--o6gGPgD5ZTyYWoRyGFKHldQgJZ9IWZIQR--
