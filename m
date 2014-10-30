From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: AW: Calling can_free_echo_skb() from interrupt causes WARN
Date: Thu, 30 Oct 2014 21:37:55 +0100
Message-ID: <5452A1A3.90601@hartkopp.net>
References: <8CE1D0B9BFD2404DA079DDE1814A6F2E02BB65718FFE@esd-s3.esd.local> <5451555F.1090800@hartkopp.net> <8CE1D0B9BFD2404DA079DDE1814A6F2E02BB65D1B8E5@esd-s3.esd.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:57577 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161020AbaJ3Uh5 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 30 Oct 2014 16:37:57 -0400
In-Reply-To: <8CE1D0B9BFD2404DA079DDE1814A6F2E02BB65D1B8E5@esd-s3.esd.local>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?windows-1252?Q?Thomas_K=F6rper?= <Thomas.Koerper@esd.eu>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Maybe other driver did not had this case to remove the echo skb inside =
the
error handling - or they did not test it like this - or the debugging w=
as not
enabled ;-)

Don't know.

Would you like to send a patch - as you discovered the issue?

Regards,
Oliver

On 10/30/2014 05:11 AM, Thomas K=F6rper wrote:
> Hi Oliver,
>=20
> not fixed. I think it should be changed - but as mentioned, I don't u=
nderstand why this never happened before / someone else.
>=20
>=20
> Regards,
>     Thomas
>=20
>=20
> -----Urspr=FCngliche Nachricht-----
> Von: Oliver Hartkopp [mailto:socketcan@hartkopp.net]=20
> Gesendet: Mittwoch, 29. Oktober 2014 22:00
> An: Thomas K=F6rper; linux-can@vger.kernel.org
> Betreff: Re: Calling can_free_echo_skb() from interrupt causes WARN
>=20
> Hi Thomas,
>=20
> did you fix this - or do we need to change it in can_free_echo_skb() =
globally?
>=20
> Regards,
> Oliver
>=20
> On 30.09.2014 06:21, Thomas K=F6rper wrote:
>> Hi linux-can,
>>
>> I'm working on a new driver for one of our CAN cards.
>>
>> In the TX error interrupt I call can_free_echo_skb(), but I get a wa=
rning and stack trace then. I'd say its kfree_skb() must not be called =
from interrupt context - replacing it by dev_kfree_skb_any() seems to f=
ix it.
>>
>> But I'm not the first one calling can_free_echo_skb() from interrupt=
=2E.. so, what am I missing?
>>
>>
>> Regards,
>>      Thomas
>>
>>
>> [ 1153.360705] ------------[ cut here ]------------
>> [ 1153.360715] WARNING: CPU: 0 PID: 31 at net/core/skbuff.c:563 skb_=
release_head_state+0xb9/0xd0()
>> [ 1153.360717] Modules linked in: can_raw esd402(O) can_dev(O) can a=
rc4 md4 nls_utf8 cifs nfsv3 i915 nfsd auth_rpcgss nfs_acl rfcomm bnep n=
fs bluetooth hisax lockd video drm_kms_helper sunrpc drm coretemp kvm i=
sdn fscache dell_wmi gpio_ich sparse_keymap i2c_algo_bit crc_ccitt binf=
mt_misc dcdbas lpc_ich serio_raw wmi mac_hid parport_pc ppdev lp parpor=
t hid_generic usbhid hid r8169 e1000e mii psmouse ptp pps_core
>> [ 1153.360754] CPU: 0 PID: 31 Comm: kworker/0:1 Tainted: G          =
 O   3.17.0-rc4+ #1
>> [ 1153.360756] Hardware name: Dell Inc. OptiPlex 760                =
 /0M858N, BIOS A05 08/17/2009
>> [ 1153.360760]  00000000 00000000 f580dedc c167906f 00000000 f580df0=
c c105bb7e c187cf30
>> [ 1153.360764]  00000000 0000001f c1911ffb 00000233 c158b909 c158b90=
9 f4e1a600 00000003
>> [ 1153.360768]  f4e1a600 f580df1c c105bc42 00000009 00000000 f580df2=
8 c158b909 f4e1a600
>> [ 1153.360772] Call Trace:
>> [ 1153.360778]  [<c167906f>] dump_stack+0x41/0x52
>> [ 1153.360782]  [<c105bb7e>] warn_slowpath_common+0x7e/0xa0
>> [ 1153.360784]  [<c158b909>] ? skb_release_head_state+0xb9/0xd0
>> [ 1153.360786]  [<c158b909>] ? skb_release_head_state+0xb9/0xd0
>> [ 1153.360788]  [<c105bc42>] warn_slowpath_null+0x22/0x30
>> [ 1153.360791]  [<c158b909>] skb_release_head_state+0xb9/0xd0
>> [ 1153.360793]  [<c158be90>] skb_release_all+0x10/0x30
>> [ 1153.360795]  [<c158bf06>] kfree_skb+0x36/0x80
>> [ 1153.360799]  [<f8486938>] ? can_free_echo_skb+0x28/0x40 [can_dev]
>> [ 1153.360802]  [<f8486938>] can_free_echo_skb+0x28/0x40 [can_dev]
>> [ 1153.360805]  [<f849a12c>] esd_pci402_interrupt+0x34c/0x57a [esd40=
2]
>> [ 1153.360809]  [<c10a75b5>] handle_irq_event_percpu+0x35/0x180
>> [ 1153.360811]  [<c10a7623>] ? handle_irq_event_percpu+0xa3/0x180
>> [ 1153.360813]  [<c10a7731>] handle_irq_event+0x31/0x50
>> [ 1153.360816]  [<c10a9c7f>] handle_fasteoi_irq+0x6f/0x120
>> [ 1153.360818]  [<c10a9c10>] ? handle_edge_irq+0x110/0x110
>> [ 1153.360822]  [<c1011b61>] handle_irq+0x71/0x90
>> [ 1153.360823]  <IRQ>  [<c168152c>] do_IRQ+0x3c/0xd0
>> [ 1153.360829]  [<c1680b6c>] common_interrupt+0x2c/0x34
>> [ 1153.360834]  [<c107d277>] ? finish_task_switch+0x47/0xf0
>> [ 1153.360836]  [<c167c27b>] __schedule+0x35b/0x7e0
>> [ 1153.360839]  [<c10a5334>] ? console_unlock+0x2c4/0x4d0
>> [ 1153.360842]  [<c13df500>] ? n_tty_receive_buf_common+0x890/0x890
>> [ 1153.360845]  [<c10707b6>] ? process_one_work+0x196/0x370
>> [ 1153.360847]  [<c167c723>] schedule+0x23/0x60
>> [ 1153.360849]  [<c1070de1>] worker_thread+0x161/0x460
>> [ 1153.360852]  [<c1090fcf>] ? __wake_up_locked+0x1f/0x30
>> [ 1153.360854]  [<c1070c80>] ? rescuer_thread+0x2f0/0x2f0
>> [ 1153.360856]  [<c1074f01>] kthread+0xa1/0xc0
>> [ 1153.360859]  [<c1680401>] ret_from_kernel_thread+0x21/0x30
>> [ 1153.360861]  [<c1074e60>] ? kthread_create_on_node+0x110/0x110
>> [ 1153.360863] ---[ end trace 5ff83639cbb74b35 ]---
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-can"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>=20
>=20
