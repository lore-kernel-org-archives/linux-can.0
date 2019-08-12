From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/5] can: xilinx_can: Bug fixes
Date: Mon, 12 Aug 2019 12:47:53 +0200
Message-ID: <cb8f91b5-174f-79e5-d476-b01da2f3a65c@pengutronix.de>
References: <1565594914-18999-1-git-send-email-appana.durga.rao@xilinx.com>
 <7ecaa7df-3202-21d8-de93-5f6af3582964@pengutronix.de>
 <5571da8a-de1f-f420-f6b7-81c6d8932430@pengutronix.de>
 <f0e3360d-7c9a-a455-f63c-7fb584dfad2f@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5595960791674544506=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <f0e3360d-7c9a-a455-f63c-7fb584dfad2f@xilinx.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Michal Simek <michal.simek@xilinx.com>, Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>, wg@grandegger.com, davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============5595960791674544506==
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="kSQwWLIKHrez4y9XmVbZ7JtIqdpZ7ciD5"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kSQwWLIKHrez4y9XmVbZ7JtIqdpZ7ciD5
Content-Type: multipart/mixed; boundary="5i1mqYkYua1vgTMdgC97rfVM8ugrWSttR";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Michal Simek <michal.simek@xilinx.com>,
 Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
 wg@grandegger.com, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <cb8f91b5-174f-79e5-d476-b01da2f3a65c@pengutronix.de>
Subject: Re: [PATCH 0/5] can: xilinx_can: Bug fixes
References: <1565594914-18999-1-git-send-email-appana.durga.rao@xilinx.com>
 <7ecaa7df-3202-21d8-de93-5f6af3582964@pengutronix.de>
 <5571da8a-de1f-f420-f6b7-81c6d8932430@pengutronix.de>
 <f0e3360d-7c9a-a455-f63c-7fb584dfad2f@xilinx.com>
In-Reply-To: <f0e3360d-7c9a-a455-f63c-7fb584dfad2f@xilinx.com>

--5i1mqYkYua1vgTMdgC97rfVM8ugrWSttR
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 8/12/19 12:18 PM, Michal Simek wrote:
> On 12. 08. 19 11:10, Marc Kleine-Budde wrote:
>> On 8/12/19 11:05 AM, Marc Kleine-Budde wrote:
>>> On 8/12/19 9:28 AM, Appana Durga Kedareswara rao wrote:
>>>> This patch series fixes below issues
>>>> --> Bugs in the driver w.r.to CANFD 2.0 IP support
>>>> --> Defer the probe if clock is not found
>>>>
>>>> Appana Durga Kedareswara rao (3):
>>>>   can: xilinx_can: Fix FSR register handling in the rx path
>>>>   can: xilinx_can: Fix the data updation logic for CANFD FD frames
>>>>   can: xilinx_can: Fix FSR register FL and RI mask values for canfd =
2.0
>>>>
>>>> Srinivas Neeli (1):
>>>>   can: xilinx_can: Fix the data phase btr1 calculation
>>>>
>>>> Venkatesh Yadav Abbarapu (1):
>>>>   can: xilinx_can: defer the probe if clock is not found
>>>
>>> Please add your S-o-b to patches 4+5.
>>>
>>> As these all are bugfixes please add a reference to the commit it fix=
es:
>>>
>>>     Fixes: commitish ("description")
>>
>> Add this to your ~/.gitconfig:
>>
>> [alias]
>>         lfixes =3D log --pretty=3Dfixes
>> [pretty]
>>         fixes =3D Fixes: %h (\"%s\")
>=20
> This is understandable and I have this in my .gitconfig for quite a lon=
g
> time. And this is just log
>=20
>> and then use $(git lfixes $commitish).
>=20
> But what do you mean by this? Are you able to add this to commit messag=
e
> just with sha1?

First identify the commit that this patch fixes then go to the command
line and enter

    git lfixes $committish

and git will print out the line that you can copy directly to the commit
message.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--5i1mqYkYua1vgTMdgC97rfVM8ugrWSttR--

--kSQwWLIKHrez4y9XmVbZ7JtIqdpZ7ciD5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl1RQ9kACgkQWsYho5Hk
nSCWrgf/UUNmsF6+UpsO3JchsCSFsjGMRHuE61BSRYJTOuUqdpC9gAs/vjgiKbHV
YMUKZT7CB28p8g+jGJlx51+VQiu2s+AuMp0mEEPnjSnLI4XzMGaJLuWIgBzrShmY
CtgGAoyQvwm6fwlJvAXtjAX8DeU4uB91nrAvQj2fVW3h7RFYYpV1yZDXnhKFvNT5
WwRbLCeM0CEvcP+tqLsT+PlOdCr5XT9ZhdwiYgSixyh7M4Jo0cpPG6gwXeBSZogd
Qd7qCzFybsqtVRzJf4lOd6CjiybBVpUp8o4GTheHFa2A/2OU0qH5dpSQwx8H6FVC
8zAy+ukc8s0v9uRRkdJxn7aSoM+UqQ==
=pyeC
-----END PGP SIGNATURE-----

--kSQwWLIKHrez4y9XmVbZ7JtIqdpZ7ciD5--


--===============5595960791674544506==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5595960791674544506==--
