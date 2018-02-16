From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 2/3] can: cc770: Stop queue on NETDEV_TX_BUSY
Date: Fri, 16 Feb 2018 15:22:32 +0100
Message-ID: <c1141307-fb16-3b0b-882b-c09376875cee@pengutronix.de>
References: <20180130165649.22732-1-andri.yngvason@marel.com>
 <d62fdd54-4d06-db35-a0a0-b69759286bb5@grandegger.com>
 <8cd354eb-b610-b309-2a3f-a345f56aaecf@grandegger.com>
 <1798644.r6m8FyMpzN@blindfold>
 <bba8155f-4865-d457-4d8d-56ffc71acd59@grandegger.com>
 <1bccaf3c-faab-33ae-e1d8-8344d5d9a537@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="almhorIoFUHwFuLAEFK3nV3G71NhbAE0S"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51409 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034176AbeBPOX0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 16 Feb 2018 09:23:26 -0500
In-Reply-To: <1bccaf3c-faab-33ae-e1d8-8344d5d9a537@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Richard Weinberger <richard@sigma-star.at>
Cc: Andri Yngvason <andri.yngvason@marel.com>, linux-can@vger.kernel.org, sigurbjorn.narfason@marel.com, hrafnkell.eiriksson@marel.com, patric.thysell@br-automation.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--almhorIoFUHwFuLAEFK3nV3G71NhbAE0S
Content-Type: multipart/mixed; boundary="eydYVOPKu9rxWEHpousEJlBKrvVhXn3zl";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Wolfgang Grandegger <wg@grandegger.com>,
 Richard Weinberger <richard@sigma-star.at>
Cc: Andri Yngvason <andri.yngvason@marel.com>, linux-can@vger.kernel.org,
 sigurbjorn.narfason@marel.com, hrafnkell.eiriksson@marel.com,
 patric.thysell@br-automation.com
Message-ID: <c1141307-fb16-3b0b-882b-c09376875cee@pengutronix.de>
Subject: Re: [PATCH v2 2/3] can: cc770: Stop queue on NETDEV_TX_BUSY
References: <20180130165649.22732-1-andri.yngvason@marel.com>
 <d62fdd54-4d06-db35-a0a0-b69759286bb5@grandegger.com>
 <8cd354eb-b610-b309-2a3f-a345f56aaecf@grandegger.com>
 <1798644.r6m8FyMpzN@blindfold>
 <bba8155f-4865-d457-4d8d-56ffc71acd59@grandegger.com>
 <1bccaf3c-faab-33ae-e1d8-8344d5d9a537@grandegger.com>
In-Reply-To: <1bccaf3c-faab-33ae-e1d8-8344d5d9a537@grandegger.com>

--eydYVOPKu9rxWEHpousEJlBKrvVhXn3zl
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 02/12/2018 10:36 PM, Wolfgang Grandegger wrote:
> Am 12.02.2018 um 22:28 schrieb Wolfgang Grandegger:
>> Am 12.02.2018 um 21:55 schrieb Richard Weinberger:
>>> Am Montag, 12. Februar 2018, 21:44:11 CET schrieb Wolfgang Grandegger=
:
>>>> Am 12.02.2018 um 21:37 schrieb Wolfgang Grandegger:
>>>>> Hello,
>>>>>
>>>>> Am 12.02.2018 um 20:40 schrieb Richard Weinberger:
>>>>>> Andri,
>>>>>>
>>>>>> Am Dienstag, 30. Januar 2018, 17:56:48 CET schrieb Andri Yngvason:=

>>>>>>> If the queue is not stopped, the start_xmit function will continu=
e=20
>>>>>>> to be
>>>>>>> called until the driver or the system is reset.
>>>>>>>
>>>>>>> Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>
>>>>>>> ---
>>>>>>> =C2=A0=C2=A0 drivers/net/can/cc770/cc770.c | 1 +
>>>>>>> =C2=A0=C2=A0 1 file changed, 1 insertion(+)
>>>>>>>
>>>>>>> diff --git a/drivers/net/can/cc770/cc770.c
>>>>>>> b/drivers/net/can/cc770/cc770.c
>>>>>>> index 9fed163..12d3b89 100644
>>>>>>> --- a/drivers/net/can/cc770/cc770.c
>>>>>>> +++ b/drivers/net/can/cc770/cc770.c
>>>>>>> @@ -405,6 +405,7 @@ static netdev_tx_t cc770_start_xmit(struct
>>>>>>> sk_buff *skb,
>>>>>>> struct net_device *dev)
>>>>>>>
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((cc770_read_reg(priv,
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msgobj[mo].ctrl1) & TXRQST_UNC=
) =3D=3D TXRQST_SET) {
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 netif_stop_queue(dev)=
;
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 netd=
ev_err(dev, "TX register is still occupied!\n");
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn NETDEV_TX_BUSY;
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>
>>>>>> I see that some can drivers stop the queue, others not.
>>>>>> What exactly is the problem in this case?
>>>>>
>>>>> Stopping the queue and returning NETDEV_TX_BUSY does make little se=
nse.
>>>>> NETDEV_TX_BUSY will tell the upper layer to retry asap. In general =
that
>>>>> case should be avoided by stopping the queue earlier. Actually,
>>>>> netif_stop_queue(dev) is called directly after the if block above,
>>>>> which means that "TX register is still occupied" indicates an=20
>>>>> error/bug.
>>>>> I think there is a race somewhere.
>>>>
>>>> If you run on "-rt", the IRQ is threaded. This would explain the iss=
ue.
>>>>
>>>> Wolfgang.
>>>
>>> Andri, do you see the "TX register is still occupied!" error message?=

>>> In my case, I never saw it while working on the rt-related stalls=20
>>> during my
>>> tests.
>>
>> At a closer look I cannot identify a race. Anyway, the message should =

>> never show up.
>=20
> You could try to get a function trace by enabling functions tracing and=
=20
> stopping it with "tracing_off" when the if block above is entered. A=20
> filter for "cc770_*" and "netif_*" might be useful as well.

It seems to me these patches are still WIP, right? Or should I take some
to into my git-tree?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--eydYVOPKu9rxWEHpousEJlBKrvVhXn3zl--

--almhorIoFUHwFuLAEFK3nV3G71NhbAE0S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlqG6SgACgkQk9IU1zQo
ZfFcEQf+OqK5y343cd5JetMRnaPEfxipRBB7eEvEfxfcH4U6d68pxHOCBiJhCEp6
OlrMVFLXbsuVStqjo16Z5SmsB67Jmg3O8jTssxdG7ft1p5AbNlh4j+5U8NMev/dL
70z0FHiW81KljqnUdoToQnrAOsw16p3Gvn20N5rAiSMgKrLM/moywqbkpq14iKL5
RKdtKUqXj53UfSEGnY/P6a/Foe/lA+qLMqTlu/6k9Kv2dg7DYPJqkK/kQ2m12QJf
4HISp4y2MiRfuZxDysZeFV+mJ4STR7c9OUw0deVV9ya9IWAJTwyi0AQvR+3mrqlm
qZbU2JxJ0ZWYz020PRwbrOzfmqlR6g==
=n1Db
-----END PGP SIGNATURE-----

--almhorIoFUHwFuLAEFK3nV3G71NhbAE0S--
