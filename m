From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 0/3 v5] can/usb: Add PEAK-System PCAN USB adapters driver
Date: Wed, 22 Feb 2012 08:05:01 +0100
Message-ID: <4F44939D.9050703@hartkopp.net>
References: <1329481458-2586-1-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:54575 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798Ab2BVHFX (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 22 Feb 2012 02:05:23 -0500
In-Reply-To: <1329481458-2586-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

On 17.02.2012 13:24, Stephane Grosjean wrote:

> That serie of patches adds the peak_usb driver which handles the PCAN-USB
> and PCAN-USB Pro adapters from PEAK-System (http://www.peak-system.com).
> These patches are planned for kernel v3.02.00 and above.


Hello Stephane,

i tested this driver on my way back home yesterday.

The error handling looks good now.

But the plug-out of the USB hardware (USB & USBpro) when sending traffic
through these interfaces leads to heavy problems.

My setup was

bus0: pcmcia#0, USBpro#0, USB, USB
bus1: pcmcia#1, USBpro#1

I was sending with 'cangen -g0 -i' on both USBpro interfaces.

When unplug the USBpro i got the following kernel dump. After waiting some
more seconds after this kernel dump the system crashed finally - i assume he
issue corrupted some more kernel internal data structures ... 

In the log below the kernel didn't crash immediately therefore i was luckily
able to save it.

This behaviour is reproducible with both USB & USBpro under tx load.

Regards,
Oliver

Feb 21 19:38:01 vwagwolkf484 kernel: [  218.383844] pcmcia_socket pcmcia_socket0: pccard: PCMCIA card inserted into slot 0
Feb 21 19:38:01 vwagwolkf484 kernel: [  218.383861] pcmcia_socket pcmcia_socket0: cs: memory probe 0xf1da0000-0xf2a6ffff: excluding 0xf1f38000-0xf2003fff
Feb 21 19:38:01 vwagwolkf484 kernel: [  218.393616] pcmcia 0.0: pcmcia: registering new device pcmcia0.0 (IRQ: 18)
Feb 21 19:38:01 vwagwolkf484 kernel: [  218.404691] CAN device driver interface
Feb 21 19:38:01 vwagwolkf484 kernel: [  218.407556] sja1000 CAN netdevice driver
Feb 21 19:38:01 vwagwolkf484 kernel: [  218.450049] peak_pcmcia 0.0: PEAK-System pcmcia card PC_CAN_CARD fw 1.5
Feb 21 19:38:01 vwagwolkf484 kernel: [  218.453698] peak_pcmcia 0.0: can0 on channel 0 at 0x00012100 irq 18
Feb 21 19:38:01 vwagwolkf484 kernel: [  218.455216] peak_pcmcia 0.0: can1 on channel 1 at 0x00012120 irq 18
Feb 21 19:39:18 vwagwolkf484 kernel: [  295.686726] usb 2-1.3: new high-speed USB device number 6 using ehci_hcd
Feb 21 19:39:18 vwagwolkf484 kernel: [  295.779176] usb 2-1.3: config 1 interface 0 altsetting 0 bulk endpoint 0x83 has invalid maxpacket 64
Feb 21 19:39:18 vwagwolkf484 kernel: [  295.779184] usb 2-1.3: config 1 interface 1 altsetting 0 bulk endpoint 0x86 has invalid maxpacket 64
Feb 21 19:39:18 vwagwolkf484 kernel: [  295.779923] usb 2-1.3: New USB device found, idVendor=0c72, idProduct=000d
Feb 21 19:39:18 vwagwolkf484 kernel: [  295.779928] usb 2-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
Feb 21 19:39:18 vwagwolkf484 kernel: [  295.779933] usb 2-1.3: Product: PCAN-USB-PRO DEVICE
Feb 21 19:39:18 vwagwolkf484 kernel: [  295.779936] usb 2-1.3: Manufacturer: PEAK-System Technik GmbH
Feb 21 19:39:18 vwagwolkf484 kernel: [  295.822189] peak_usb 2-1.3:1.0: PEAK-System PCAN-USB Pro hwrev 0 serial FFFFFFFF.00000001 (2 channels)
Feb 21 19:39:18 vwagwolkf484 kernel: [  295.822948] peak_usb 2-1.3:1.0: can2: attached to PCAN-USB Pro channel 0 (device 1)
Feb 21 19:39:18 vwagwolkf484 kernel: [  295.825182] peak_usb 2-1.3:1.0: can3: attached to PCAN-USB Pro channel 1 (device 0)
Feb 21 19:39:18 vwagwolkf484 kernel: [  295.825270] usbcore: registered new interface driver peak_usb
Feb 21 19:49:28 vwagwolkf484 kernel: [  904.970430] peak_pcmcia 0.0: setting BTR0=0x00 BTR1=0x1c
Feb 21 19:49:38 vwagwolkf484 kernel: [  914.219487] peak_pcmcia 0.0: setting BTR0=0x00 BTR1=0x1c
Feb 21 19:49:47 vwagwolkf484 kernel: [  923.079481] peak_usb 2-1.3:1.0: can2: setting ccbt=0x001c0006
Feb 21 19:49:51 vwagwolkf484 kernel: [  927.612330] peak_usb 2-1.3:1.0: can3: setting ccbt=0x001c0006
Feb 21 19:51:07 vwagwolkf484 kernel: [ 1003.785392] can: controller area network core (rev 20090105 abi 8)
Feb 21 19:51:07 vwagwolkf484 kernel: [ 1003.785478] NET: Registered protocol family 29
Feb 21 19:51:07 vwagwolkf484 kernel: [ 1003.791537] can: raw protocol (rev 20090105)
Feb 21 19:57:48 vwagwolkf484 kernel: [ 1403.796273] usb 2-1.1: new full-speed USB device number 7 using ehci_hcd
Feb 21 19:57:48 vwagwolkf484 kernel: [ 1403.893358] usb 2-1.1: New USB device found, idVendor=0c72, idProduct=000c
Feb 21 19:57:48 vwagwolkf484 kernel: [ 1403.893363] usb 2-1.1: New USB device strings: Mfr=0, Product=3, SerialNumber=0
Feb 21 19:57:48 vwagwolkf484 kernel: [ 1403.893367] usb 2-1.1: Product: VER1:PEAK    
Feb 21 19:57:48 vwagwolkf484 kernel: [ 1403.893368] VER2:02.8.01        
Feb 21 19:57:48 vwagwolkf484 kernel: [ 1403.893368] DAT :06.05.2004
Feb 21 19:57:48 vwagwolkf484 kernel: [ 1403.893369] TIME:09:35:37
Feb 21 19:57:48 vwagwolkf484 kernel: [ 1403.893370]                              ...
Feb 21 19:57:48 vwagwolkf484 kernel: [ 1403.895828] peak_usb 2-1.1:1.0: PEAK-System PCAN-USB adapter hwrev 28 serial FFFFFFFF (1 channel)
Feb 21 19:57:48 vwagwolkf484 kernel: [ 1403.896329] peak_usb 2-1.1:1.0: can4: attached to PCAN-USB channel 0 (device 46)
Feb 21 19:57:55 vwagwolkf484 kernel: [ 1410.436831] usb 2-1.4: new full-speed USB device number 8 using ehci_hcd
Feb 21 19:57:55 vwagwolkf484 kernel: [ 1410.533390] usb 2-1.4: New USB device found, idVendor=0c72, idProduct=000c
Feb 21 19:57:55 vwagwolkf484 kernel: [ 1410.533394] usb 2-1.4: New USB device strings: Mfr=0, Product=3, SerialNumber=0
Feb 21 19:57:55 vwagwolkf484 kernel: [ 1410.533398] usb 2-1.4: Product: VER1:PEAK    
Feb 21 19:57:55 vwagwolkf484 kernel: [ 1410.533399] VER2:02.8.01        
Feb 21 19:57:55 vwagwolkf484 kernel: [ 1410.533400] DAT :06.05.2004
Feb 21 19:57:55 vwagwolkf484 kernel: [ 1410.533401] TIME:09:35:37
Feb 21 19:57:55 vwagwolkf484 kernel: [ 1410.533402]                              ...
Feb 21 19:57:55 vwagwolkf484 kernel: [ 1410.536035] peak_usb 2-1.4:1.0: PEAK-System PCAN-USB adapter hwrev 28 serial FFFFFFFF (1 channel)
Feb 21 19:57:55 vwagwolkf484 kernel: [ 1410.536525] peak_usb 2-1.4:1.0: can5: attached to PCAN-USB channel 0 (device 255)
Feb 21 20:00:01 vwagwolkf484 kernel: [ 1536.509165] peak_usb 2-1.1:1.0: can4: setting BTR0=0x00 BTR1=0x1c
Feb 21 20:00:06 vwagwolkf484 kernel: [ 1541.171104] peak_usb 2-1.4:1.0: can5: setting BTR0=0x00 BTR1=0x1c
Feb 21 20:27:05 vwagwolkf484 acpid: client 1249[0:0] has disconnected
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.519539] peak_usb 2-1.3:1.0: can3: Tx URB aborted (-71)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.519592] peak_usb 2-1.3:1.0: can2: Tx URB aborted (-71)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.519632] peak_usb 2-1.3:1.0: can_put_echo_skb: BUG! echo_skb is occupied!
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.519707] peak_usb 2-1.3:1.0: can3: Rx URB aborted (-71)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.519746] peak_usb 2-1.3:1.0: can_put_echo_skb: BUG! echo_skb is occupied!
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.523654] peak_usb 2-1.3:1.0: can3: Tx URB aborted (-71)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.523701] peak_usb 2-1.3:1.0: can_put_echo_skb: BUG! echo_skb is occupied!
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.523779] peak_usb 2-1.3:1.0: can2: Tx URB aborted (-71)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.523812] peak_usb 2-1.3:1.0: can_put_echo_skb: BUG! echo_skb is occupied!
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.523905] peak_usb 2-1.3:1.0: can3: Rx URB aborted (-71)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.527772] peak_usb 2-1.3:1.0: can3: Tx URB aborted (-71)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.527813] peak_usb 2-1.3:1.0: can_put_echo_skb: BUG! echo_skb is occupied!
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.527898] peak_usb 2-1.3:1.0: can2: Tx URB aborted (-71)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.527945] peak_usb 2-1.3:1.0: can_put_echo_skb: BUG! echo_skb is occupied!
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.528024] peak_usb 2-1.3:1.0: can3: Rx URB aborted (-71)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.531890] peak_usb 2-1.3:1.0: can3: Tx URB aborted (-71)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.531936] peak_usb 2-1.3:1.0: can_put_echo_skb: BUG! echo_skb is occupied!
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.532017] peak_usb 2-1.3:1.0: can2: Tx URB aborted (-71)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.532070] peak_usb 2-1.3:1.0: can_put_echo_skb: BUG! echo_skb is occupied!
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.532141] peak_usb 2-1.3:1.0: can2: Rx URB aborted (-71)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.536010] peak_usb 2-1.3:1.0: can3: Tx URB aborted (-71)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.536057] peak_usb 2-1.3:1.0: can_put_echo_skb: BUG! echo_skb is occupied!
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.536135] peak_usb 2-1.3:1.0: can2: Tx URB aborted (-71)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.536187] peak_usb 2-1.3:1.0: can_put_echo_skb: BUG! echo_skb is occupied!
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.536259] peak_usb 2-1.3:1.0: can2: Rx URB aborted (-71)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.540126] peak_usb 2-1.3:1.0: can3: Tx URB aborted (-71)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.540172] peak_usb 2-1.3:1.0: can_put_echo_skb: BUG! echo_skb is occupied!
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.540251] peak_usb 2-1.3:1.0: can2: Tx URB aborted (-71)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.540285] peak_usb 2-1.3:1.0: can_put_echo_skb: BUG! echo_skb is occupied!
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.540377] peak_usb 2-1.3:1.0: can2: Rx URB aborted (-71)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.544244] peak_usb 2-1.3:1.0: can3: Tx URB aborted (-71)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.544285] peak_usb 2-1.3:1.0: can_put_echo_skb: BUG! echo_skb is occupied!
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.544369] peak_usb 2-1.3:1.0: can2: Tx URB aborted (-71)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.544418] peak_usb 2-1.3:1.0: can_put_echo_skb: BUG! echo_skb is occupied!
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.544497] peak_usb 2-1.3:1.0: can2: Rx URB aborted (-71)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.548362] peak_usb 2-1.3:1.0: can3: Tx URB aborted (-71)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.548409] peak_usb 2-1.3:1.0: can_put_echo_skb: BUG! echo_skb is occupied!
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.548488] peak_usb 2-1.3:1.0: can2: Tx URB aborted (-71)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.548537] peak_usb 2-1.3:1.0: can_put_echo_skb: BUG! echo_skb is occupied!
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.548613] peak_usb 2-1.3:1.0: can3: Rx URB aborted (-71)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.552483] peak_usb 2-1.3:1.0: can3: Tx URB aborted (-71)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.552534] peak_usb 2-1.3:1.0: can_put_echo_skb: BUG! echo_skb is occupied!
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.552606] peak_usb 2-1.3:1.0: can2: Tx URB aborted (-71)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.552662] peak_usb 2-1.3:1.0: can_put_echo_skb: BUG! echo_skb is occupied!
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.552729] peak_usb 2-1.3:1.0: can3: Rx URB aborted (-71)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.556598] peak_usb 2-1.3:1.0: can3: Tx URB aborted (-71)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.556642] peak_usb 2-1.3:1.0: can_put_echo_skb: BUG! echo_skb is occupied!
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.556724] peak_usb 2-1.3:1.0: can2: Tx URB aborted (-71)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.556772] peak_usb 2-1.3:1.0: can_put_echo_skb: BUG! echo_skb is occupied!
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.556850] peak_usb 2-1.3:1.0: can3: Rx URB aborted (-71)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.560716] peak_usb 2-1.3:1.0: can3: Tx URB aborted (-71)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.560764] peak_usb 2-1.3:1.0: can_put_echo_skb: BUG! echo_skb is occupied!
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.560842] peak_usb 2-1.3:1.0: can2: Tx URB aborted (-71)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.560891] peak_usb 2-1.3:1.0: can_put_echo_skb: BUG! echo_skb is occupied!
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.564836] peak_usb 2-1.3:1.0: can3: Tx URB aborted (-71)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.564884] peak_usb 2-1.3:1.0: can_put_echo_skb: BUG! echo_skb is occupied!
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.564959] peak_usb 2-1.3:1.0: can2: Tx URB aborted (-71)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.565014] peak_usb 2-1.3:1.0: can_put_echo_skb: BUG! echo_skb is occupied!
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.568951] peak_usb 2-1.3:1.0: can3: Tx URB aborted (-71)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.568999] peak_usb 2-1.3:1.0: can_put_echo_skb: BUG! echo_skb is occupied!
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.569076] peak_usb 2-1.3:1.0: can2: Tx URB aborted (-71)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.569110] peak_usb 2-1.3:1.0: can_put_echo_skb: BUG! echo_skb is occupied!
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.573069] peak_usb 2-1.3:1.0: can3: Tx URB aborted (-71)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.573108] peak_usb 2-1.3:1.0: can_put_echo_skb: BUG! echo_skb is occupied!
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.573194] peak_usb 2-1.3:1.0: can2: Tx URB aborted (-71)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.573200] peak_usb 2-1.3:1.0: can_put_echo_skb: BUG! echo_skb is occupied!
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.581180] peak_usb 2-1.3:1.0: can3: Tx URB aborted (-71)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.582981] peak_usb 2-1.3:1.0: can_put_echo_skb: BUG! echo_skb is occupied!
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.582998] peak_usb 2-1.3:1.0: can2: Tx URB aborted (-71)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.583004] peak_usb 2-1.3:1.0: can_put_echo_skb: BUG! echo_skb is occupied!
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.591165] peak_usb 2-1.3:1.0: can3: Tx URB aborted (-71)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.593000] peak_usb 2-1.3:1.0: can_put_echo_skb: BUG! echo_skb is occupied!
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.593012] peak_usb 2-1.3:1.0: can2: Tx URB aborted (-71)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.593028] peak_usb 2-1.3:1.0: can_put_echo_skb: BUG! echo_skb is occupied!
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.601395] peak_usb 2-1.3:1.0: can3: Tx URB aborted (-71)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.603321] peak_usb 2-1.3:1.0: can_put_echo_skb: BUG! echo_skb is occupied!
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.604797] peak_usb 2-1.3:1.0: can2: Tx URB aborted (-71)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.606299] peak_usb 2-1.3:1.0: can_put_echo_skb: BUG! echo_skb is occupied!
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.610389] usb 2-1.3: USB disconnect, device number 6
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.613502] peak_usb 2-1.3:1.0: can3: Tx URB aborted (-71)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.615086] peak_usb 2-1.3:1.0: can_put_echo_skb: BUG! echo_skb is occupied!
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.615110] peak_usb 2-1.3:1.0: can2: Tx URB aborted (-71)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.615114] peak_usb 2-1.3:1.0: can2: Tx URB aborted (-108)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.615117] peak_usb 2-1.3:1.0: can_put_echo_skb: BUG! echo_skb is occupied!
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.615120] peak_usb 2-1.3:1.0: can2: Tx URB aborted (-108)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.615124] peak_usb 2-1.3:1.0: can_put_echo_skb: BUG! echo_skb is occupied!
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.615130] peak_usb 2-1.3:1.0: can_put_echo_skb: BUG! echo_skb is occupied!
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.623962] peak_usb 2-1.3:1.0: can3: Tx URB aborted (-108)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.623969] peak_usb 2-1.3:1.0: can3: Tx URB aborted (-108)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.623973] peak_usb 2-1.3:1.0: can3: Tx URB aborted (-108)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.623976] peak_usb 2-1.3:1.0: can3: Tx URB aborted (-108)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.623980] peak_usb 2-1.3:1.0: can3: Tx URB aborted (-108)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.623983] peak_usb 2-1.3:1.0: can3: Tx URB aborted (-108)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.623986] peak_usb 2-1.3:1.0: can3: Tx URB aborted (-108)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.623990] peak_usb 2-1.3:1.0: can3: Tx URB aborted (-108)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.623993] peak_usb 2-1.3:1.0: can3: Tx URB aborted (-108)
Feb 21 20:27:10 vwagwolkf484 avahi-daemon[1445]: Withdrawing workstation service for can3.
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.648060] BUG: unable to handle kernel NULL pointer dereference at 00000004
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.649863] IP: [<c104eaf5>] commit_creds+0x15/0xf0
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.651651] *pdpt = 000000002dd77001 *pde = 0000000000000000 
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.653379] Oops: 0000 [#1] SMP 
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.655193] Modules linked in: can_raw can peak_usb peak_pcmcia sja1000 can_dev acpi_cpufreq mperf cpufreq_powersave cpufreq_conservative cpufreq_userspace vcan bnep rfcomm binfmt_misc uinput fuse loop arc4 btusb bluetooth iwlwifi mac80211 snd_hda_codec_hdmi snd_hda_codec_idt pcmcia usbmouse usbhid hid snd_hda_intel snd_hda_codec snd_hwdep snd_pcm snd_seq cfg80211 snd_timer snd_seq_device dell_wmi snd sparse_keymap sdhci_pci sdhci soundcore tpm_tis psmouse dell_laptop tpm dcdbas serio_raw i2c_i801 mmc_core yenta_socket rfkill snd_page_alloc wmi tpm_bios battery processor ac evdev power_supply
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.661581] 
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.663608] Pid: 3270, comm: net.agent Not tainted 3.3.0-rc4-00019-g27e74da-dirty #3 Dell Inc. Latitude E6510
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.665862] EIP: 0060:[<c104eaf5>] EFLAGS: 00010246 CPU: 3
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.668036] EIP is at commit_creds+0x15/0xf0
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.670272] EAX: 00000004 EBX: f2790a40 ECX: 000001fa EDX: 00000000
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.672509] ESI: 00000004 EDI: f2974d80 EBP: eddc1dd0 ESP: eddc1dc4
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.674751]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.676738] Process net.agent (pid: 3270, ti=eddc0000 task=f2974d80 task.ti=eddc0000)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.678506] Stack:
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.680242]  f0799380 00000000 00000000 eddc1ddc c10d9261 f0799380 eddc1e4c c1117c2b
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.682105]  00000000 00001812 00000000 f1a408c0 f0799380 b76f1000 f2974d80 00000008
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.683908]  00000001 080606c0 08060320 0805f320 08048000 eddc1e30 08048000 b76f1000
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.685770] Call Trace:
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.687689]  [<c10d9261>] install_exec_creds+0x11/0x40
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.689569]  [<c1117c2b>] load_elf_binary+0x72b/0xa20
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.691356]  [<c1117500>] ? do_mmap+0x70/0x70
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.693140]  [<c10dae4d>] search_binary_handler+0xed/0x310
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.694971]  [<c10dad84>] ? search_binary_handler+0x24/0x310
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.696890]  [<c11172ea>] load_script+0x24a/0x270
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.698746]  [<c10dae46>] ? search_binary_handler+0xe6/0x310
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.700541]  [<c106e335>] ? __lock_release+0x95/0xc0
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.702336]  [<c11170a0>] ? locks_remove_flock+0x120/0x120
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.704206]  [<c10dae4d>] search_binary_handler+0xed/0x310
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.706009]  [<c10dad84>] ? search_binary_handler+0x24/0x310
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.707821]  [<c10db695>] do_execve_common+0x225/0x2a0
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.710234]  [<c10db722>] do_execve+0x12/0x20
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.712394]  [<c100ad82>] sys_execve+0x32/0x70
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.714244]  [<c144be12>] ptregs_execve+0x12/0x18
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.716031]  [<c144bd97>] ? sysenter_do_call+0x12/0x36
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.717882] Code: bc 27 00 00 00 00 e8 6b ff ff ff 5d c3 0f 0b 8d b4 26 00 00 00 00 55 89 e5 57 56 89 c6 53 64 8b 3d 30 b7 69 c1 8b 9f e0 01 00 00 <8b> 00 3b 9f e4 01 00 00 0f 85 c6 00 00 00 8b 06 85 c0 0f 8e ba 
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.720237] EIP: [<c104eaf5>] commit_creds+0x15/0xf0 SS:ESP 0068:eddc1dc4
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.722348] CR2: 0000000000000004
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.724447] ---[ end trace 235c4f770db8b51e ]---
Feb 21 20:27:10 vwagwolkf484 udevd[2643]: 'net.agent' [3270] terminated by signal 9 (Killed)
Feb 21 20:27:10 vwagwolkf484 NetworkManager[1214]:    SCPlugin-Ifupdown: devices removed (path: /sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.3/2-1.3:1.0/net/can3, iface: can3)
Feb 21 20:27:10 vwagwolkf484 avahi-daemon[1445]: Withdrawing workstation service for can2.
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.739715] peak_usb 2-1.3:1.0: can3 removed
Feb 21 20:27:10 vwagwolkf484 NetworkManager[1214]:    SCPlugin-Ifupdown: devices removed (path: /sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.3/2-1.3:1.0/net/can2, iface: can2)
Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.771675] peak_usb 2-1.3:1.0: can2 removed
Feb 21 20:27:19 vwagwolkf484 dhclient: DHCPDISCOVER on wlan0 to 255.255.255.255 port 67 interval 13
Feb 21 20:27:32 vwagwolkf484 dhclient: No DHCPOFFERS received.
Feb 21 20:27:32 vwagwolkf484 dhclient: No working leases in persistent database - sleeping.

