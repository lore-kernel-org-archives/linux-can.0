From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: mpc5xxx_can: check of_iomap return before use
Date: Mon, 23 Jul 2018 14:27:53 +0200
Message-ID: <a4540f12-bedb-c81c-d998-9a2634a026db@pengutronix.de>
References: <1531163800-12111-1-git-send-email-hofrat@osadl.org>
 <CAOMZO5CPVx_3kj5xKaoNbYP14cgPk9aSniyu44oWF-0jbSx91g@mail.gmail.com>
 <4f81e688-3d5c-6174-5a76-f416ced63cf3@pengutronix.de>
 <20180723115733.GA6529@osadl.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="53CEJOkBhREyBSNwj2hNWGsluLf8UBAc2"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180723115733.GA6529@osadl.at>
Sender: netdev-owner@vger.kernel.org
To: Nicholas Mc Guire <der.herr@hofr.at>
Cc: Fabio Estevam <festevam@gmail.com>, Nicholas Mc Guire <hofrat@osadl.org>, Wolfram Sang <w.sang@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org, netdev <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--53CEJOkBhREyBSNwj2hNWGsluLf8UBAc2
Content-Type: multipart/mixed; boundary="U2iXdwp65VTPaOQVxjuGW1FI9V9vUIWvo";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Nicholas Mc Guire <der.herr@hofr.at>
Cc: Fabio Estevam <festevam@gmail.com>, Nicholas Mc Guire <hofrat@osadl.org>,
 Wolfram Sang <w.sang@pengutronix.de>, Wolfgang Grandegger
 <wg@grandegger.com>, "David S. Miller" <davem@davemloft.net>,
 linux-can@vger.kernel.org, netdev <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <a4540f12-bedb-c81c-d998-9a2634a026db@pengutronix.de>
Subject: Re: [PATCH] can: mpc5xxx_can: check of_iomap return before use
References: <1531163800-12111-1-git-send-email-hofrat@osadl.org>
 <CAOMZO5CPVx_3kj5xKaoNbYP14cgPk9aSniyu44oWF-0jbSx91g@mail.gmail.com>
 <4f81e688-3d5c-6174-5a76-f416ced63cf3@pengutronix.de>
 <20180723115733.GA6529@osadl.at>
In-Reply-To: <20180723115733.GA6529@osadl.at>

--U2iXdwp65VTPaOQVxjuGW1FI9V9vUIWvo
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 07/23/2018 01:57 PM, Nicholas Mc Guire wrote:
> On Mon, Jul 23, 2018 at 01:37:05PM +0200, Marc Kleine-Budde wrote:
>> On 07/09/2018 09:28 PM, Fabio Estevam wrote:
>>> On Mon, Jul 9, 2018 at 4:16 PM, Nicholas Mc Guire <hofrat@osadl.org> =
wrote:
>>>>  of_iompa() can return NULL so that return needs to be checked and N=
ULL
>>>
>>> s/of_iompa/of_iomap/
>>>
>>>> treated as failure. While at it also take care of the missing
>>>> of_node_put() in the error path.
>>>>
>>>> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
>>>> Fixes: commit afa17a500a36 ("net/can: add driver for mscan family & =
mpc52xx_mscan")
>>>> ---
>>>>
>>>> Problem was found by an experimental coccinelle script
>>>>
>>>> Patch was compiletested with: mpc5200_defconfig + CONFIG_CAN=3Dy,
>>>> CONFIG_CAN_MSCAN=3Dy, CONFIG_CAN_MPC5XXX=3Dy
>>>> (with a number of sparse warnings not related to the proposed change=
)
>>>>
>>>> Patch is against 4.18-rc3 (localversion-next is next-20180706)
>>>>
>>>>  drivers/net/can/mscan/mpc5xxx_can.c | 5 +++++
>>>>  1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/drivers/net/can/mscan/mpc5xxx_can.c b/drivers/net/can/m=
scan/mpc5xxx_can.c
>>>> index c7427bd..2949a38 100644
>>>> --- a/drivers/net/can/mscan/mpc5xxx_can.c
>>>> +++ b/drivers/net/can/mscan/mpc5xxx_can.c
>>>> @@ -86,6 +86,11 @@ static u32 mpc52xx_can_get_clock(struct platform_=
device *ofdev,
>>>>                 return 0;
>>>>         }
>>>>         cdm =3D of_iomap(np_cdm, 0);
>>>> +       if (!cdm) {
>>>> +               of_node_put(np_cdm);
>>>> +               dev_err(&ofdev->dev, "can't map clock node!\n");
>>>> +               return 0;
>>>
>>> I think you should return an error code here. -ENOMEM maybe?
>>
>> Can you send an updated version?
>>
> The way I understand the code the return value will be used
> as a frequency - the only valid error valeu thus is 0 here,
> so I think the return 0 is correct.

Yes. Looking at the code this makes sense.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--U2iXdwp65VTPaOQVxjuGW1FI9V9vUIWvo--

--53CEJOkBhREyBSNwj2hNWGsluLf8UBAc2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAltVyckACgkQk9IU1zQo
ZfFpJAgAh3B4XomJVFgDTox4tbTj7Mawrvf4u2mnRD1q95tMxbC0vO1jpP83X7gk
Y2VYx+GJrjhy1b9CYJuBv0kl7XqIJ2SAKxjN9S+rP1EEOc+dym85M4tKdplxXpS0
4J54UmJAF3uBDwAt3MXJuI/tUxUjpVxZTkSP361wqATD9I2BwyRo4bkIks2jCHaE
aTUdBaRw9GDvDyxrPc47Wjwnx2pal/SsPfqbd4kbM30U5fad4Z/zsgkOAuPFHu80
tob1pvEf5dtPXFF4rtcYfePl1tzGZFfHMDheyo2PlZqRe6MQMXAp4JzZkw8uHzoE
R+kRNJaiMXnTWNdJYOSvN8nWSJFrAA==
=h971
-----END PGP SIGNATURE-----

--53CEJOkBhREyBSNwj2hNWGsluLf8UBAc2--
