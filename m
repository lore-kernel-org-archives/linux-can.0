From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: KMSAN: uninit-value in can_receive
Date: Mon, 18 Nov 2019 21:29:54 +0100
Message-ID: <deedd609-6f3b-8035-47e1-252ab221faa1@pengutronix.de>
References: <0000000000005c08d10597a3a05d@google.com>
 <a5f73d92-fdf2-2590-c863-39a181dca8e1@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="4lfuLS5FUCQMFuAJ7EKKxq2kCUyYMXWZ8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a5f73d92-fdf2-2590-c863-39a181dca8e1@hartkopp.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Hartkopp <socketcan@hartkopp.net>, syzbot <syzbot+b02ff0707a97e4e79ebb@syzkaller.appspotmail.com>, davem@davemloft.net, glider@google.com, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4lfuLS5FUCQMFuAJ7EKKxq2kCUyYMXWZ8
Content-Type: multipart/mixed; boundary="xcSkRBkEGR9QYePLhqRmrIc2GDGTHmLBT";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
 syzbot <syzbot+b02ff0707a97e4e79ebb@syzkaller.appspotmail.com>,
 davem@davemloft.net, glider@google.com, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
Message-ID: <deedd609-6f3b-8035-47e1-252ab221faa1@pengutronix.de>
Subject: Re: KMSAN: uninit-value in can_receive
References: <0000000000005c08d10597a3a05d@google.com>
 <a5f73d92-fdf2-2590-c863-39a181dca8e1@hartkopp.net>
In-Reply-To: <a5f73d92-fdf2-2590-c863-39a181dca8e1@hartkopp.net>

--xcSkRBkEGR9QYePLhqRmrIc2GDGTHmLBT
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 11/18/19 9:25 PM, Oliver Hartkopp wrote:
> On 18/11/2019 20.05, syzbot wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:=C2=A0=C2=A0=C2=A0 9c6a7162 kmsan: remove unneeded annotat=
ions in bio
>> git tree:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://github.com/googl=
e/kmsan.git master
>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D14563416e0=
0000
>> kernel config:=C2=A0 https://syzkaller.appspot.com/x/.config?x=3D9e324=
dfe9c7b0360
>> dashboard link:=20
>> https://syzkaller.appspot.com/bug?extid=3Db02ff0707a97e4e79ebb
>> compiler:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clang version 9.0.0 (/ho=
me/glider/llvm/clang=20
>> 80fee25776c2fb61e74c1ecb1a523375c2500b69)
>>
>> Unfortunately, I don't have any reproducer for this crash yet.
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the com=
mit:
>> Reported-by: syzbot+b02ff0707a97e4e79ebb@syzkaller.appspotmail.com
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>> BUG: KMSAN: uninit-value in can_receive+0x23c/0x5e0 net/can/af_can.c:6=
49
>> CPU: 1 PID: 3490 Comm: syz-executor.2 Not tainted 5.4.0-rc5+ #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIO=
S=20
>> Google 01/01/2011
>> Call Trace:
>>  =C2=A0<IRQ>
>>  =C2=A0__dump_stack lib/dump_stack.c:77 [inline]
>>  =C2=A0dump_stack+0x191/0x1f0 lib/dump_stack.c:113
>>  =C2=A0kmsan_report+0x128/0x220 mm/kmsan/kmsan_report.c:108
>>  =C2=A0__msan_warning+0x73/0xe0 mm/kmsan/kmsan_instr.c:245
>>  =C2=A0can_receive+0x23c/0x5e0 net/can/af_can.c:649
>>  =C2=A0can_rcv+0x188/0x3a0 net/can/af_can.c:685
>=20
> In line 649 of 5.4.0-rc5+ we can find a while() statement:
>=20
> while (!(can_skb_prv(skb)->skbcnt))
> 	can_skb_prv(skb)->skbcnt =3D atomic_inc_return(&skbcounter);
>=20
> In linux/include/linux/can/skb.h we see:
>=20
> static inline struct can_skb_priv *can_skb_prv(struct sk_buff *skb)
> {
> 	return (struct can_skb_priv *)(skb->head);
> }
>=20
> IMO accessing can_skb_prv(skb)->skbcnt at this point is a valid=20
> operation which has no uninitialized value.
>=20
> Can this probably be a false positive of KMSAN?

The packet is injected via the packet socket into the kernel. Where does
skb->head point to in this case? When the skb is a proper
kernel-generated skb containing a CAN-2.0 or CAN-FD frame skb->head is
maybe properly initialized?

>   do_softirq kernel/softirq.c:338 [inline]
>   __local_bh_enable_ip+0x184/0x1d0 kernel/softirq.c:190
>   local_bh_enable+0x36/0x40 include/linux/bottom_half.h:32
>   rcu_read_unlock_bh include/linux/rcupdate.h:688 [inline]
>   __dev_queue_xmit+0x38e8/0x4200 net/core/dev.c:3900
>   dev_queue_xmit+0x4b/0x60 net/core/dev.c:3906
>   packet_snd net/packet/af_packet.c:2959 [inline]
>   packet_sendmsg+0x82d7/0x92e0 net/packet/af_packet.c:2984
                                 ^^^^^^^^^^^^^^^^^^^^^^
>   sock_sendmsg_nosec net/socket.c:637 [inline]
>   sock_sendmsg net/socket.c:657 [inline]
>   ___sys_sendmsg+0x14ff/0x1590 net/socket.c:2311
>   __sys_sendmsg net/socket.c:2356 [inline]
>   __do_sys_sendmsg net/socket.c:2365 [inline]
>   __se_sys_sendmsg+0x305/0x460 net/socket.c:2363
>   __x64_sys_sendmsg+0x4a/0x70 net/socket.c:2363
>   do_syscall_64+0xb6/0x160 arch/x86/entry/common.c:291
>   entry_SYSCALL_64_after_hwframe+0x63/0xe7

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--xcSkRBkEGR9QYePLhqRmrIc2GDGTHmLBT--

--4lfuLS5FUCQMFuAJ7EKKxq2kCUyYMXWZ8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3S/0IACgkQWsYho5Hk
nSBH5Qf/XueijbPhWRM7b//MP73DST/n7wReugm1aRecsNHtLPxRDiGRUkAy8UtY
80pqOEcZHZhr+ULyK0DrBUPqt3cM0PepKYEFqvLcuvuo4JQoLiWftZusD0Ym9+BK
4moaRf6SnspV7z92s21EMJM8epMv9EFkQRxs2+W8TjMkDSf2VyXaw8uYlB/r8fbb
x2SfwuKkCj7hrd0+2AJ38SSXXBo375biC3kUVh3ROXPNZLpmQBZns3onZfX/AWPN
Wo/OotqzQgMA/oMv83tSq+eAxFebf4qfxvhEfXaMlU9jtKmw/dwkq1GQ67jJicvz
0ZfKh57N2QhgP4pXLr3WOzQ67uLJUA==
=JaOQ
-----END PGP SIGNATURE-----

--4lfuLS5FUCQMFuAJ7EKKxq2kCUyYMXWZ8--
