From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Usb to can driver
Date: Tue, 04 Jun 2013 16:41:28 +0200
Message-ID: <51ADFC98.70002@pengutronix.de>
References: <1366737302.3325.36.camel@blackbox>  <51770161.2030005@pengutronix.de> <1366818490.5965.35.camel@blackbox>  <51780336.5060800@pengutronix.de> <1366839193.7226.8.camel@blackbox>  <5194C5B2.7060004@pengutronix.de> <1370351898.3785.16.camel@blackbox>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2SSRXDOPOBLFDGOIQHGBE"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41552 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752451Ab3FDOlh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 4 Jun 2013 10:41:37 -0400
In-Reply-To: <1370351898.3785.16.camel@blackbox>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Max S." <max@schneidersoft.net>
Cc: linux-can <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2SSRXDOPOBLFDGOIQHGBE
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 06/04/2013 03:18 PM, Max S. wrote:
[...]
> [ 1784.427960] gs_usb 4-1:1.0: can_put_echo_skb: BUG! echo_skb is
> occupied!
> [ 1784.493869] gs_usb 4-1:1.0: can_put_echo_skb: BUG! echo_skb is
> occupied!
> [ 1784.745668] ------------[ cut here ]------------
> [ 1784.745701] kernel BUG
> at /build/buildd-linux_3.2.35-2-amd64-v9djlH/linux-3.2.35/drivers/net/c=
an/dev.c:283!
> [ 1784.745719] invalid opcode: 0000 [#1] SMP=20
> [ 1784.745740] CPU 2=20
> [ 1784.745750] Modules linked in: can_raw can gs_usb(O) netconsole
> configfs can_dev ppdev lp rfcomm bnep bluetooth crc16 cpufreq_stats
> cpufreq_userspace cpufreq_powersave cpufreq_conservative fuse nfsd nfs
> nfs_acl auth_rpcgss fscache lockd sunrpc usbhid hid pcan(O) loop arc4
> rt2800usb rt2x00usb rt2800lib rt2x00lib mac80211 cfg80211 rfkill
> crc_ccitt evdev psmouse snd_hda_intel coretemp serio_raw snd_hda_codec
> i2c_i801 snd_hwdep pcspkr i2c_core snd_pcm snd_page_alloc snd_seq
> snd_seq_device snd_timer parport_pc iTCO_wdt parport iTCO_vendor_suppor=
t
> snd uhci_hcd video acpi_cpufreq mperf ehci_hcd usbcore e1000e soundcore=

> button usb_common processor thermal_sys ext2 mbcache sd_mod crc_t10dif
> ahci libahci libata scsi_mod
> [ 1784.746265]=20
> [ 1784.746276] Pid: 7786, comm: cansequence Tainted: G           O
> 3.2.0-4-amd64 #1 Debian 3.2.35-2                  /DN2800MT
> [ 1784.746297] RIP: 0010:[<ffffffffa03d9552>]  [<ffffffffa03d9552>]
> can_put_echo_skb+0x16/0x106 [can_dev]
> [ 1784.746319] RSP: 0018:ffff880117265b38  EFLAGS: 00010246
> [ 1784.746327] RAX: ffff880117126938 RBX: ffff88012946e8c0 RCX:
> ffff88012a8da090
> [ 1784.746336] RDX: 000000000000000a RSI: ffff880117126000 RDI:
> ffff88012946e8c0
> [ 1784.746344] RBP: ffff880117126000 R08: ffff88012a8da090 R09:
> 0000000000000018
> [ 1784.746352] R10: 000000000000ffff R11: 0000000000000246 R12:
> ffff880037c102a0
> [ 1784.746361] R13: ffff88012946e8c0 R14: ffff880117126870 R15:
> ffff880117126000
> [ 1784.746370] FS:  00007fcfbc52c700(0000) GS:ffff88012fd00000(0000)
> knlGS:0000000000000000
> [ 1784.746379] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> [ 1784.746387] CR2: 00007fc450074e38 CR3: 0000000129e6f000 CR4:
> 00000000000006e0
> [ 1784.746396] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [ 1784.746404] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7:
> 0000000000000400
> [ 1784.746414] Process cansequence (pid: 7786, threadinfo
> ffff880117264000, task ffff880120f54140)
> [ 1784.746428] Stack:
> [ 1784.746438]  ffff880117126000 ffff88012742b680 ffff880037c102a0
> ffff88012946e8c0
> [ 1784.746475]  ffff880117126870 ffffffffa03f102a ffff88012908dbc0
> 00000000000f41ff
> [ 1784.746504]  0000000001000000 ffff88012946e8c0 0000000000000010
> ffff880117126000
> [ 1784.746527] Call Trace:
> [ 1784.746546]  [<ffffffffa03f102a>] ? gs_can_start_xmit+0x19a/0x299
> [gs_usb]
> [ 1784.746569]  [<ffffffff8128f2ff>] ? dev_hard_start_xmit+0x3cd/0x513
> [ 1784.746589]  [<ffffffff812a597f>] ? sch_direct_xmit+0x61/0x135
> [ 1784.746607]  [<ffffffff812a5b4d>] ? __qdisc_run+0xfa/0x112
> [ 1784.746625]  [<ffffffff8128f763>] ? dev_queue_xmit+0x31e/0x45b
> [ 1784.746644]  [<ffffffff810363d8>] ? should_resched+0x5/0x23
> [ 1784.746665]  [<ffffffffa03f6435>] ? can_send+0xe9/0x134 [can]
> [ 1784.746685]  [<ffffffff8127bca1>] ? sock_tx_timestamp+0x29/0x35
> [ 1784.746705]  [<ffffffffa04053a2>] ? raw_sendmsg+0xf3/0x130 [can_raw]=

> [ 1784.746726]  [<ffffffff8127f7a4>] ? sock_update_classid+0x2c/0x42
> [ 1784.746746]  [<ffffffff8127d0e2>] ? sock_aio_write+0x121/0x135
> [ 1784.746769]  [<ffffffff810f95d4>] ? do_sync_write+0xb4/0xec
> [ 1784.746790]  [<ffffffff8100d6ec>] ? __switch_to+0x181/0x258
> [ 1784.746809]  [<ffffffff81039817>] ? finish_task_switch+0x88/0xb9
> [ 1784.746832]  [<ffffffff81163995>] ? security_file_permission
> +0x16/0x2d
> [ 1784.746852]  [<ffffffff810f9ccc>] ? vfs_write+0xa9/0xe9
> [ 1784.746872]  [<ffffffff810f9ea2>] ? sys_write+0x45/0x6b
> [ 1784.746895]  [<ffffffff81352012>] ? system_call_fastpath+0x16/0x1b
> [ 1784.746910] Code: e0 48 8b 83 10 08 00 00 48 c7 04 e8 00 00 00 00 41=

> 5b 5b 5d c3 41 56 41 55 41 54 55 48 89 f5 53 3b 96 08 08 00 00 48 89 fb=

> 72 02 <0f> 0b f6 86 b2 01 00 00 04 0f 84 c8 00 00 00 8a 47 7d 83 e0 07 =

> [ 1784.747301] RIP  [<ffffffffa03d9552>] can_put_echo_skb+0x16/0x106
> [can_dev]
> [ 1784.747324]  RSP <ffff880117265b38>
> [ 1784.747345] ---[ end trace 811113d28006e99a ]---
> [ 1784.747357] Kernel panic - not syncing: Fatal exception in interrupt=

> [ 1784.747368] Pid: 7786, comm: cansequence Tainted: G      D    O
> 3.2.0-4-amd64 #1 Debian 3.2.35-2
> [ 1784.747377] Call Trace:
> [ 1784.747390]  [<ffffffff813467bc>] ? panic+0x95/0x1a5
> [ 1784.747403]  [<ffffffff8134de86>] ? oops_end+0xa9/0xb6
> [ 1784.747416]  [<ffffffff8100e965>] ? do_invalid_op+0x87/0x91
> [ 1784.747431]  [<ffffffffa03d9552>] ? can_put_echo_skb+0x16/0x106
> [can_dev]
> [ 1784.747444]  [<ffffffff81037e96>] ? set_next_entity+0x32/0x55
> [ 1784.747456]  [<ffffffff8100d025>] ? paravirt_write_msr+0xb/0xe
> [ 1784.747468]  [<ffffffff8100d6ec>] ? __switch_to+0x181/0x258
> [ 1784.747480]  [<ffffffff810397dd>] ? finish_task_switch+0x4e/0xb9
> [ 1784.747493]  [<ffffffff81353feb>] ? invalid_op+0x1b/0x20
> [ 1784.747507]  [<ffffffffa03d9552>] ? can_put_echo_skb+0x16/0x106
> [can_dev]
> [ 1784.747561]  [<ffffffffa01800b0>] ? usb_anchor_urb+0x25/0x65
> [usbcore]
> [ 1784.747577]  [<ffffffffa03f102a>] ? gs_can_start_xmit+0x19a/0x299
> [gs_usb]
> [ 1784.747592]  [<ffffffff8128f2ff>] ? dev_hard_start_xmit+0x3cd/0x513
> [ 1784.747606]  [<ffffffff812a597f>] ? sch_direct_xmit+0x61/0x135
> [ 1784.747617]  [<ffffffff812a5b4d>] ? __qdisc_run+0xfa/0x112
> [ 1784.747629]  [<ffffffff8128f763>] ? dev_queue_xmit+0x31e/0x45b
> [ 1784.747641]  [<ffffffff810363d8>] ? should_resched+0x5/0x23
> [ 1784.747655]  [<ffffffffa03f6435>] ? can_send+0xe9/0x134 [can]
> [ 1784.747669]  [<ffffffff8127bca1>] ? sock_tx_timestamp+0x29/0x35
> [ 1784.747682]  [<ffffffffa04053a2>] ? raw_sendmsg+0xf3/0x130 [can_raw]=

> [ 1784.747695]  [<ffffffff8127f7a4>] ? sock_update_classid+0x2c/0x42
> [ 1784.747707]  [<ffffffff8127d0e2>] ? sock_aio_write+0x121/0x135
> [ 1784.747721]  [<ffffffff810f95d4>] ? do_sync_write+0xb4/0xec
> [ 1784.747734]  [<ffffffff8100d6ec>] ? __switch_to+0x181/0x258
> [ 1784.747746]  [<ffffffff81039817>] ? finish_task_switch+0x88/0xb9
> [ 1784.747763]  [<ffffffff81163995>] ? security_file_permission
> +0x16/0x2d
> [ 1784.747775]  [<ffffffff810f9ccc>] ? vfs_write+0xa9/0xe9
> [ 1784.747786]  [<ffffffff810f9ea2>] ? sys_write+0x45/0x6b
> [ 1784.747799]  [<ffffffff81352012>] ? system_call_fastpath+0x16/0x1b
> [42043.689364] BUG: scheduling while atomic: swapper/0/0/0x10000100
> [42043.690985] Stack:
> [42043.691116] Call Trace:
> [42043.691211] Code: d2 65 48 8b 04 25 c8 c6 00 00 48 89 d1 48 2d c8 1f=

> 00 00 0f 01 c8 0f ae f0 e8 c2 fc ff ff 85 c0 75 0b 31 c0 48 89 c1 fb 0f=

> 01 c9 <eb> 05 e8 98 fc ff ff 65 8b 3c 25 08 dc 00 00 e8 9b fd ff ff 65
>=20
> The first two lines tell me I'm not using can_put_echo_skb correctly.
> I can only imagine there is a kind of race condition in the
> gs_*_tx_context group of functions, but i don't know how to solve it.
> The fact that the driver works fine at lower CAN speeds again makes me
> want to think race condition.

http://lxr.free-electrons.com/source/drivers/net/can/dev.c?v=3D3.2#L283

The "index" parameter is bigger than the MAX_TX_URBS, as defined here:

+	netdev =3D alloc_candev(sizeof(struct gs_can), MAX_TX_URBS);

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2SSRXDOPOBLFDGOIQHGBE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlGt/JwACgkQjTAFq1RaXHMkWwCfTMyiqzvORFGyoTzWt4BFy2J6
IPYAn1cjfIv45BZDXu9B2dsjrVtIuvie
=KSMV
-----END PGP SIGNATURE-----

------enig2SSRXDOPOBLFDGOIQHGBE--
