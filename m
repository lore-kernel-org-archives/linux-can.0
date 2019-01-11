From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 11/20] can: flexcan: Always use last mailbox for TX
Date: Fri, 11 Jan 2019 11:56:19 +0100
Message-ID: <20190111105619.gkf2735zlpe6qbxv@pengutronix.de>
References: <20181112115728.18331-1-mkl@pengutronix.de>
 <20181112115728.18331-12-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181112115728.18331-12-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, linux-stable <stable@vger.kernel.org>, linux-can@vger.kernel.org, kernel@pengutronix.de, davem@davemloft.net, Alexander Stein <alexander.stein@systec-electronic.com>
List-Id: linux-can.vger.kernel.org

hello,

On Mon, Nov 12, 2018 at 12:57:19PM +0100, Marc Kleine-Budde wrote:
> From: Alexander Stein <alexander.stein@systec-electronic.com>
> 
> Essentially this patch moves the TX mailbox to position 63, regardless
> of timestamp based offloading or RX FIFO. So mainly the iflag register
> usage regarding TX has changed. The rest is consolidating RX FIFO and
> timestamp offloading as they now use both the same TX mailbox.
> 
> The reason is a very annoying behavior regarding sending RTR frames when
> _not_ using RX FIFO:
> 
> If a TX mailbox sent a RTR frame it becomes a RX mailbox. For that
> reason flexcan_irq disables the TX mailbox again. But if during the time
> the RTR was sent and the TX mailbox is disabled a new CAN frames is
> received, it is lost without notice. The reason is that so-called
> "Move-in" process starts from the lowest mailbox which happen to be a TX
> mailbox set to EMPTY.
> 
> Steps to reproduce (I used an imx7d):
> 1. generate regular bursts of messages
> 2. send a RTR from flexcan with higher priority than burst messages every
>    1ms, e.g. cangen -I 0x100 -L 0 -g 1 -R can0
> 3. notice a lost message without notification after some seconds
> 
> When running an iperf in parallel this problem is occurring even more
> frequently. Using filters is not possible as at least one single CAN-ID
> is allowed. Handling the TX MB during RX is also not possible as there
> is no race-free disable of RX MB.
> 
> There is still a slight window when the described problem can occur. But
> for that all RX MB must be in use which is essentially next to an
> overrun. Still there will be no indication if it ever occurs.
> 
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> Cc: linux-stable <stable@vger.kernel.org>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

The backport of this patch (24e5589791d09214e31335ae2b581c668d4803b7) in
4.19.x makes the driver trigger an abort on an i.MX25 based machine.

If I revert

	d5a9ba4324d5 ("can: flexcan: remove not needed struct flexcan_priv::tx_mb and struct flexcan_priv::tx_mb_idx")
	24e5589791d0 ("can: flexcan: Always use last mailbox for TX")

on top of v4.19.13 the oops is gone. (I have to add #define
FLEXCAN_TX_MB 63 to the driver though as the next older flexcan patch
(04f985776f04 ("can: flexcan: handle tx-complete CAN frames via
rx-offload infrastructure")) makes use of this symbol but it is only
defined as part of 24e5589791d0. In mainline the order of the commits is
different such that this problem doesn't occur.)

The output with no changes to flexcan on top of 4.19.13 looks as follows:

[   10.446142] Unhandled fault: external abort on non-linefetch (0x808) at 0xc89f4480
[   10.453774] pgd = (ptrval)
[   10.456510] [c89f4480] *pgd=87885811, *pte=43f88653, *ppte=43f88552
[   10.462856] Internal error: : 808 [#1] PREEMPT ARM
[   10.467678] Modules linked in:
[   10.470786] CPU: 0 PID: 685 Comm: ip Not tainted 4.19.13-20180926-1-00011-ga0dd04ff511f #4
[   10.479071] Hardware name: Freescale i.MX25 (Device Tree Support)
[   10.485232] PC is at flexcan_write_le+0x0/0x8
[   10.489632] LR is at flexcan_chip_start+0x450/0x474
[   10.494538] pc : [<c0436f18>]    lr : [<c0437680>]    psr: 20000013
[   10.500826] sp : c6ed1900  ip : 00000000  fp : c7a73000
[   10.506071] r10: c0789a30  r9 : c89f4004  r8 : c89f4490
[   10.511317] r7 : 00000000  r6 : c7a733e0  r5 : c89f4000  r4 : c89f4490
[   10.517866] r3 : c0436f10  r2 : c0436f18  r1 : c89f4480  r0 : 00000000
[   10.524416] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[   10.531574] Control: 0005317f  Table: 86f28000  DAC: 00000051
[   10.537345] Process ip (pid: 685, stack limit = 0x(ptrval))
[   10.542942] Stack: (0xc6ed1900 to 0xc6ed2000)
[   10.547342] 1900: 00000080 c7a73000 00000000 c70d0780 00000001 00040080 c06a4760 c6ca8010
[   10.555563] 1920: 00000000 c0438534 c7a73000 c7a73000 c7a73000 c084d028 c06a4760 c0504924
[   10.563782] 1940: c054cacc 0137be89 c6c88e50 c7a73000 00000000 0137be89 c7a73000 c084d028
[   10.572002] 1960: 00040081 c0504d0c 000000be 00000000 c06a485c c6ed19fc c7a73000 0137be89
[   10.580220] 1980: c084d028 c7a73000 00000000 c7a73138 00040080 c6ed1ca0 c06a4760 c0504d94
[   10.588442] 19a0: c7a73000 c6ed1bd0 c084d028 c7249260 c6ed1ca0 c051b1cc 000000a1 0000000b
[   10.596663] 19c0: 00000002 c6ed1d6c 00053de0 c7a73000 c6ed1b0c c6ed1b0c c084d028 c6ed19fc
[   10.604883] 19e0: c06a485c c7a733fc c7a73000 c04364a4 00000000 c6ca8040 00000001 0000c350
[   10.613100] 1a00: 00000359 00000594 00000005 0137be89 00000002 c7a73000 00000000 00000000
[   10.621322] 1a20: c6ca8000 c6ed1b0c c084d7f8 c6ed1d6c 00000000 c051c0cc c6ed1bd0 c6ed1ca0
[   10.629539] 1a40: 00000003 c004951c c08b1940 00000000 c7249260 c6ca8010 00000000 00000000
[   10.637758] 1a60: 00000000 c6ca802c c6ca8034 00000000 00000000 00000000 00000000 c0856980
[   10.645977] 1a80: 00000005 c0049e98 c78fa4f0 c0049e98 c06644c0 c0856980 c78fa4c0 00000000
[   10.654196] 1aa0: 00000000 c08c8968 c0854aa8 c0042e14 c78fa4c0 a0000093 c6ed1acc c0042ed4
[   10.662415] 1ac0: c084d028 a0000093 c6ed1afc c00341f8 fe7ed638 c004951c c79d4110 0137be89
[   10.670635] 1ae0: c7a6e75c c781bd00 c08c0554 00000000 00000000 c08c8968 c7a36860 c00341f8
[   10.678854] 1b00: c084d028 c08569b0 c79d4110 00000000 c6ca8040 00000000 00000000 00000000
[   10.687069] 1b20: 00000000 c6ca8038 00000000 00000000 00000000 00000000 00000000 00000000
[   10.695286] 1b40: 00000000 00000000 00000000 c6c98200 c6ed1b84 c025a9bc 00000000 00000000
[   10.703506] 1b60: c7a6e738 c025a9bc 00000000 c0335c90 c6e94900 c00341f8 c7a6e858 c7a6e8a0
[   10.711725] 1b80: c71bd380 0137be89 c7a86dfc c781bd00 c08c0554 00000000 00000000 c08c8968
[   10.719945] 1ba0: c7a36860 c00341f8 c6ed1cd0 00000000 c6ed1cd0 c067849c c6cf0900 20000013
[   10.728164] 1bc0: ffffffe1 c6ed1c2c c084d028 c7a86f40 00000000 00000000 00000000 00000000
[   10.736379] 1be0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[   10.744595] 1c00: 00000000 c6ca8020 00000000 00000000 00000000 00000000 c6ca8028 00000000
[   10.752810] 1c20: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[   10.761029] 1c40: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[   10.769244] 1c60: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[   10.777459] 1c80: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[   10.785677] 1ca0: c771f600 c08569b0 c79d4110 00000009 006e6163 00000000 00000000 00000000
[   10.793892] 1cc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[   10.802111] 1ce0: 00000000 00000000 00000000 0137be89 c08c8010 c78f4440 00000000 c6ca8000
[   10.810330] 1d00: c084d028 c6ed1d6c c7249260 c091bbc4 00000000 c0517800 c6ed1d64 00000000
[   10.818548] 1d20: 006200ca ffffe000 c771f6e4 c6ed1db4 c6ed1db4 c065d938 0000000f 0137be89
[   10.826768] 1d40: 00000000 c7249260 c05176e0 c084d028 c6ca8000 00000064 00000000 c084d028
[   10.834987] 1d60: 00000000 c053c710 00000000 00000000 00000000 00000000 00000000 00000000
[   10.843204] 1d80: 00000000 00000000 00000000 0137be89 c790cc00 c6db6000 00000064 c7249260
[   10.851422] 1da0: c6ed1da8 c053bed0 7fffffff 0137be89 c6ed1f5c c084d028 c6db6000 c7249260
[   10.859641] 1dc0: 006000c0 00000064 00000000 c053c348 0000000c c6ed1f64 c084d028 00000000
[   10.867861] 1de0: c6ed1e38 00000008 c6cf0e40 00000000 000002ad 00000000 00000000 0137be89
[   10.876079] 1e00: bef24778 c6ed1f5c 00000000 c084d028 00000000 c773ee00 00000000 c6ed1efc
[   10.884297] 1e20: 00000000 c04e14d4 c6ed1f5c c04e1a40 c6ed1e54 00041000 00000000 bef24798
[   10.892515] 1e40: 00000064 c012d73c 00000000 00000000 00000000 c6ed3de0 00000070 006200ca
[   10.900733] 1e60: 00000031 00041000 c6f28000 c6f28000 00000000 00000000 00000000 00000010
[   10.908950] 1e80: 00000000 00000000 00000000 0137be89 c6ed1fb0 c6ed1fb0 c79d40e0 c7810500
[   10.917168] 1ea0: 80000005 00041350 00000070 c00117f0 c6ed0000 00000000 bef23f44 c015733c
[   10.925386] 1ec0: c789a030 00000000 00000000 00000000 00000000 c01306f0 00000000 c08517b8
[   10.933608] 1ee0: 00000005 c084d028 c0011a74 00041350 c6ed1fb0 00066328 bef24f30 c0011c64
[   10.941831] 1f00: 017ce000 c6ed3eb0 c6ed3ea0 c0166f58 c7810500 00000000 00000021 0137be89
[   10.950050] 1f20: c6ed3eb0 c084d028 bef2472c 00000000 c773ee00 c00091e4 c6ed0000 00000000
[   10.958270] 1f40: 0008c000 c04e2a20 00000000 00000000 bef23f44 00000000 fffffff7 c6ed1e7c
[   10.966485] 1f60: 0000000c 00000001 00000000 00000000 c6ed1e44 00000000 c00091e4 00000000
[   10.974703] 1f80: 00000000 00000000 00000000 0137be89 c00091e4 00000000 bef24e48 00041350
[   10.982922] 1fa0: 00000128 c0009000 00000000 bef24e48 00000003 bef2472c 00000000 00000000
[   10.991140] 1fc0: 00000000 bef24e48 00041350 00000128 5c387178 00000000 00066328 0008c000
[   10.999356] 1fe0: b6f49000 bef246d8 00062aa0 b6ed9918 60000010 00000003 00000000 00000000
[   11.007630] [<c0436f18>] (flexcan_write_le) from [<c0437680>] (flexcan_chip_start+0x450/0x474)
[   11.016307] [<c0437680>] (flexcan_chip_start) from [<c0438534>] (flexcan_open+0xf8/0x144)
[   11.024545] [<c0438534>] (flexcan_open) from [<c0504924>] (__dev_open+0xe8/0x174)
[   11.032084] [<c0504924>] (__dev_open) from [<c0504d0c>] (__dev_change_flags+0x160/0x1c8)
[   11.040227] [<c0504d0c>] (__dev_change_flags) from [<c0504d94>] (dev_change_flags+0x20/0x50)
[   11.048723] [<c0504d94>] (dev_change_flags) from [<c051b1cc>] (do_setlink+0x360/0xa88)
[   11.056695] [<c051b1cc>] (do_setlink) from [<c051c0cc>] (rtnl_newlink+0x4a4/0x6f4)
[   11.064317] [<c051c0cc>] (rtnl_newlink) from [<c0517800>] (rtnetlink_rcv_msg+0x120/0x2f4)
[   11.072566] [<c0517800>] (rtnetlink_rcv_msg) from [<c053c710>] (netlink_rcv_skb+0xbc/0x118)
[   11.080981] [<c053c710>] (netlink_rcv_skb) from [<c053bed0>] (netlink_unicast+0x184/0x1fc)
[   11.089304] [<c053bed0>] (netlink_unicast) from [<c053c348>] (netlink_sendmsg+0x338/0x38c)
[   11.097639] [<c053c348>] (netlink_sendmsg) from [<c04e14d4>] (sock_sendmsg+0x1c/0x2c)
[   11.105532] [<c04e14d4>] (sock_sendmsg) from [<c04e1a40>] (___sys_sendmsg+0x210/0x22c)
[   11.113503] [<c04e1a40>] (___sys_sendmsg) from [<c04e2a20>] (__sys_sendmsg+0x54/0x94)
[   11.121383] [<c04e2a20>] (__sys_sendmsg) from [<c0009000>] (ret_fast_syscall+0x0/0x50)
[   11.129327] Exception stack(0xc6ed1fa8 to 0xc6ed1ff0)
[   11.134416] 1fa0:                   00000000 bef24e48 00000003 bef2472c 00000000 00000000
[   11.142634] 1fc0: 00000000 bef24e48 00041350 00000128 5c387178 00000000 00066328 0008c000
[   11.150842] 1fe0: b6f49000 bef246d8 00062aa0 b6ed9918
[   11.155941] Code: e5813000 e12fff1e e5900000 e12fff1e (e5810000) 
[   11.162068] ---[ end trace aaa0ccd32b1426b3 ]---

I have a fix for 4.19.14 that doesn't fit as is on current mainline. I
didn't check if mainline is still affected, but will do so later today.
I will send the fix for 4.19.x as a reply to this mail.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
