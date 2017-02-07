From: laurent vaudoit <laurent.vaudoit@gmail.com>
Subject: Re: J1939: put_session BUG_ON
Date: Tue, 7 Feb 2017 16:29:49 +0100
Message-ID: <CAA7hF3xqEpLOwOGXxCbC4LxJ=Oa2v6wL+AO9tHFCWWpERsTBVQ@mail.gmail.com>
References: <CAA7hF3yAMSbd1HM79N12vfw0VKa96nCJsMLgcOA-=Oomqv-Qpg@mail.gmail.com>
 <20170127113043.GD29959@airbook.vandijck-laurijssen.be> <CAA7hF3y_epAa3ky+vds9QDjbEWzAcBfk_Ab6Yuk5vz-fTDoQ2g@mail.gmail.com>
 <20170127152142.GA29115@airbook.vandijck-laurijssen.be> <CAA7hF3wivkSAwNioPpU5vP7TONYTq-_Bdrpkgtm4+U1ZovFgjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:33759 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754525AbdBGP3u (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 7 Feb 2017 10:29:50 -0500
Received: by mail-oi0-f50.google.com with SMTP id w204so66530270oiw.0
        for <linux-can@vger.kernel.org>; Tue, 07 Feb 2017 07:29:50 -0800 (PST)
In-Reply-To: <CAA7hF3wivkSAwNioPpU5vP7TONYTq-_Bdrpkgtm4+U1ZovFgjw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: laurent vaudoit <laurent.vaudoit@gmail.com>, linux-can <linux-can@vger.kernel.org>

Hi Kurt,

On Fri, Jan 27, 2017 at 10:57 PM, laurent vaudoit
<laurent.vaudoit@gmail.com> wrote:
> On Fri, Jan 27, 2017 at 4:21 PM, Kurt Van Dijck
> <dev.kurt@vandijck-laurijssen.be> wrote:
>>
>>> Hi Kurt,
>>> On Fri, Jan 27, 2017 at 12:30 PM, Kurt Van Dijck
>>> <dev.kurt@vandijck-laurijssen.be> wrote:
>>> > Hey,
>>> >
>>> >> Hi,
>>> >>
>>> >> i'm using old j1939 way on a project (with modified iproute2)
>>> >> and my client detect some problem when making some robustness test (weird
>>> >> test and not
>>> >> available test in my mind).
>>> >>
>>> >> on the board, we have two can interface, with j1939 on, and source adress
>>> >> 0x4a on each.
>>> >
>>> > OK
>>> >
>>> >> the 2 can interace are plugged together (this is the weird stuff for me)
>>> >
>>> > Well, that's illegal in j1939. You cannot have 2 cannodes on the bus
>>> > sharing the same source address.
>>> >
>>> > You can debate if the kernel should support this properly or not.
>>>
>>> I agree with you this is illegal, the problem is that our client does
>>> not want to "hear" this explanation
>>
>> I assume your client adheres the "linux should support this properly"
>> side then.
> it seems ;)
>>
>>> >
>>> >>
>>> >> from an external canalyzer, we send a pgn request
>>> >> 18ea4a01x 0xcd 0xfe 0x00
>>> >>
>>> >> on this, the client application wants to answer a segmented frame on both
>>> >> interfaces
>>> >> so on each interface we send a rts message (pgn 0xEC00) with the same SA.
>>> >>
>>> >> nobody answer with the CTS message, and so my interface wants to send abort
>>> >> message.
>>> >
>>> > both interfaces send the abort, if I'm not mistaken.
>>>
>>> yes i think so, but i go into the BUG_ON function during the first abort.
>>> >
>>> >>
>>> >> and at this step i have a kernel BUG in transport/put_session function
>>> >> BUG_ON(!list_empty(&session->list));
>>> >>
>>> >> Would you have an idea of what could lead to this behaviour?
>>> >> What is the goal of this line code?
>>> >
>>> > I checked j1939-v3.8 branch (my local one, since you didn't really specify).
>>> > But my conclusion is similar to my latest j1939d-v4.x branch.
>>>
>>> i use the 3.10 kernel (i've check on different version, and there is
>>> no big difference i think)
>>
>> I agree, there's no real difference
>>
>>> >
>>> > The immediate goal is to prevent to remove the session while it has not
>>> > been removed from a list (so it is still possible to match against the
>>> > session).
>>> >
>>> > I think that you triggered a condition where you received an abort
>>> > message around the time that the timeout is expiring.
>>> > So you will end up destroying the session from both (a) abort reception
>>> > and (b) session expiry.
>>> > This condition is hard to simulate, I'm sure that aborts did not crash
>>> > all the time, it did work.
>>>
>>> you're right, abort works well on a standard configuration (if i do
>>> not plug can0/1 together)
>>
>> Can you attache the output of BUG_ON(),
>> i'm curious to see the stack trace?
>
> i will be out of my office for next week, i will send you the log when
> i come back

here is the backtrace when i get the crash

j1939xtp_rx_rts: connection exists (2 4a 01)
------------[ cut here ]------------
kernel BUG at net/can/sj1939/transport.c:165!
Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
Modules linked in: cdc_mbim option cdc_ncm usb_wwan usbserial
bt8xxx(O) mwifiex_sdio(O) mwifiex(O) cfg80211(O) g_et4
CPU: 1 PID: 93 Comm: protocol Tainted: G           O
3.10.17-rt12+pamela-quad-4.3.0+g353a761 #3
task: ea432a00 ti: ea442000 task.ti: ea442000
PC is at put_session+0x184/0x188
LR is at j1939_recv_transport+0x23c/0x368
pc : [<80414970>]    lr : [<804169f8>]    psr: 800f0113
sp : ea443d68  ip : 00000000  fp : 80635040
r10: eb2daf48  r9 : 000004d0  r8 : eb018008
r7 : 00000010  r6 : eb2daf18  r5 : eb018040  r4 : eb72d700
r3 : eb72d800  r2 : ffffffff  r1 : fffffffe  r0 : 00000000
Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5387d  Table: 7bb0404a  DAC: 00000015
Process protocol (pid: 93, stack limit = 0xea442238)
Stack: (0xea443d68 to 0xea444000)
3d60:                   eb2daf00 eb018040 eb2daf18 00000010 eb018008 804169f8
3d80: ffffffff eb2daf00 eb018040 eb2daf00 eb018040 eb2daf18 00000010 80410834
3da0: eb2daf00 eb018040 eb2daf18 eb2daf00 eb018040 8041097c cdf1cf23 00000004
3dc0: 00001807 00000000 00000000 00000000 00000000 00000000 00000000 00000000
3de0: 00000000 00000000 00000000 00000000 eadb3640 00000003 eb2daf00 98ec014a
3e00: ead5c000 8060dfa8 00000000 80406d20 806add70 eb2daf00 00000000 ea478800
3e20: ea478800 80406f04 00000118 ea478800 00000001 eb2daf00 00000c00 804075d4
3e40: 00000c00 ea478800 eb2daf00 806157e8 8060df94 80308dec 805fffc0 805fffc0
3e60: 00000000 00000000 ea432a00 ea442001 ea432a00 eb2daf00 805ff6a4 8060dfa8
3e80: eb93a940 eb2daf00 00000005 0155628c 00000000 eb2daf00 80698748 ea478800
3ea0: 00000010 8030907c ea478800 eb93a940 00000000 00000005 0155628c 00000000
3ec0: eb2daf00 3588f2e0 00000005 80294334 00000020 00187748 ea432a00 ea448000
3ee0: 806275e8 00000000 00000000 00000020 806275f8 00000020 eb4ec494 802121cc
3f00: 00000000 ea442028 00000018 8053e548 00000007 ea448000 ea443f38 806275e8
3f20: 80047b30 ea442000 00000000 306e6163 ea432a00 80047b30 ea443f38 ea443f38
3f40: 80211f2c ea083eb8 00000000 806275e8 80211f2c 00000000 00000000 00000000
3f60: 00000000 80047254 ea443f84 00000000 ea442000 806275e8 00000000 00000000
3f80: ea443f80 ea443f80 00000000 00000000 ea443f90 ea443f90 ea443fac ea083eb8
3fa0: 800471b0 00000000 00000000 8000ed18 00000000 00000000 00000000 00000000
3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
3fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[<80414970>] (put_session+0x184/0x188) from [<804169f8>]
(j1939_recv_transport+0x23c/0x368)
[<804169f8>] (j1939_recv_transport+0x23c/0x368) from [<80410834>]
(j1939_recv+0xa4/0xb4)
[<80410834>] (j1939_recv+0xa4/0xb4) from [<8041097c>]
(j1939_can_recv+0x138/0x224)
[<8041097c>] (j1939_can_recv+0x138/0x224) from [<80406d20>]
(can_rcv_filter+0x118/0x2a0)
[<80406d20>] (can_rcv_filter+0x118/0x2a0) from [<80406f04>]
(can_receive+0x5c/0x90)
[<80406f04>] (can_receive+0x5c/0x90) from [<804075d4>]
(can_generic_rcv+0x98/0x154)
[<804075d4>] (can_generic_rcv+0x98/0x154) from [<80308dec>]
(__netif_receive_skb_core+0x584/0x798)
[<80308dec>] (__netif_receive_skb_core+0x584/0x798) from [<8030907c>]
(netif_receive_skb+0x1c/0xac)
[<8030907c>] (netif_receive_skb+0x1c/0xac) from [<80294334>]
(actia_rx_handler+0xac/0x16c)
[<80294334>] (actia_rx_handler+0xac/0x16c) from [<802121cc>]
(actiaProt_rx_work_handler+0x2a0/0x5f4)
[<802121cc>] (actiaProt_rx_work_handler+0x2a0/0x5f4) from [<80047254>]
(kthread+0xa4/0xa8)
[<80047254>] (kthread+0xa4/0xa8) from [<8000ed18>] (ret_from_fork+0x14/0x3c)
Code: e5931000 e8bd41f0 eaf0adf7 e7f001f2 (e7f001f2)
---[ end trace 0000000000000002 ]---
Kernel panic - not syncing: Fatal exception
CPU3: stopping
CPU: 3 PID: 1576 Comm: java Tainted: G      D    O
3.10.17-rt12+pamela-quad-4.3.0+g353a761 #3
[<800145e8>] (unwind_backtrace+0x0/0x134) from [<800120fc>]
(show_stack+0x10/0x14)
[<800120fc>] (show_stack+0x10/0x14) from [<80013680>] (handle_IPI+0x108/0x168)
[<80013680>] (handle_IPI+0x108/0x168) from [<800084e4>]
(gic_handle_irq+0x58/0x5c)
[<800084e4>] (gic_handle_irq+0x58/0x5c) from [<8000ea1c>] (__irq_usr+0x3c/0x60)
Exception stack(0xebd91fb0 to 0xebd91ff8)
1fa0:                                     64334c70 00000009 64334c70 90500001
1fc0: 62b5ead0 00000008 76a1d9a0 63fc61bc 62b5eb2c 63bb5018 62dc5c00 62b5eafc
1fe0: 62b5ead4 62b5ead0 741e61c0 741ecaf0 00000010 ffffffff
CPU2: stopping
CPU: 2 PID: 1430 Comm: java Tainted: G      D    O
3.10.17-rt12+pamela-quad-4.3.0+g353a761 #3
[<800145e8>] (unwind_backtrace+0x0/0x134) from [<800120fc>]
(show_stack+0x10/0x14)
[<800120fc>] (show_stack+0x10/0x14) from [<80013680>] (handle_IPI+0x108/0x168)
[<80013680>] (handle_IPI+0x108/0x168) from [<800084e4>]
(gic_handle_irq+0x58/0x5c)
[<800084e4>] (gic_handle_irq+0x58/0x5c) from [<8000ea1c>] (__irq_usr+0x3c/0x60)
Exception stack(0xebbadfb0 to 0xebbadff8)
dfa0:                                     74033018 00000002 00000005 00000061
dfc0: 763d68c4 000000b9 763d6950 74033018 769eb338 00000000 76206800 763d68ac
dfe0: 00000001 763d68a0 768bbe34 768baf70 20000010 ffffffff
CPU0: stopping
CPU: 0 PID: 1431 Comm: java Tainted: G      D    O
3.10.17-rt12+pamela-quad-4.3.0+g353a761 #3
[<800145e8>] (unwind_backtrace+0x0/0x134) from [<800120fc>]
(show_stack+0x10/0x14)
[<800120fc>] (show_stack+0x10/0x14) from [<80013680>] (handle_IPI+0x108/0x168)
[<80013680>] (handle_IPI+0x108/0x168) from [<800084e4>]
(gic_handle_irq+0x58/0x5c)
[<800084e4>] (gic_handle_irq+0x58/0x5c) from [<8000ea1c>] (__irq_usr+0x3c/0x60)
Exception stack(0xebc5ffb0 to 0xebc5fff8)
ffa0:                                     76206488 00000049 63f2b5e0 00000029
ffc0: 632b5c78 63f29a50 0000000f 76206800 632b6258 769b7338 63b59020 763a1de4
ffe0: 632b5c98 763a1d88 7669299c 7668f460 80040010 ffffffff

hope it can help.
>>
>> I'm trying to understand how it can fail, but I fail to see it.
>>
>>>
>>> > Can this be related to the rtpatch, where both events run from a thread
>>> > rather than a softirq, which may schedule at some critical point in my
>>> > code?
>>> >
>>> >>
>>> >> I've tested with and without rtpatch with the same behaviour.
>>
>> Ok, then I can think "regular" back again.
>>
>> Multicore or singlecore?
>
> i've tested for now only on a quad core board, but i will be able to
> test on a single core easily, i will keep you inform
>>
>>> >
>>> > That means you're pretty successfull already with running can-j1939 with
>>> > rtpatch? nice to hear.
>>> >
>>> yes it runs pretty well even with rtpatch except i had to comment a
>>> put_session call in rx_task (i think we allready discuss that), and
>>> may be the point can be related.
>>> >>
>>> >> Another question, on my board we have rtpatch, and so the in(interrupt
>>> >> function allways return 0 (as with rtpatch interrupt are kernel threads).
>>> >> Is this point can lead to some problem?
>>> >
>>> > The in_interrupt() is used to avoid killing tasklets from interrupt
>>> > context. I'm not that experienced with rtpatch, but I assume that
>>> > this would pose no problem and tasklets get cancelled right away.
>>> > But I'm not sure :-)
>>>
>>> i've tried to allways use the code with the queue or allways use the
>>> call to destroy, and i get the problem in both case, so i assume the
>>> "problem" is not coming from this.
>>> >
>
> Laurent
>>> >>
>>> >> Thanks in advance for your help
>>> >> Best regards
>>> >> Laurent
>>> >> --
>>> >> To unsubscribe from this list: send the line "unsubscribe linux-can" in
>>> >> the body of a message to majordomo@vger.kernel.org
>>> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-can" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
