From: Stefan Agner <stefan@agner.ch>
Subject: Re: Flexcan error on suspend
Date: Fri, 15 May 2015 15:00:15 +0200
Message-ID: <a8518e25187e6933b2be68698a76e93c@agner.ch>
References: <CAJ=nTsu_879bhwzsVe1xCYUHfZmjPqFyGRsRDJs+ujnb9=Chtg@mail.gmail.com>
 <5555E727.1050506@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.kmu-office.ch ([178.209.48.109]:41193 "EHLO
	mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934213AbbEONBy (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 15 May 2015 09:01:54 -0400
In-Reply-To: <5555E727.1050506@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Mirza Krak <mirza.krak@hostmobility.com>, linux-can@vger.kernel.org

On 2015-05-15 14:31, Marc Kleine-Budde wrote:
> On 05/15/2015 02:15 PM, Mirza Krak wrote:
>> Hi.
>>
>> I am running a 4.0.2 kernel on a Colibri VF61 SOM.
>>
>> I wanted to test the "suspend to RAM" functionality when I got
>> following error during suspend:
>>
>> root@mx4-v61-1000000:~# echo standby > /sys/power/state
>> [   40.390281] PM: Syncing filesystems ... done.
>> [   40.407716] Freezing user space processes ... (elapsed 0.001 seconds) done.
>> [   40.416040] Freezing remaining freezable tasks ... (elapsed 0.001
>> seconds) done.
>> [   40.429099] mx4_io_spi spi1.0: Entering suspend state.
>> [   40.434692] mx4_io_spi spi1.0: Suspend succeeded after 0 retries
>> [   40.441408] Unhandled fault: external abort on non-linefetch
>> (0x1008) at 0x909a0000
>> [   40.449100] pgd = 8e200000
>> [   40.451825] [909a0000] *pgd=8e805811, *pte=400d4653, *ppte=400d4453
>> [   40.458173] Internal error: : 1008 [#1] ARM
>> [   40.462373] Modules linked in: mx4_pic(O)
>> [   40.466445] CPU: 0 PID: 278 Comm: sh Tainted: G           O
>> 4.0.2-01554-g73efc16 #30
>> [   40.474473] Hardware name: Freescale Vybrid VF5xx/VF6xx (Device Tree)
>> [   40.480945] task: 8d832640 ti: 8e076000 task.ti: 8e076000
>> [   40.486383] PC is at flexcan_chip_disable+0x10/0xa8
>> [   40.491288] LR is at flexcan_suspend+0x18/0x88
>> [   40.495757] pc : [<802f4648>]    lr : [<802f4750>]    psr: a00f0013
>> [   40.495757] sp : 8e077d60  ip : 8e077d80  fp : 8e077d7c
>> [   40.507279] r10: 8061d86c  r9 : 00000000  r8 : 8e8b6a44
>> [   40.512530] r7 : 00000002  r6 : 8065dfe4  r5 : 8029c0dc  r4 : 909a0000
>> [   40.519086] r3 : 802f4738  r2 : 80498c04  r1 : 8e8b6a10  r0 : 8e943ca0
>> [   40.525641] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
>> [   40.532800] Control: 10c5387d  Table: 8e200059  DAC: 00000015
>> [   40.538567] Process sh (pid: 278, stack limit = 0x8e076208)
>> [   40.544164] Stack: (0x8e077d60 to 0x8e078000)
>> [   40.548556] 7d60: 802f4738 8e943800 8029c0dc 8065dfe4 8e077d94
>> 8e077d80 802f4750 802f4644
>> [   40.556774] 7d80: 8e8b6a10 8029c0dc 8e077da4 8e077d98 8029c110
>> 802f4744 8e077dc4 8e077da8
>> [   40.565025] 7da0: 802a3ae0 8029c0e8 8046c3b0 8046af84 8e8b6a10
>> 00000000 8e077dfc 8e077dc8
>> [   40.573294] 7dc0: 802a450c 802a3ac8 69e37ae7 00000009 8046afbc
>> 0046af04 8e8b6a68 8e8b6a10
>> [   40.581564] 7de0: 8062907c 8065dfe4 806290a8 8061d86c 8e077e44
>> 8e077e00 802a5718 802a43f4
>> [   40.589834] 7e00: 68f6c591 00000009 802a5ac8 00000002 68f6c591
>> 00000009 00000000 00000002
>> [   40.598096] 7e20: 80640f30 00000002 00000007 8e24ad00 00000000
>> 00000008 8e077e5c 8e077e48
>> [   40.606358] 7e40: 802a5b90 802a56c8 00000000 80640f30 8e077ea4
>> 8e077e60 800449f4 802a5b3c
>> [   40.614628] 7e60: 80467b04 80047eec 00000002 8e077e84 8e077ea4
>> 8e077e90 80044734 00000000
>> [   40.622890] 7e80: 00000002 80640f3c 00000007 8e24ad00 00000000
>> 00000008 8e077ebc 8e077ea8
>> [   40.631152] 7ea0: 80044e88 80044974 00000002 80569a2c 8e077ee4
>> 8e077ec0 80043adc 80044d24
>> [   40.639423] 7ec0: 8e834b90 8e24ad00 00000008 8e077f78 00000000
>> 8e24a040 8e077ef4 8e077ee8
>> [   40.647693] 7ee0: 8023a520 80043a74 8e077f0c 8e077ef8 80113d9c
>> 8023a510 8e24ad00 8e24a04c
>> [   40.655963] 7f00: 8e077f44 8e077f10 801133f4 80113d5c 00000000
>> 00000000 00000000 8e0ef9c0
>> [   40.664234] 7f20: 00000008 00e41408 8e077f78 00000008 8e076000
>> 00e41408 8e077f74 8e077f48
>> [   40.672505] 7f40: 800b807c 80113340 800d0174 800d00f4 00000000
>> 00000000 8e0ef9c0 8e0ef9c0
>> [   40.680775] 7f60: 00000008 00e41408 8e077fa4 8e077f78 800b83b4
>> 800b7fe0 00000000 00000000
>> [   40.689045] 7f80: 00000008 00e41408 76ef0a78 00000004 8000ea44
>> 00000000 00000000 8e077fa8
>> [   40.697316] 7fa0: 8000e8a0 800b837c 00000008 00e41408 00000001
>> 00e41408 00000008 00000000
>> [   40.705586] 7fc0: 00000008 00e41408 76ef0a78 00000004 00000008
>> 00000008 00e41408 00000000
>> [   40.713848] 7fe0: 00000000 7ef52984 76e2e9a0 76e80a5c 600f0010
>> 00000001 02131c06 1b18018f
>> [   40.722103] Backtrace:
>> [   40.724612] [<802f4638>] (flexcan_chip_disable) from [<802f4750>]
>> (flexcan_suspend+0x18/0x88)
>> [   40.733216]  r6:8065dfe4 r5:8029c0dc r4:8e943800 r3:802f4738
>> [   40.739002] [<802f4738>] (flexcan_suspend) from [<8029c110>]
>> (platform_pm_suspend+0x34/0x5c)
>> [   40.747517]  r5:8029c0dc r4:8e8b6a10
>> [   40.751192] [<8029c0dc>] (platform_pm_suspend) from [<802a3ae0>]
>> (dpm_run_callback.isra.10+0x24/0x50)
>> [   40.760513] [<802a3abc>] (dpm_run_callback.isra.10) from
>> [<802a450c>] (__device_suspend+0x124/0x2c4)
>> [   40.769726]  r5:00000000 r4:8e8b6a10
>> [   40.773392] [<802a43e8>] (__device_suspend) from [<802a5718>]
>> (dpm_suspend+0x5c/0x218)
>> [   40.781387]  r10:8061d86c r8:806290a8 r7:8065dfe4 r6:8062907c
>> r5:8e8b6a10 r4:8e8b6a68
>> [   40.789387] [<802a56bc>] (dpm_suspend) from [<802a5b90>]
>> (dpm_suspend_start+0x60/0x68)
>> [   40.797381]  r10:00000008 r9:00000000 r8:8e24ad00 r7:00000007
>> r6:00000002 r5:80640f30
>> [   40.805363]  r4:00000002
>> [   40.807958] [<802a5b30>] (dpm_suspend_start) from [<800449f4>]
>> (suspend_devices_and_enter+0x8c/0x3b0)
>> [   40.817258]  r5:80640f30 r4:00000000
>> [   40.820918] [<80044968>] (suspend_devices_and_enter) from
>> [<80044e88>] (pm_suspend+0x170/0x210)
>> [   40.829692]  r10:00000008 r9:00000000 r8:8e24ad00 r7:00000007
>> r6:80640f3c r5:00000002
>> [   40.837672]  r4:00000000
>> [   40.840272] [<80044d18>] (pm_suspend) from [<80043adc>]
>> (state_store+0x74/0xc4)
>> [   40.847653]  r5:80569a2c r4:00000002
>> [   40.851321] [<80043a68>] (state_store) from [<8023a520>]
>> (kobj_attr_store+0x1c/0x28)
>> [   40.859136]  r10:8e24a040 r8:00000000 r7:8e077f78 r6:00000008
>> r5:8e24ad00 r4:8e834b90
>> [   40.867146] [<8023a504>] (kobj_attr_store) from [<80113d9c>]
>> (sysfs_kf_write+0x4c/0x50)
>> [   40.875245] [<80113d50>] (sysfs_kf_write) from [<801133f4>]
>> (kernfs_fop_write+0xc0/0x19c)
>> [   40.883497]  r5:8e24a04c r4:8e24ad00
>> [   40.887166] [<80113334>] (kernfs_fop_write) from [<800b807c>]
>> (vfs_write+0xa8/0x1b0)
>> [   40.894986]  r10:00e41408 r9:8e076000 r8:00000008 r7:8e077f78
>> r6:00e41408 r5:00000008
>> [   40.902969]  r4:8e0ef9c0
>> [   40.905558] [<800b7fd4>] (vfs_write) from [<800b83b4>] (SyS_write+0x44/0x90)
>> [   40.912654]  r10:00e41408 r8:00000008 r7:8e0ef9c0 r6:8e0ef9c0
>> r5:00000000 r4:00000000
>> [   40.920652] [<800b8370>] (SyS_write) from [<8000e8a0>]
>> (ret_fast_syscall+0x0/0x34)
>> [   40.928293]  r10:00000000 r8:8000ea44 r7:00000004 r6:76ef0a78
>> r5:00e41408 r4:00000008
>> [   40.936280] Code: e1a0c00d e92dd878 e24cb004 e5904120 (e5945000)
>> [   40.942427] ---[ end trace a4e15b05423e6882 ]---
>>
>> I suspected that the clocks are disabled when flexcan_suspend is
>> called. When I explicitly enabled the clocks in flexcan_suspend it
>> worked fine.
>>
>> Before sending a patch I wanted to check for your thoughts?
> 
> Sounds reasonable. I think we have to convert the flexcan driver to
> proper runtime_pm.

Hm, but we don't have runtime PM, so the question is why are they
actually disabled at that time? I guess its because the device has not
been opened or has already been closed at that point, in any case,
afaik, flexcan_chip_disable should not be required. Not sure how to
detect whether the chip is opened or not, but maybe just move the
flexcan_chip_disable within the netif_running if block?

--
Stefan

