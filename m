From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/5] can: xilinx_can: Bug fixes
Date: Mon, 12 Aug 2019 12:59:40 +0200
Message-ID: <6b36bbcb-06e3-63aa-8861-c07c8840e25e@pengutronix.de>
References: <1565594914-18999-1-git-send-email-appana.durga.rao@xilinx.com>
 <7ecaa7df-3202-21d8-de93-5f6af3582964@pengutronix.de>
 <5571da8a-de1f-f420-f6b7-81c6d8932430@pengutronix.de>
 <f0e3360d-7c9a-a455-f63c-7fb584dfad2f@xilinx.com>
 <cb8f91b5-174f-79e5-d476-b01da2f3a65c@pengutronix.de>
 <c09ae89a-509d-55e7-a2d6-44ca2543f333@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="pr6zYuzLM3uquhunjE5VAIbSZefbqogin"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c09ae89a-509d-55e7-a2d6-44ca2543f333@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>, Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>, wg@grandegger.com, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pr6zYuzLM3uquhunjE5VAIbSZefbqogin
Content-Type: multipart/mixed; boundary="lBGMvgV8d0x7gFgAeoPJZgjTJbeYeKb4o";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Michal Simek <michal.simek@xilinx.com>,
 Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
 wg@grandegger.com, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <6b36bbcb-06e3-63aa-8861-c07c8840e25e@pengutronix.de>
Subject: Re: [PATCH 0/5] can: xilinx_can: Bug fixes
References: <1565594914-18999-1-git-send-email-appana.durga.rao@xilinx.com>
 <7ecaa7df-3202-21d8-de93-5f6af3582964@pengutronix.de>
 <5571da8a-de1f-f420-f6b7-81c6d8932430@pengutronix.de>
 <f0e3360d-7c9a-a455-f63c-7fb584dfad2f@xilinx.com>
 <cb8f91b5-174f-79e5-d476-b01da2f3a65c@pengutronix.de>
 <c09ae89a-509d-55e7-a2d6-44ca2543f333@xilinx.com>
In-Reply-To: <c09ae89a-509d-55e7-a2d6-44ca2543f333@xilinx.com>

--lBGMvgV8d0x7gFgAeoPJZgjTJbeYeKb4o
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 8/12/19 12:57 PM, Michal Simek wrote:
> On 12. 08. 19 12:47, Marc Kleine-Budde wrote:
>> On 8/12/19 12:18 PM, Michal Simek wrote:
>>> On 12. 08. 19 11:10, Marc Kleine-Budde wrote:
>>>> On 8/12/19 11:05 AM, Marc Kleine-Budde wrote:
>>>>> On 8/12/19 9:28 AM, Appana Durga Kedareswara rao wrote:
>>>>>> This patch series fixes below issues
>>>>>> --> Bugs in the driver w.r.to CANFD 2.0 IP support
>>>>>> --> Defer the probe if clock is not found
>>>>>>
>>>>>> Appana Durga Kedareswara rao (3):
>>>>>>   can: xilinx_can: Fix FSR register handling in the rx path
>>>>>>   can: xilinx_can: Fix the data updation logic for CANFD FD frames=

>>>>>>   can: xilinx_can: Fix FSR register FL and RI mask values for canf=
d 2.0
>>>>>>
>>>>>> Srinivas Neeli (1):
>>>>>>   can: xilinx_can: Fix the data phase btr1 calculation
>>>>>>
>>>>>> Venkatesh Yadav Abbarapu (1):
>>>>>>   can: xilinx_can: defer the probe if clock is not found
>>>>>
>>>>> Please add your S-o-b to patches 4+5.
>>>>>
>>>>> As these all are bugfixes please add a reference to the commit it f=
ixes:
>>>>>
>>>>>     Fixes: commitish ("description")
>>>>
>>>> Add this to your ~/.gitconfig:
>>>>
>>>> [alias]
>>>>         lfixes =3D log --pretty=3Dfixes
>>>> [pretty]
>>>>         fixes =3D Fixes: %h (\"%s\")
>>>
>>> This is understandable and I have this in my .gitconfig for quite a l=
ong
>>> time. And this is just log
>>>
>>>> and then use $(git lfixes $commitish).
>>>
>>> But what do you mean by this? Are you able to add this to commit mess=
age
>>> just with sha1?
>>
>> First identify the commit that this patch fixes then go to the command=

>> line and enter
>>
>>     git lfixes $committish
>>
>> and git will print out the line that you can copy directly to the comm=
it
>> message.
>=20
> ok. I thought you have any nice way to directly add it to commit messag=
e
> without c&p.

You can insert the output from a console command in vim by adding a "!"
in front of it in the command mode.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--lBGMvgV8d0x7gFgAeoPJZgjTJbeYeKb4o--

--pr6zYuzLM3uquhunjE5VAIbSZefbqogin
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl1RRpwACgkQWsYho5Hk
nSDGHQgAn+qDhdt0QiMSBuNdZcK7VDUyMm4lDhKxIeInxDKdPFMijY0La7P/V8va
BxT5X7xZjiwhlYDxdPboseCRoCPPLMZptfTBjRkqLZNHb/aSWVpWXUZY1x36bLOP
IImdUZGxjtiLHgi26oAOtBR9A7jtv1mJ57lOg+O5nezMXvLYy2niAU29pHAsPc+E
r2p6tTMoQCvnLv5M8I0npPt2vTjkGlY8NKcQU+oc/ZUBkr5Z4QKKwhObbVIqPy5M
/VApX02s4Wg1ml9BAiGqDXmnpKuvuLL4VCzKrPKFXYA5h13YlwIq/cjROKKbsLSj
l1OnnUFnV7Hto1WROwes1VcM2tUm6Q==
=RfB4
-----END PGP SIGNATURE-----

--pr6zYuzLM3uquhunjE5VAIbSZefbqogin--
