From: Damien Dusha <d.dusha@gmail.com>
Subject: Dropped Tx frames with SJA1000
Date: Wed, 27 Jul 2016 16:23:41 +1000
Message-ID: <CABeNA8droHfwjaTkqnjbJBZTmETy_n58QDxFq9dne9w1EcjyHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:35911 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbcG0GXo (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 27 Jul 2016 02:23:44 -0400
Received: by mail-yw0-f193.google.com with SMTP id u134so3168971ywg.3
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2016 23:23:43 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Dear linux-can,

I am attempting to debug an issue with the SJA1000 driver. The symptom
is the occasional dropped frame when transmitting a burst of frames.
Reception is unaffected.


Hardware and Setup:

I am using an ESD CAN-PCI200 [1], which uses the sja1000_plx_pci
driver, on a standard Core 2 Duo machine running Fedora 24 i686 with a
freshly compiled vanilla linux-4.6.4.

The SJA1000 driver is patched with some debug (patch is shown below).
The problem appears without the debug, but it seems to appear more
frequently with debug (??).

07:04.0 Bridge: PLX Technology, Inc. PCI <-> IOBus Bridge (rev 02)
    Subsystem: ESD Electronic System Design GmbH Device 0004
    Flags: medium devsel, IRQ 20
    Memory at f0200400 (32-bit, non-prefetchable) [size=128]
    I/O ports at 1100 [size=128]
    Memory at f0200000 (32-bit, non-prefetchable) [size=1K]
    Kernel driver in use: sja1000_plx_pci
    Kernel modules: plx_pci


Symptoms:

The missing frames are not received with ./candump on the same
machine, nor is it seen on the bus externally; two other machines are
listening to the bus, both not receiving the same packet (PEAK USB
adaptors).

Dropped packets are not counted as a TX error in ifconfig, nor are
they counted as being sent.

can0: flags=193<UP,RUNNING,NOARP>  mtu 16
        unspec 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
txqueuelen 1000  (UNSPEC)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 10539  bytes 40178 (39.2 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
        device interrupt 20

It appears to be unrelated to the SJA1000 Tx drop issue observed in
Peak PCI devices earlier in the year [2].


Reproduction:

The easiest way to reproduce the problem is with the following
command, although it may take several attempts to do so:

for i in `seq 1 20`; do strace ./cangen can0 -g 0 -Ii -Di -Li -n 32; done

For example, it can be seen that ID 0x0A is missing with the following
run of ./candump (on a remote machine).

  can0  000   [1]  00
  can0  001   [1]  01
  can0  002   [2]  02 00
  can0  003   [3]  03 00 00
  can0  004   [4]  04 00 00 00
  can0  005   [5]  05 00 00 00 00
  can0  006   [6]  06 00 00 00 00 00
  can0  007   [7]  07 00 00 00 00 00 00
  can0  008   [8]  08 00 00 00 00 00 00 00
  can0  009   [1]  09
*** Missing 0x0A ***
  can0  00B   [2]  0B 00
  can0  00C   [3]  0C 00 00
  can0  00D   [4]  0D 00 00 00
  can0  00E   [5]  0E 00 00 00 00
  can0  00F   [6]  0F 00 00 00 00 00
  can0  010   [7]  10 00 00 00 00 00 00
  can0  011   [8]  11 00 00 00 00 00 00 00
  can0  012   [1]  12
  can0  013   [1]  13
  can0  014   [2]  14 00
  can0  015   [3]  15 00 00
  can0  016   [4]  16 00 00 00
  can0  017   [5]  17 00 00 00 00
  can0  018   [6]  18 00 00 00 00 00
  can0  019   [7]  19 00 00 00 00 00 00
  can0  01A   [8]  1A 00 00 00 00 00 00 00
  can0  01B   [1]  1B
  can0  01C   [1]  1C
  can0  01D   [2]  1D 00
  can0  01E   [3]  1E 00 00
  can0  01F   [4]  1F 00 00 00

Running strace is not necessary to reproduce the problem, but it does
confirm that the packet is received by the kernel.

write(3, "\0\0\0\0\1\0\0\0\0\0\0\0\0\0\0\0", 16) = 16
write(3, "\1\0\0\0\1\0\0\0\1\0\0\0\0\0\0\0", 16) = 16
write(3, "\2\0\0\0\2\0\0\0\2\0\0\0\0\0\0\0", 16) = 16
write(3, "\3\0\0\0\3\0\0\0\3\0\0\0\0\0\0\0", 16) = 16
write(3, "\4\0\0\0\4\0\0\0\4\0\0\0\0\0\0\0", 16) = 16
write(3, "\5\0\0\0\5\0\0\0\5\0\0\0\0\0\0\0", 16) = 16
write(3, "\6\0\0\0\6\0\0\0\6\0\0\0\0\0\0\0", 16) = 16
write(3, "\7\0\0\0\7\0\0\0\7\0\0\0\0\0\0\0", 16) = 16
write(3, "\10\0\0\0\10\0\0\0\10\0\0\0\0\0\0\0", 16) = 16
write(3, "\t\0\0\0\1\0\0\0\t\0\0\0\0\0\0\0", 16) = 16
** Note that 0x0A is indeed sent without error ***
write(3, "\n\0\0\0\1\0\0\0\n\0\0\0\0\0\0\0", 16) = 16
write(3, "\v\0\0\0\2\0\0\0\v\0\0\0\0\0\0\0", 16) = 16
write(3, "\f\0\0\0\3\0\0\0\f\0\0\0\0\0\0\0", 16) = 16
write(3, "\r\0\0\0\4\0\0\0\r\0\0\0\0\0\0\0", 16) = 16
write(3, "\16\0\0\0\5\0\0\0\16\0\0\0\0\0\0\0", 16) = 16
write(3, "\17\0\0\0\6\0\0\0\17\0\0\0\0\0\0\0", 16) = 16
write(3, "\20\0\0\0\7\0\0\0\20\0\0\0\0\0\0\0", 16) = 16
write(3, "\21\0\0\0\10\0\0\0\21\0\0\0\0\0\0\0", 16) = 16
write(3, "\22\0\0\0\1\0\0\0\22\0\0\0\0\0\0\0", 16) = 16
write(3, "\23\0\0\0\1\0\0\0\23\0\0\0\0\0\0\0", 16) = 16
write(3, "\24\0\0\0\2\0\0\0\24\0\0\0\0\0\0\0", 16) = 16
write(3, "\25\0\0\0\3\0\0\0\25\0\0\0\0\0\0\0", 16) = 16
write(3, "\26\0\0\0\4\0\0\0\26\0\0\0\0\0\0\0", 16) = 16
write(3, "\27\0\0\0\5\0\0\0\27\0\0\0\0\0\0\0", 16) = 16
write(3, "\30\0\0\0\6\0\0\0\30\0\0\0\0\0\0\0", 16) = 16
write(3, "\31\0\0\0\7\0\0\0\31\0\0\0\0\0\0\0", 16) = 16
write(3, "\32\0\0\0\10\0\0\0\32\0\0\0\0\0\0\0", 16) = 16
write(3, "\33\0\0\0\1\0\0\0\33\0\0\0\0\0\0\0", 16) = 16
write(3, "\34\0\0\0\1\0\0\0\34\0\0\0\0\0\0\0", 16) = 16
write(3, "\35\0\0\0\2\0\0\0\35\0\0\0\0\0\0\0", 16) = 16
write(3, "\36\0\0\0\3\0\0\0\36\0\0\0\0\0\0\0", 16) = 16
write(3, "\37\0\0\0\4\0\0\0\37\0\0\0\0\0\0\0", 16) = 16

Examining dmesg debug which was added to the SJA1000 driver, it
appears that 0x0A was never sent to the device.

[ 5223.770685] [sja1000_interrupt] start
[ 5223.770692] [sja1000_interrupt] tx_packets++
[ 5223.770693] [sja1000_interrupt] tx processing complete
[ 5223.770696] [sja1000_interrupt] end
[ 5223.770698] [sja1000_start_xmit] start
[ 5223.770700] Start tx, ID = 0x07
[ 5223.770704] [sja1000_start_xmit] end
[ 5223.771157] [sja1000_interrupt] start
[ 5223.771164] [sja1000_interrupt] tx_packets++
[ 5223.771166] [sja1000_interrupt] tx processing complete
[ 5223.771168] [sja1000_interrupt] end
[ 5223.771171] [sja1000_start_xmit] start
[ 5223.771172] Start tx, ID = 0x08
[ 5223.771177] [sja1000_start_xmit] end
[ 5223.771675] [sja1000_interrupt] start
[ 5223.771682] [sja1000_interrupt] tx_packets++
[ 5223.771684] [sja1000_interrupt] tx processing complete
[ 5223.771686] [sja1000_interrupt] end
[ 5223.771692] [sja1000_start_xmit] start
[ 5223.771694] Start tx, ID = 0x09
[ 5223.771698] [sja1000_start_xmit] end
[ 5223.771925] [sja1000_interrupt] start
[ 5223.771931] [sja1000_interrupt] tx_packets++
[ 5223.771932] [sja1000_interrupt] tx processing complete
[ 5223.771934] [sja1000_interrupt] end
*** Note that ID = 0x0A is never sent to the device ***
[ 5223.771938] [sja1000_start_xmit] start
[ 5223.771940] Start tx, ID = 0x0B
[ 5223.771944] [sja1000_start_xmit] end
[ 5223.772209] [sja1000_interrupt] start
[ 5223.772215] [sja1000_interrupt] tx_packets++
[ 5223.772217] [sja1000_interrupt] tx processing complete
[ 5223.772219] [sja1000_interrupt] end
[ 5223.772222] [sja1000_start_xmit] start
[ 5223.772223] Start tx, ID = 0x0C
[ 5223.772227] [sja1000_start_xmit] end
[ 5223.772529] [sja1000_interrupt] start
[ 5223.772536] [sja1000_interrupt] tx_packets++
[ 5223.772538] [sja1000_interrupt] tx processing complete
[ 5223.772540] [sja1000_interrupt] end
[ 5223.772542] [sja1000_start_xmit] start
[ 5223.772544] Start tx, ID = 0x0D


I am unsure how to proceed here to help debug the problem. Ideas are welcome.

Kind regards,
Damien.

References:

[1] https://esd.eu/en/products/can-pci200
[2] http://article.gmane.org/gmane.linux.can/8923



Patch with debug:


--- linux-4.6.4/drivers/net/can/sja1000/sja1000.c    2016-07-27
13:58:25.343706506 +1000
+++ clean/linux-4.6.4/drivers/net/can/sja1000/sja1000.c    2016-07-12
02:30:07.000000000 +1000
@@ -290,8 +290,6 @@
     u8 cmd_reg_val = 0x00;
     int i;

-    printk(KERN_NOTICE "[sja1000_start_xmit] start\n");
-
     if (can_dropped_invalid_skb(dev, skb))
         return NETDEV_TX_OK;

@@ -300,8 +298,6 @@
     fi = dlc = cf->can_dlc;
     id = cf->can_id;

-    printk(KERN_NOTICE "Start tx, ID = 0x%02X\n", id);
-
     if (id & CAN_RTR_FLAG)
         fi |= SJA1000_FI_RTR;

@@ -335,7 +331,6 @@

     sja1000_write_cmdreg(priv, cmd_reg_val);

-    printk("[sja1000_start_xmit] end\n");
     return NETDEV_TX_OK;
 }

@@ -505,8 +500,6 @@
     uint8_t isrc, status;
     int n = 0;

-    printk(KERN_NOTICE "[sja1000_interrupt] start\n");
-
     if (priv->pre_irq)
         priv->pre_irq(priv);

@@ -537,12 +530,9 @@
                     priv->read_reg(priv, SJA1000_FI) & 0xf;
                 stats->tx_packets++;
                 can_get_echo_skb(dev, 0);
-                printk(KERN_NOTICE "[sja1000_interrupt] tx_packets++\n");
             }
             netif_wake_queue(dev);
             can_led_event(dev, CAN_LED_EVENT_TX);
-
-            printk(KERN_NOTICE "[sja1000_interrupt] tx processing complete\n");
         }
         if (isrc & IRQ_RI) {
             /* receive interrupt */
@@ -568,8 +558,6 @@
     if (n >= SJA1000_MAX_IRQ)
         netdev_dbg(dev, "%d messages handled in ISR", n);

-    printk(KERN_NOTICE "[sja1000_interrupt] end\n");
-
     return (n) ? IRQ_HANDLED : IRQ_NONE;
 }
 EXPORT_SYMBOL_GPL(sja1000_interrupt);
