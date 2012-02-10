From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: can/sja1000: potential issue in sja1000.c?
Date: Fri, 10 Feb 2012 12:00:12 +0100
Message-ID: <4F34F8BC.3030903@peak-system.com>
References: <1328281974-11761-1-git-send-email-s.grosjean@peak-system.com>
 <4F2FF9EE.1060301@volkswagen.de>
Reply-To: Stephane Grosjean <s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:50602 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759078Ab2BJLA2 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 10 Feb 2012 06:00:28 -0500
In-Reply-To: <4F2FF9EE.1060301@volkswagen.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can Mailing List <linux-can@vger.kernel.org>

Hi all,

While always fighting against pcmcia Oliver (very hot) unplug issue, I=20
decided to have a look to the sja1000 lib, since the pcmcia driver ISR=20
does call "sja1000_interrupt()",

Unfortunately, I found that:

                 if (isrc & IRQ_RI) {
                         /* receive interrupt */
                         while (status & SR_RBS) {
                                 sja1000_rx(dev);
                                 status =3D priv->read_reg(priv, REG_SR=
);
                         }
                 }

My problem is, once the card is unplugged, every ioread in its=20
corresponding io space does return 0xff...
I just change this potential infinite while() into a corresponding=20
for(;;) loop to test, like this:

-                        while (status & SR_RBS) {
+                        int i;
+                        for (i =3D 0; (status & SR_RBS) && (i < 10); i=
++) {

And no more PC hang!

Can you confirm this, please?

@Oliver: IMHO, the 0xff (invalid) value is also the reason of the=20
"wakeup interrupt" message you got when unplugging the cards from their=
=20
slots...

Regards,

St=E9phane.


Le 06/02/2012 17:03, Oliver Hartkopp a =E9crit :
> On 03.02.2012 16:12, Stephane Grosjean wrote:
>> This patch adds the support of the PCAN-PC Card (PCMCIA) card from
>> PEAK-System Technik (http://www.peak-system.com). The PCAN-PC Card i=
s
>> sja1000 based and exists in 1 or 2 channels.
> Hello Stephane,
>
> it's great fun having all the PEAK devices running as native SocketCA=
N drivers :-)
>
> Btw. here are some "unfriendly user" tests that killed my machine:
>
> The setup:
>
> can0: PCIeC  (peak_pci)
> can1: PCIeC  (peak_pci)
> can2: PCCard (peak_pcmcia)
> can3: PCCard (peak_pcmcia)
> can4: USBpro (peak_usb)
> can5: USBpro (peak_usb)
> can6: USB    (peak_usb)
>
> I connected can0, can2, can4, can6 together and attached the MicroMod=
 module generating full CAN load at 1MBit/s
>
>
>
> [    9.129202] yenta_cardbus 0000:03:01.0: ISA IRQ mask 0x0cb8, PCI i=
rq 19
> [    9.131405] yenta_cardbus 0000:03:01.0: Socket status: 30000410
> [    9.133618] pci_bus 0000:03: Raising subordinate bus# of parent bu=
s (#03) from #04 to #07
> [    9.135978] yenta_cardbus 0000:03:01.0: pcmcia: parent PCI bridge =
window: [io  0x2000-0x2fff]
> [    9.138252] yenta_cardbus 0000:03:01.0: pcmcia: parent PCI bridge =
window: [mem 0xfe400000-0xfe4fffff]
> [    9.140490] pcmcia_socket pcmcia_socket0: cs: memory probe 0xfe400=
000-0xfe4fffff: excluding 0xfe4f0000-0xfe4fffff
> [    9.142864] yenta_cardbus 0000:03:01.0: pcmcia: parent PCI bridge =
window: [mem 0x80000000-0x83ffffff pref]
> [    9.145222] pcmcia_socket pcmcia_socket0: cs: memory probe 0x80000=
000-0x83ffffff: excluding 0x80000000-0x83ffffff
> [    9.176580] ssb: Sonics Silicon Backplane found on PCI device 0000=
:0c:00.0
> [    9.271156] CAN device driver interface
> [    9.525675] sja1000 CAN netdevice driver
> [    9.598732] cfg80211: Calling CRDA to update world regulatory doma=
in
> [   10.052047] pcmcia_socket pcmcia_socket0: pccard: PCMCIA card inse=
rted into slot 0
> [   10.052370] peak_pci 0000:0e:00.0: can0 at reg_base=3D0xf807e000 c=
fg_base=3D0xf8076000 irq=3D19
> [   10.053826] peak_pci 0000:0e:00.0: can1 at reg_base=3D0xf807e400 c=
fg_base=3D0xf8076000 irq=3D19
> [   10.059685] pcmcia_socket pcmcia_socket0: cs: memory probe 0xfe400=
000-0xfe4effff: clean.
> [   10.089832] pcmcia 0.0: pcmcia: registering new device pcmcia0.0 (=
IRQ: 19)
>
> [   10.249259] peak_pcmcia 0.0: new PEAK-System pcmcia card detected:=
 PEAK PC_CAN_CARD:
> [   10.291693] peak_pcmcia 0.0: firmware 1.5
> /// Can you merge these two info lines?
>
> [   10.297613] peak_pcmcia 0.0: registered can2 on channel 0 at 0x000=
12100 irq 19
> [   10.301228] peak_pcmcia 0.0: registered can3 on channel 1 at 0x000=
12120 irq 19
> [   10.306745] peak_usb: PCAN-USB interfaces driver v4.2.0 loaded
> [   10.310745] peak_usb 2-2:1.0: PEAK-System PCAN-USB Pro hwrev 0 ser=
ial FFFFFFFF.00000001 (2 channels)
> [   10.313864] peak_usb 2-2:1.0: fw v1.3.3 (18/06/10) fw 0x00000100
> [   10.316314] Bluetooth: Core ver 2.16
> [   10.316533] peak_usb 2-2:1.0: bootloader v1.8.3 (26/05/09)
> [   10.321663] NET: Registered protocol family 31
> [   10.322468] peak_usb 2-2:1.0: PCAN-USB Pro channel 0 (device 1) at=
tached to can4
> [   10.326496] Bluetooth: HCI device and connection manager initializ=
ed
> [   10.329171] Bluetooth: HCI socket layer initialized
> [   10.329836] peak_usb 2-2:1.0: PCAN-USB Pro channel 1 (device 0) at=
tached to can5
> [   10.334387] peak_usb 5-1:1.0: PEAK-System PCAN-USB adapter hwrev 2=
8 serial FFFFFFFF (1 channel)
> [   10.336433] Bluetooth: L2CAP socket layer initialized
> [   10.336456] Bluetooth: SCO socket layer initialized
> [   10.345404] peak_usb 5-1:1.0: PCAN-USB channel 0 (device 255) atta=
ched to can6
> [   10.348437] usbcore: registered new interface driver peak_usb
> [   11.049242] pcmcia_socket pcmcia_socket0: cs: memory probe 0x0c000=
0-0x0fffff: excluding 0xc0000-0xcffff 0xe0000-0xfffff
> [   11.051943] pcmcia_socket pcmcia_socket0: cs: memory probe 0xa0000=
000-0xa0ffffff: clean.
> [   11.054610] pcmcia_socket pcmcia_socket0: cs: memory probe 0x60000=
000-0x60ffffff: excluding 0x60000000-0x60ffffff
> (..)
> [   30.176103] vcan: Virtual CAN interface driver
> [   30.682069] peak_pci 0000:0e:00.0: setting BTR0=3D0x00 BTR1=3D0x14
> [   30.691276] peak_pci 0000:0e:00.0: setting BTR0=3D0x00 BTR1=3D0x14
> [   30.700170] peak_pcmcia 0.0: setting BTR0=3D0x00 BTR1=3D0x14
> [   30.710697] peak_pcmcia 0.0: setting BTR0=3D0x00 BTR1=3D0x14
> [   30.724664] peak_usb 2-2:1.0: can4: setting ccbt=3D0x00140006
> [   30.738981] peak_usb 2-2:1.0: can5: setting ccbt=3D0x00140006
> [   30.754176] peak_usb 5-1:1.0: can6: setting BTR0=3D0x00 BTR1=3D0x1=
4
> /// all seven interfaces are configured with 1MBit/s bitrate and brou=
ght up now.
> /// from this point the CAN traffic from the MicroMod is hitting the =
interfaces
>
> [   31.514983] Bluetooth: RFCOMM TTY layer initialized
> [   31.517900] Bluetooth: RFCOMM socket layer initialized
> [   31.520576] Bluetooth: RFCOMM ver 1.11
>
> /// now i get a lockdep warning from the PCIeC
> [   31.684443]
> [   31.686450] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   31.688012] [ INFO: inconsistent lock state ]
> [   31.688012] 3.3.0-rc2-00116-g71b1b20-dirty #134 Not tainted
> [   31.688012] ---------------------------------
> [   31.688012] inconsistent {SOFTIRQ-ON-W} ->  {IN-SOFTIRQ-W} usage.
> [   31.696097] swapper/1/0 [HC0[0]:SC1[1]:HE1:SE0] takes:
> [   31.696097]  (&lock->wait_lock){+.?...}, at: [<c14a48fc>] rt_mutex=
_trylock+0xc/0x60
> [   31.696097] {SOFTIRQ-ON-W} state was registered at:
> [   31.696097]   [<c10740ee>] mark_irqflags+0x12e/0x170
> [   31.696097]   [<c107568a>] __lock_acquire+0x2da/0x460
> [   31.696097]   [<c107588b>] lock_acquire+0x7b/0xa0
> [   31.696097]   [<c14a4b6d>] _raw_spin_lock+0x3d/0x50
> [   31.696097]   [<c14a4777>] rt_mutex_slowlock+0x27/0x160
> [   31.696097]   [<c14a48c9>] rt_mutex_lock+0x19/0x20
> [   31.696097]   [<c136cb6b>] i2c_lock_adapter+0x1b/0x40
> [   31.696097]   [<c136cbcd>] i2c_transfer+0x3d/0xb0
> [   31.696097]   [<c1271ad8>] drm_do_probe_ddc_edid+0x58/0x80
> [   31.696097]   [<c1271ee3>] drm_get_edid+0x23/0x50
> [   31.696097]   [<c129bd2c>] intel_lvds_init+0x24c/0x6b0
> [   31.696097]   [<c12938a9>] intel_setup_outputs+0x39/0x630
> [   31.696097]   [<c129a1b4>] intel_modeset_init+0x214/0x330
> [   31.696097]   [<c1275e32>] i915_load_modeset_init+0x72/0x130
> [   31.696097]   [<c1276607>] i915_driver_load+0x577/0x7b0
> [   31.696097]   [<c1267d1c>] drm_get_pci_dev+0x13c/0x260
> [   31.696097]   [<c14935aa>] i915_pci_probe+0x18/0x1e
> [   31.696097]   [<c11d63be>] local_pci_probe+0xe/0x10
> [   31.696097]   [<c11d7190>] pci_device_probe+0x60/0x80
> [   31.696097]   [<c12b5e5f>] really_probe+0x4f/0x160
> [   31.696097]   [<c12b5f89>] driver_probe_device+0x19/0x20
> [   31.696097]   [<c12b6011>] __driver_attach+0x81/0x90
> [   31.696097]   [<c12b4a28>] bus_for_each_dev+0x48/0x70
> [   31.696097]   [<c12b5d09>] driver_attach+0x19/0x20
> [   31.696097]   [<c12b593c>] bus_add_driver+0xbc/0x250
> [   31.696097]   [<c12b65b5>] driver_register+0x65/0x120
> [   31.696097]   [<c11d73d4>] __pci_register_driver+0x54/0xc0
> [   31.696097]   [<c1267f32>] drm_pci_init+0xf2/0x100
> [   31.696097]   [<c16bbfec>] i915_init+0x85/0x87
> [   31.696097]   [<c100111f>] do_one_initcall+0x2f/0x170
> [   31.696097]   [<c169d1f9>] kernel_init+0x87/0x11b
> [   31.696097]   [<c14a633a>] kernel_thread_helper+0x6/0xd
> [   31.696097] irq event stamp: 533098
> [   31.696097] hardirqs last  enabled at (533098): [<c14a56c0>] resto=
re_all_notrace+0x0/0x18
> [   31.696097] hardirqs last disabled at (533097): [<c14a6327>] commo=
n_interrupt+0x27/0x34
> [   31.696097] softirqs last  enabled at (533090): [<c103197d>] _loca=
l_bh_enable+0xd/0x10
> [   31.696097] softirqs last disabled at (533091): [<c1004a3f>] do_so=
ftirq+0x7f/0xc0
> [   31.696097]
> [   31.696097] other info that might help us debug this:
> [   31.696097]  Possible unsafe locking scenario:
> [   31.696097]
> [   31.696097]        CPU0
> [   31.696097]        ----
> [   31.696097]   lock(&lock->wait_lock);
> [   31.696097]<Interrupt>
> [   31.696097]     lock(&lock->wait_lock);
> [   31.696097]
> [   31.696097]  *** DEADLOCK ***
> [   31.696097]
> [   31.696097] 1 lock held by swapper/1/0:
> [   31.696097]  #0:  (&card->led_timer){+.-...}, at: [<c1037dd2>] run=
_timer_softirq+0xa2/0x240
> [   31.696097]
> [   31.696097] stack backtrace:
> [   31.696097] Pid: 0, comm: swapper/1 Not tainted 3.3.0-rc2-00116-g7=
1b1b20-dirty #134
> [   31.696097] Call Trace:
> [   31.696097]  [<c1073293>] print_usage_bug+0x163/0x170
> [   31.696097]  [<c1073c82>] mark_lock_irq+0xd2/0x230
> [   31.696097]  [<c10732a0>] ? print_usage_bug+0x170/0x170
> [   31.696097]  [<c1073ee6>] mark_lock+0x106/0x1e0
> [   31.696097]  [<c107d4bd>] ? __module_address+0x8d/0xb0
> [   31.696097]  [<c10740aa>] mark_irqflags+0xea/0x170
> [   31.696097]  [<c107568a>] __lock_acquire+0x2da/0x460
> [   31.696097]  [<c1045c47>] ? __kernel_text_address+0x47/0x70
> [   31.696097]  [<c107588b>] lock_acquire+0x7b/0xa0
> [   31.696097]  [<c14a48fc>] ? rt_mutex_trylock+0xc/0x60
> [   31.696097]  [<c14a4b6d>] _raw_spin_lock+0x3d/0x50
> [   31.696097]  [<c14a48fc>] ? rt_mutex_trylock+0xc/0x60
> [   31.696097]  [<c14a48fc>] rt_mutex_trylock+0xc/0x60
> [   31.696097]  [<c136c48b>] i2c_trylock_adapter+0x1b/0x40
> [   31.696097]  [<c136cc34>] i2c_transfer+0xa4/0xb0
> [   31.696097]  [<f814d130>] peak_pciec_write_pca9553+0x50/0x90 [peak=
_pci]
> [   31.696097]  [<f814d68e>] peak_pciec_led_timer+0xce/0x120 [peak_pc=
i]
> [   31.696097]  [<c1037d0c>] ? cascade+0x5c/0x80
> [   31.696097]  [<c1037e58>] run_timer_softirq+0x128/0x240
> [   31.696097]  [<c1037dd2>] ? run_timer_softirq+0xa2/0x240
> [   31.696097]  [<c11ba904>] ? trace_hardirqs_on_thunk+0xc/0x10
> [   31.696097]  [<f814d5c0>] ? peak_pciec_write_reg+0x170/0x170 [peak=
_pci]
> [   31.696097]  [<c1031b3b>] __do_softirq+0x8b/0x140
> [   31.696097]  [<c1031ab0>] ? irq_enter+0x60/0x60
> [   31.696097]<IRQ>   [<c103194d>] ? irq_exit+0xad/0xd0
> [   31.696097]  [<c101c5a3>] ? smp_apic_timer_interrupt+0x53/0x90
> [   31.696097]  [<c11ba914>] ? trace_hardirqs_off_thunk+0xc/0x18
> [   31.696097]  [<c14a59bb>] ? apic_timer_interrupt+0x2f/0x34
> [   31.696097]  [<c1225a1a>] ? acpi_idle_enter_c1+0x95/0xac
> [   31.696097]  [<c138fcc2>] ? cpuidle_idle_call+0x82/0xe0
> [   31.696097]  [<c1001e44>] ? cpu_idle+0x54/0xa0
> [   31.696097]  [<c149fa30>] ? start_secondary+0xb9/0xbc
> [   31.696097]  [<c149fa30>] ? start_secondary+0xb9/0xbc
> /// well ... any idea? This effect is reproducible every time when bo=
oting.
>
> [   32.062779] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> [   32.064879] Bluetooth: BNEP filters: protocol multicast
> [   38.833217] sshd (3235): /proc/3235/oom_adj is deprecated, please =
use /proc/3235/oom_score_adj instead.
> [  209.185840] can: controller area network core (rev 20090105 abi 8)
> [  209.185885] NET: Registered protocol family 29
> [  209.206694] can: raw protocol (rev 20090105)
>
> /// at this point i unplugged the PCAN-USB adapter (can6)
> [  219.426433] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.427422] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.428424] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.429422] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.430419] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.431420] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.432420] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.433419] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.434423] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.435423] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.436490] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.437500] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.438494] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.439489] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.440488] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.441498] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.442499] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.443420] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.444438] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.445437] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.446435] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.447420] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.448420] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.449439] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.450437] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.451433] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.452423] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.453422] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.454421] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.455422] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.456424] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.457422] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.458424] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.459422] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.460422] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.461420] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.462428] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.463427] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.464422] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.465433] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.466434] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.467434] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.468421] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.469436] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.470434] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.471434] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.472422] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.473434] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.474432] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.475440] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.476423] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.477421] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.478422] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.479423] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.480421] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.481419] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.482420] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.483424] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.484421] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.485423] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.486420] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.487421] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.488423] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.489422] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.490421] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.491422] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.492422] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.493430] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.494432] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.495431] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.496423] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.497435] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.498433] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.499434] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.500422] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.501434] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.502433] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.503423] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.504422] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.505426] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.506420] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.507424] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.508424] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.509428] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.510424] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.511425] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.512426] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.513429] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.514429] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.515429] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.516427] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.517427] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.518423] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.519425] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.520428] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.521422] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.522422] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.523430] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.524422] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.525421] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.526422] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.527420] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.528436] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.529429] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.530432] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.531433] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.532427] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.533431] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.534431] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.535419] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.536420] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.537432] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.538432] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.539433] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.540435] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.541418] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.542430] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.543424] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.544417] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.545421] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.546419] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.547420] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.548429] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.549425] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.550423] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.551428] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.552420] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.553415] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.554419] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.555421] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.556420] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.557423] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.558420] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.559435] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.560420] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.561432] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.562434] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.563434] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.564422] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.565434] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.566433] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.567434] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.568420] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.569422] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.570430] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.571422] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.572421] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.573431] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.574424] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.575419] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.576416] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.577429] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.578427] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.579425] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.580425] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.581421] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.582430] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.583439] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.584429] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.585429] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.586437] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.587434] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.588422] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.589420] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.590420] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.591421] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.592420] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.593421] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.594505] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.595505] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.596492] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.597498] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.598529] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.599492] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.600482] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.601497] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.602496] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.603495] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.604420] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.605411] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.606410] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.607411] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.608419] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.609411] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.610408] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.611421] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.612422] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.613502] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.614425] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.615410] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.616422] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.617411] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.618427] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.619422] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.620422] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.621422] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.622507] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.623504] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.624448] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.625451] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.626439] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.627447] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.628449] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.629450] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.630445] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.631445] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.632282] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.632433] peak_usb 5-1:1.0: can6: Rx URB aborted (-84)
> [  219.632630] usb 5-1: USB disconnect, device number 2
> [  219.652359] peak_usb 5-1:1.0: can6 removed
> /// done %-)
>
> /// at this point i unplugged the PCAN-USBpro adapter (can4 / can5)
> [  249.202205] usb 2-2: USB disconnect, device number 3
> [  249.220386] peak_usb 2-2:1.0: can5 removed
> [  249.232178] peak_usb 2-2:1.0: can4 removed
> /// looks much smoother ;-)
>
> After that i tried to unplug the PCMCIA and the PCIeC under load:
>
> They say
>
> peak_pcmcia 0.0: wakeup interrupt
>
> or
>
> peak_pci 0000:0e:00.0: wakeup interrupt
>
> on the console and then my machine dies without any additional info.
>
> Will try to check some of the error message behavior which is more in=
teresting for Wolfgang tomorrow.
>
> Best regards,
> Oliver
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
