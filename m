From: Stefan Kratochwil <stefan.kratochwil@cetitec.com>
Subject: [PATCH net] Fixed NULL ptr deref in enqueue_to_backlog().
Date: Tue, 7 Nov 2017 12:17:06 +0100
Message-ID: <57a3ffb6-3309-3ad5-5a34-e93c3fe3614d@cetitec.com>
References: <484ddb3d-4bb6-46d7-1d5c-3319cdc52d6f@cetitec.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
        boundary="------------FA75E498CD7B68B37B9762AC"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:49899 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755473AbdKGLRx (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 7 Nov 2017 06:17:53 -0500
In-Reply-To: <484ddb3d-4bb6-46d7-1d5c-3319cdc52d6f@cetitec.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org

--------------FA75E498CD7B68B37B9762AC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hey folks,

I replaced the free_skb() call wit a dev_free_skb_any() and performed a
few regression tests on the machines available to me. I was neither able
to reproduce the crash while upping/downing can interfaces during
operation, nor could I observe problems with ethernet connections on my
target hardware (Renesas R-CAR, arm64, kernel 4.9) and on my local
machine (x86_64, upstream kernel net-next).

The patch in the attachment was created against net-next.

Please review.

Thanks :)


On 11/06/2017 12:17 PM, Stefan Kratochwil wrote:
> Hey folks,
>=20
> I probably found a bug in the function mentioned above which leads to a
> WARN_ON() and in many cases to a kernel panic. The problem occurs when =
a
> CAN bus interface is put down using 'ip link' during a tx operation. In
> this situation, a code path exists from within a tx interrupt through
> core/net/dev.c#enqueue_to_backlog() to the non interrupt-safe function
> 'kfree_skb()'. This situation always triggers the 'WARN_ON(in_irq))' in
> net/core/skbuff.c#skb_release_head_state(), and with some luck it leads
> to a NULL pointer dereference.
>=20
> I first found this code path in the 'rcar_canfd' driver (kernel 4.9.58)=
,
> but almost every other CAN driver does the same thing, even in the most
> up-to-date kernel.
>=20
> Now, net/core/dev.c is pretty hot code, and I have no idea what happens
> if we would substitute the 'kfree_skb()' in the 'drop' case of
> 'enqueue_to_backlog()' with a 'dev_kfree_skb_any()'.
>=20
> Some time ago, there was an almost identical issue reported via Bugzill=
a
> (https://bugzilla.kernel.org/show_bug.cgi?id=3D114791), but it was
> abandoned without further comments.
>=20
> Also, an actual fix was applied which addressed a similar bug
> (https://patchwork.kernel.org/patch/5479931/).
>=20
> Looking forward for your opinions!
>=20
>=20
> [12150.231280] ------------[ cut here ]------------
> [12150.232363] rcar_canfd e66c0000.can canif1: bitrate error 0.0%
> [12150.243474] WARNING: CPU: 0 PID: 0 at
> /home/skr/build_snapshot/build/tmp/work-shared/box-m3ulcb/kernel-source=
/net/core/skbuff.c:654
> skb_release_head_state+0xe0/0xe8
> [12150.261301] Modules linked in: can_raw can rcar_canfd mcp251x ravb
> mdio_bitbang can_dev ipv6 autofs4
> [12150.271475]
> [12150.273902] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W
> 4.9.58-box #1
> [12150.282703] Hardware name: BOX based on Renesas M3ULCB (r8a7796) (DT=
)
> [12150.290728] task: ffff00000899f480 task.stack: ffff000008990000
> [12150.297625] PC is at skb_release_head_state+0xe0/0xe8
> [12150.303654] LR is at skb_release_all+0x14/0x30
> [12150.309072] pc : [<ffff000008618090>] lr : [<ffff000008618374>]
> pstate: 000001c5
> [12150.317469] sp : ffff8005fff21ac0
> [12150.321779] x29: ffff8005fff21ac0 x28: 000000000000000c
> [12150.328097] x27: ffff8005fa23e880 x26: 0000000000000087
> [12150.334390] x25: ffff8005fff21bc8 x24: 00000000000001c0
> [12150.340666] x23: ffff8005f59d7800 x22: ffff00000897d000
> [12150.346934] x21: ffff000008629530 x20: ffff00000897d780
> [12150.353192] x19: ffff8005f59d7800 x18: 000000000000000a
> [12150.359441] x17: 0000ffffa4e36c40 x16: ffff00000820a060
> [12150.365680] x15: 00002fd2dc895abe x14: 000d59e4c4b21f40
> [12150.371915] x13: 0000000007ed6b48 x12: 071c71c71c71c71c
> [12150.378141] x11: 00000000000000b5 x10: 0000000000000040
> [12150.384363] x9 : ffff8005fd002da0 x8 : ffff8005fd000028
> [12150.390578] x7 : 0000000000000000 x6 : 000cd24f19d1cf10
> [12150.396778] x5 : 0000000000000018 x4 : 000000000059ecb6
> [12150.402967] x3 : 0000000000000000 x2 : 0000000000000000
> [12150.409153] x1 : ffff000008616808 x0 : 0000000000010102
> [12150.415332]
> [12150.417661] ---[ end trace b157fa53318961ad ]---
> [12150.423133] Call trace:
> [12150.426427] Exception stack(0xffff8005fff218f0 to 0xffff8005fff21a20=
)
> [12150.433738] 18e0:                                   ffff8005f59d7800
> 0001000000000000
> [12150.442471] 1900: ffff8005fff21ac0 ffff000008618090 ffff8005fff21950
> ffff00000862987c
> [12150.451227] 1920: ffff8005fa23e000 ffff8005f505c600 0000000000000080
> 0000000000000001
> [12150.460002] 1940: 0000000000000080 000000000abffe46 ffff8005fff21970
> ffff0000007afc68
> [12150.468801] 1960: ffff8005fa23e000 0000000000000001 ffff8005fff21a00
> ffff0000080ebdf0
> [12150.477613] 1980: ffff8005fc3c4880 ffff8005fce38800 0000000000010102
> ffff000008616808
> [12150.486445] 19a0: 0000000000000000 0000000000000000 000000000059ecb6
> 0000000000000018
> [12150.495297] 19c0: 000cd24f19d1cf10 0000000000000000 ffff8005fd000028
> ffff8005fd002da0
> [12150.504168] 19e0: 0000000000000040 00000000000000b5 071c71c71c71c71c
> 0000000007ed6b48
> [12150.513060] 1a00: 000d59e4c4b21f40 00002fd2dc895abe ffff00000820a060
> 0000ffffa4e36c40
> [12150.521977] [<ffff000008618090>] skb_release_head_state+0xe0/0xe8
> [12150.529178] [<ffff000008618374>] skb_release_all+0x14/0x30
> [12150.535777] [<ffff000008618158>] kfree_skb+0x38/0x108
> [12150.541953] [<ffff000008629530>] enqueue_to_backlog+0xb0/0x238
> [12150.548928] [<ffff0000086296f8>] netif_rx_internal+0x40/0x1a8
> [12150.555828] [<ffff00000862987c>] netif_rx+0x1c/0xb0
> [12150.561853] [<ffff0000007791fc>] can_get_echo_skb+0x3c/0x78 [can_dev=
]
> [12150.569445] [<ffff0000007af754>]
> rcar_canfd_channel_interrupt+0x114/0x718 [rcar_canfd]
> [12150.578490] [<ffff0000080ebdf0>] __handle_irq_event_percpu+0x58/0x24=
0
> [12150.586020] [<ffff0000080ebff4>] handle_irq_event_percpu+0x1c/0x58
> [12150.593263] [<ffff0000080ec078>] handle_irq_event+0x48/0x78
> [12150.599868] [<ffff0000080ef9c8>] handle_fasteoi_irq+0xb8/0x1a0
> [12150.606722] [<ffff0000080eaf44>] generic_handle_irq+0x24/0x38
> [12150.613465] [<ffff0000080eb5a4>] __handle_domain_irq+0x5c/0xb8
> [12150.620284] [<ffff000008080ca8>] gic_handle_irq+0x58/0xb0
>=20
>=20
>=20
> ---
> Diese E-Mail wurde von Avast Antivirus-Software auf Viren gepr=C3=BCft.
> https://www.avast.com/antivirus
>=20

-------------------------------------------------------------------------=
------
Stefan Kratochwil, Software Engineer

CETITEC GmbH
Mannheimer Stra=C3=9Fe 17
D-75179 Pforzheim, Germany

Phone: +49 (0)7231-95688-78
Fax: +49 (0)7231-95688-65

Sitz der Gesellschaft: Pforzheim
Amtsgericht Mannheim: HRB 715734
Gesch=C3=A4ftsf=C3=BChrer: Thomas Keicher
-------------------------------------------------------------------------=
------
Hinweis/Note:
-------------------------------------------------------------------------=
------
Diese E-Mail enthaelt vertrauliche und/oder rechtlich geschuetzte
Informationen. Wenn Sie nicht der richtige Adressat sind oder
diese E-Mail irrtuemlich erhalten haben, informieren Sie bitte sofort
den Absender und loeschen Sie diese Mail. Das unerlaubte Speichern,
Kopieren sowie die unbefugte Weitergabe dieser Mail ist nicht ge-
stattet!

Vielen Dank.

-------------------------------------------------------------------------=
------
This e-mail may contain confidential and/or privileged information.
If you are not the intended recipient (or have received this e-mail
in error) please notify the sender immediately and delete this e-mail.
Any unauthorised copying, disclosure or distribution of the contents
in this  e-mail is strictly forbidden!

Thank you.
-------------------------------------------------------------------------=
------


--------------FA75E498CD7B68B37B9762AC
Content-Type: text/x-patch;
	name="0001-Fixed-NULL-ptr-deref-in-enqueue_to_backlog.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-Fixed-NULL-ptr-deref-in-enqueue_to_backlog.patch"

=46rom 04ed880706fc9fdd6ecd284de47a40c40a091b84 Mon Sep 17 00:00:00 2001
From: Stefan Kratochwil <stefan.kratochwil@cetitec.com>
Date: Tue, 7 Nov 2017 11:48:16 +0100
Subject: [PATCH] Fixed NULL ptr deref in enqueue_to_backlog().

This function may be called from within an interrupt context, e.g. when
putting a CAN interface down while transmitting data. While free_skb()
is not interrupt safe, dev_free_skb_any() is.

See https://marc.info/?l=3Dlinux-netdev&m=3D150996705622284&w=3D2 for mor=
e
details.

Signed-off-by: Stefan Kratochwil <stefan.kratochwil@cetitec.com>
---
 net/core/dev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 30b5fe32c525..6c3a5f1f72a8 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3886,7 +3886,9 @@ static int enqueue_to_backlog(struct sk_buff *skb, =
int cpu,
 	local_irq_restore(flags);
=20
 	atomic_long_inc(&skb->dev->rx_dropped);
-	kfree_skb(skb);
+
+	/* We may have been called from within an IRQ context. */
+	dev_kfree_skb_any(skb);
 	return NET_RX_DROP;
 }
=20
--=20
2.15.0


--------------FA75E498CD7B68B37B9762AC--
