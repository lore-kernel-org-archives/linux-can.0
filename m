From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: INFO: task hung in vivid_stop_generating_vid_cap
Date: Thu, 7 Nov 2019 19:51:22 +0100
Message-ID: <d4f03b02-29c6-3479-d5a4-baae86879e13@pengutronix.de>
References: <00000000000080601805795ada2e@google.com>
 <000000000000e626290584a983c0@google.com>
 <CACT4Y+YVNA6aYe-Ai-ZnU+EhNSNAFhjvXPT0oA+i4rCFpQThcg@mail.gmail.com>
 <CACT4Y+aVXJuaBsvwM-7UcpDzvPZG8HaFHPnHQMX1ZzE1Emd-Tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="NeIZlyowumXtqXLNOZErcBk1aZbUuvacE"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACT4Y+aVXJuaBsvwM-7UcpDzvPZG8HaFHPnHQMX1ZzE1Emd-Tg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Vyukov <dvyukov@google.com>, syzbot <syzbot+06283a66a648cd073885@syzkaller.appspotmail.com>, linux-can@vger.kernel.org
Cc: andy@greyhouse.net, David Miller <davem@davemloft.net>, Hans Verkuil <hverkuil@xs4all.nl>, j.vosburgh@gmail.com, LKML <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org, Mahesh Bandewar <maheshb@google.com>, mchehab@kernel.org, netdev <netdev@vger.kernel.org>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, vfalico@gmail.com
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NeIZlyowumXtqXLNOZErcBk1aZbUuvacE
Content-Type: multipart/mixed; boundary="4FKKqhxBizYnGAZ3YsXRzhsPWgt6jD1Xg";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Dmitry Vyukov <dvyukov@google.com>,
 syzbot <syzbot+06283a66a648cd073885@syzkaller.appspotmail.com>,
 linux-can@vger.kernel.org
Cc: andy@greyhouse.net, David Miller <davem@davemloft.net>,
 Hans Verkuil <hverkuil@xs4all.nl>, j.vosburgh@gmail.com,
 LKML <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org,
 Mahesh Bandewar <maheshb@google.com>, mchehab@kernel.org,
 netdev <netdev@vger.kernel.org>,
 syzkaller-bugs <syzkaller-bugs@googlegroups.com>, vfalico@gmail.com
Message-ID: <d4f03b02-29c6-3479-d5a4-baae86879e13@pengutronix.de>
Subject: Re: INFO: task hung in vivid_stop_generating_vid_cap
References: <00000000000080601805795ada2e@google.com>
 <000000000000e626290584a983c0@google.com>
 <CACT4Y+YVNA6aYe-Ai-ZnU+EhNSNAFhjvXPT0oA+i4rCFpQThcg@mail.gmail.com>
 <CACT4Y+aVXJuaBsvwM-7UcpDzvPZG8HaFHPnHQMX1ZzE1Emd-Tg@mail.gmail.com>
In-Reply-To: <CACT4Y+aVXJuaBsvwM-7UcpDzvPZG8HaFHPnHQMX1ZzE1Emd-Tg@mail.gmail.com>

--4FKKqhxBizYnGAZ3YsXRzhsPWgt6jD1Xg
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 3/22/19 9:06 AM, Dmitry Vyukov wrote:
> On Fri, Mar 22, 2019 at 9:00 AM Dmitry Vyukov <dvyukov@google.com> wrot=
e:
>>
>> On Fri, Mar 22, 2019 at 8:08 AM syzbot
>> <syzbot+06283a66a648cd073885@syzkaller.appspotmail.com> wrote:
>>>
>>> syzbot has bisected this bug to:
>>>
>>> commit 4493b81bea24269df898339dee638d7c5cb2b2df
>>> Author: Mahesh Bandewar <maheshb@google.com>
>>> Date:   Wed Mar 8 18:55:54 2017 +0000
>>>
>>>      bonding: initialize work-queues during creation of bond
>>
>> +linux-can
>>
>> I think I will disable CONFIG_CAN before v4.12. It causes too many
>> false results for v4.12..v4.11 range. It always leads to a wrong
>> decision for first 3 steps, then no chances of correct bisection
>> anymore.
>=20
> The same seems to show up for v4.12..v4.13:
> all runs: crashed: INFO: trying to register non-static key in can_notif=
ier
> https://syzkaller.appspot.com/text?tag=3DLog&x=3D1555b12b200000
>=20
> This was fixed by 74b7b490886852582d986a33443c2ffa50970169 right?

ACK

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--4FKKqhxBizYnGAZ3YsXRzhsPWgt6jD1Xg--

--NeIZlyowumXtqXLNOZErcBk1aZbUuvacE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3EZ6oACgkQWsYho5Hk
nSBtBAgAllvi9XlOwEQqlRCgEviA4PZ9wDRj16b0XhPl+82RiA9fXyPRHcCj2Owa
sNnNCF+nHA3Vq/N64n9snPpWz0mXuzUO6NGCTbB3rqY+mK/U6mq+KnVJwvjHq2D6
y9sHCDOMn1VLFlw+Ek3m95fUAi72i/6YCfVcRg2ArY35aDATtlrGTjWt0G+8YyuN
YqyIiueOYaiIyev99lVpwExKcRwZHVK27c1WMl0o/oXXv/0ZcK/q0vbD42RyT3NJ
5kHPKHxKOdSzbQ/xw+oLBJB+xhW4RJnKJmMIjITz6lHJ0Uep2KYarg00JjNGNtr4
/VqJZlN4hWKyPTRBu5aI1Bef0JpmEA==
=xA/S
-----END PGP SIGNATURE-----

--NeIZlyowumXtqXLNOZErcBk1aZbUuvacE--
