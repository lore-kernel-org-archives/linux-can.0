From: Torsten Lang <torsten.lang@uweschneider.de>
Subject: Re: can: flexcan: implement workaround for FIFO overruns (based on
 code by David Jander)
Date: Fri, 24 Jul 2015 10:45:29 +0200
Message-ID: <55B1FB29.6050904@uweschneider.de>
References: <559D35CA.2050402@uweschneider.de> <2576741.YrBIndJIHB@ws-stein> <CAOpc7mEc+kr=Es34772fcTnsQpJsaCaoVOx67AhfRjxucPhAhw@mail.gmail.com> <3634451.aFQ5B85Yzk@ws-stein> <CAOpc7mG52ni5ESuijv1qVLpMznZXSxxU8gmkhjGqtKZfXuxUNQ@mail.gmail.com> <55AF4D9D.8040904@uweschneider.de> <55AF5AF2.6050905@pengutronix.de> <55B1B6A9.1000702@optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from groat.dascon.de ([195.225.198.185]:55735 "EHLO groat.dascon.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753142AbbGXIqI (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 24 Jul 2015 04:46:08 -0400
In-Reply-To: <55B1B6A9.1000702@optusnet.com.au>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: tom_usenet@optusnet.com.au, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Holger Schurig <holgerschurig@gmail.com>, Alexander Stein <alexander.stein@systec-electronic.com>, linux-can@vger.kernel.org

Am 24.07.2015 um 05:53 schrieb Tom Evans:
> On 22/07/15 18:57, Marc Kleine-Budde wrote:
>> On 07/22/2015 10:00 AM, Torsten Lang wrote:
>>> Am 09.07.2015 um 09:59 schrieb Holger Schurig:
>>>>> Is it "normal" to have interrupts locked out for more than 300us
> >>>> (six 50us CAN messages at 1MHz)?
>>>> Unfortunately yes.  My $CUSTOMER had overruns with 500 kB/s, 80% bus
>>>> load, and CAN messages with 3 bytes of data. My guess this was mostly
>>>> due to the sucky SDHCI (eMMC) driver code in Linux.
>
> There's been some off-list email on this. It looks like the MMC driver isn't well written.
>
> I think I've found the "Official Freescale" workaround for the CAN problems under Linux:
>
> http://cache.freescale.com/files/32bit/doc/app_note/AN4815.pdf
>
> The above App Note documents migration to the i.MX 6SoloX chip. It contains one each of Cortex-A9 and Cortex-M4 CPU cores.
>
> The purpose of the M4 core is listed to be:
>
>               Secondary processor for fast boot, low power
>               processing, and robust CAN message handling.
>
> So that's your only fix. Use a totally separate CPU for CAN.
>
> Or don't design hardware that uses chips that the software doesn't support (well enough to work with your other hardware). So don't design with eMMC on this platform. Use something simpler and faster, like NAND or NOR Flash.
>
> On a slightly better note, who's responsible for the MMC driver?
>
> Which one are you using? This one (from Freescale 2.6.35):
>
No, the i.MX6 boards use sdhci-esdhc-imx.c which introduces these insane mdelay(1)s when clock switching. To reduce the irqsoff latencies I ported a SDHC low latency patch originally made for the Raspberry Pi kernel which also seems to be used in the OpenWRT project - see https://gist.github.com/ddv2005/3454406 or https://dev.openwrt.org/browser/trunk/target/linux/brcm2708/patches-3.10/0026-Add-low-latency-mode-to-sdcard-driver.-Disable-with-.patch?rev=39770. This reduces the latencies severely (which actually isn't surprising when looking into sdhci.c and sdhci-esdhc-imx.c). But doing the tuning without hard lock possibly can lead to problems with certain cards as I found in other places, so this low latency change could possibly do harm.

I further developed a patch for the GIC driver to allow setting interrupt priorities of the global interrupts (IDs >=32) via the device tree. My device tree then looks like this:
        intc: interrupt-controller@00a01000 {
                compatible = "arm,cortex-a9-gic";
                #interrupt-cells = <3>;
                interrupt-controller;
                reg = <0x00a01000 0x1000>,
                      <0x00a00100 0x100>;
                interrupt-priorities = /bits/ 16 <    0xb0>, // default priority
                                       /bits/ 16 <110 0x90>, // FLEXCAN1
                                       /bits/ 16 <111 0x90>; // FLEXCAN2
        };
Having the priorities at a central place allows a change with minumum impact on the rest of the system - the patch is local to the irqchip driver, no additional interfaces needed, no changes to the (more or less generic) drivers needed.

With both changes and Tom's driver I already was able to receive without any losses under full CPU load (ssvb_cpuburn running, my application running), but as soon as I access any mass storage (USB, SDHC) I again crack the barrier of the 300us delay and observe occasional losses.

This is why I switched back to my own software queue driver. I did rewrite it to also unload mailboxes in interrupt like Tom's driver does which needs a more complex queue implementation where I split lists into a in, out and a staging area. So the in (irq) and out (polling) path can work completely lockless and I only need locks when moving lists to or from the staging area.

With this combination of patches I was able to transfer data (scp over an isotp tunnel with blocksize 0 resulting in long sequences of back-to-back messages) under full 100% CPU load with parallel mass storage transfer (multiple transfers on SD and USB devices).
> /*
>  *  linux/drivers/mmc/host/mxc_mmc.c - Freescale MXC/i.MX MMC driver
>  *
>  *  based on imxmmc.c
>  *  Copyright (C) 2004 Sascha Hauer, Pengutronix <sascha@saschahauer.de>
>  *
>  *  derived from pxamci.c by Russell King
>
> This one from the Mainline:
>
> http://lxr.free-electrons.com/source/drivers/mmc/host/mxcmmc.c
>
>   9  *  Copyright (C) 2008 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
>  10  *  Copyright (C) 2006 Pavel Pisa, PiKRON <ppisa@pikron.com>
>  11  *
>  12  *  derived from pxamci.c by Russell King
>
> Is there a mailing list where these apparent MMC driver problems can be reported? Probably "gmane.linux.kernel.mmc".
>
> It might be worth posting some FTRACE results to there.
>
Just in case anyone is interested (I just shortened the lengthy __timer_delay output):

# tracer: irqsoff
#
# irqsoff latency trace v1.1.5 on 3.16.0
# --------------------------------------------------------------------
# latency: 2119 us, #858/858, CPU#0 | (M:preempt VP:0, KP:0, SP:0 HP:0 #P:2)
#    -----------------
#    | task: kworker/u4:2-93 (uid:0 nice:0 policy:0 rt_prio:0)
#    -----------------
#  => started at: _raw_spin_lock_irqsave
#  => ended at:   _raw_spin_unlock_irqrestore
#
#
#                  _------=> CPU#           
#                 / _-----=> irqs-off       
#                | / _----=> need-resched   
#                || / _---=> hardirq/softirq
#                ||| / _--=> preempt-depth  
#                |||| /     delay            
#  cmd     pid   ||||| time  |   caller     
#     \   /      |||||  \    |   /          
kworker/-93      0d...    1us+: _raw_spin_lock_irqsave
kworker/-93      0d..1    4us+: preempt_count_add <-_raw_spin_lock_irqsave
kworker/-93      0d..2    8us+: esdhc_readl_le <-esdhc_pltfm_set_clock
kworker/-93      0d..2   11us+: esdhc_writel_le <-esdhc_pltfm_set_clock
kworker/-93      0d..2   13us+: l2c210_sync <-esdhc_writel_le
kworker/-93      0d..2   18us+: esdhc_readl_le <-esdhc_pltfm_set_clock
kworker/-93      0d..2   21us+: esdhc_writel_le <-esdhc_pltfm_set_clock
kworker/-93      0d..2   26us+: l2c210_sync <-esdhc_writel_le
kworker/-93      0d..2   29us+: l2c210_sync <-esdhc_pltfm_set_clock
kworker/-93      0d..2   33us+: __timer_const_udelay <-esdhc_pltfm_set_clock
kworker/-93      0d..2   36us+: __timer_delay <-__timer_const_udelay
kworker/-93      0d..2   38us+: imx_read_current_timer <-__timer_delay
kworker/-93      0d..2   41us+: imx_read_current_timer <-__timer_delay
...
kworker/-93      0d..2 1038us+: imx_read_current_timer <-__timer_delay
kworker/-93      0d..2 1040us+: imx_read_current_timer <-__timer_delay
kworker/-93      0d..2 1044us+: esdhc_writeb_le <-sdhci_do_set_ios
kworker/-93      0d..2 1046us+: esdhc_writeb_le <-sdhci_do_set_ios
kworker/-93      0d..2 1049us+: esdhc_pltfm_set_bus_width <-sdhci_do_set_ios
kworker/-93      0d..2 1051us+: l2c210_sync <-esdhc_pltfm_set_bus_width
kworker/-93      0d..2 1054us+: esdhc_writeb_le <-sdhci_do_set_ios
kworker/-93      0d..2 1057us+: l2c210_sync <-esdhc_writeb_le
kworker/-93      0d..2 1061us+: esdhc_readw_le <-sdhci_do_set_ios
kworker/-93      0d..2 1064us+: esdhc_writew_le <-sdhci_do_set_ios
kworker/-93      0d..2 1067us+: l2c210_sync <-esdhc_writew_le
kworker/-93      0d..2 1070us+: l2c210_sync <-esdhc_writew_le
kworker/-93      0d..2 1072us+: esdhc_readw_le <-sdhci_do_set_ios
kworker/-93      0d..2 1075us+: esdhc_writew_le <-sdhci_do_set_ios
kworker/-93      0d..2 1077us+: l2c210_sync <-esdhc_writew_le
kworker/-93      0d..2 1080us+: esdhc_set_uhs_signaling <-sdhci_do_set_ios
kworker/-93      0d..2 1082us+: l2c210_sync <-esdhc_set_uhs_signaling
kworker/-93      0d..2 1085us+: pinctrl_select_state <-esdhc_set_uhs_signaling
kworker/-93      0d..2 1088us+: esdhc_readl_le <-esdhc_pltfm_set_clock
kworker/-93      0d..2 1090us+: esdhc_writel_le <-esdhc_pltfm_set_clock
kworker/-93      0d..2 1093us+: l2c210_sync <-esdhc_writel_le
kworker/-93      0d..2 1095us+: esdhc_readl_le <-esdhc_pltfm_set_clock
kworker/-93      0d..2 1098us+: esdhc_writel_le <-esdhc_pltfm_set_clock
kworker/-93      0d..2 1100us+: l2c210_sync <-esdhc_writel_le
kworker/-93      0d..2 1103us+: l2c210_sync <-esdhc_pltfm_set_clock
kworker/-93      0d..2 1105us+: __timer_const_udelay <-esdhc_pltfm_set_clock
kworker/-93      0d..2 1108us+: __timer_delay <-__timer_const_udelay
kworker/-93      0d..2 1110us+: imx_read_current_timer <-__timer_delay
kworker/-93      0d..2 1112us+: imx_read_current_timer <-__timer_delay
...
kworker/-93      0d..2 2108us+: imx_read_current_timer <-__timer_delay
kworker/-93      0d..2 2111us+: imx_read_current_timer <-__timer_delay
kworker/-93      0d..2 2113us+: _raw_spin_unlock_irqrestore <-sdhci_do_set_ios
kworker/-93      0d..1 2117us+: _raw_spin_unlock_irqrestore
kworker/-93      0d..1 2122us!: trace_hardirqs_on <-_raw_spin_unlock_irqrestore
kworker/-93      0d..1 2242us : <stack trace>
 => sdhci_do_set_ios
 => sdhci_runtime_resume_host
 => sdhci_esdhc_runtime_resume
 => pm_generic_runtime_resume
 => __rpm_callback
 => rpm_callback
 => rpm_resume
 => __pm_runtime_resume
 => sdhci_runtime_pm_get.clone.18
 => sdhci_request
 => mmc_start_request
 => mmc_wait_for_req
 => mmc_wait_for_cmd
 => mmc_send_status
 => mmc_alive
 => _mmc_detect_card_removed
 => mmc_detect
 => mmc_rescan
 => process_one_work
 => worker_thread
 => kthread
 => ret_from_fork

>> IIRC you can insert a SD/MMC/eMMC and mark it as non removable
> > in the DT to work around the problem - connecting the Card
> > Detection pin might also work.
>
> Has anyone tested that to see if it helps or helps enough?
>
> Tom
>

