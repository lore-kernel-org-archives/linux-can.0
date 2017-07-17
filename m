From: =?UTF-8?Q?Andr=c3=a9_Hartmann?= <aha_1980@gmx.de>
Subject: Re: Getting manufacturer/product name for CAN interface
Date: Mon, 17 Jul 2017 21:36:19 +0200
Message-ID: <5c9a4542-aa3d-c54f-7f83-d7cd3f594a65@gmx.de>
References: <c3904508-14b9-1ffb-8507-9196fa193f56@gmx.de>
 <955344be-5991-5de9-a705-5f2e480c765d@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:61360 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751316AbdGQTg0 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 17 Jul 2017 15:36:26 -0400
In-Reply-To: <955344be-5991-5de9-a705-5f2e480c765d@grandegger.com>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, Marcel.Birthelmer@microchip.com

Hi Wolfgang and Marcel,

(sorry for the delay - I have been busy with lots of other things...)

> Hello,
> 
> Am 01.07.2017 um 17:57 schrieb André Hartmann:
>> Hi SocketCAN experts and developers,
>>
>> I'm one of the QtSerialBus [1] developers and added a function to scan
>> for available devices [2] some month ago.
>>
>> For now this function reads the sysfs to create a list like this:
>>
>> can0
>> can1
>> vcan0
>> vcan1
>>
>> What I wanted to have now, is the corresponding hardware description for
>> each of these interfaces. For the virtual devices this would be just
>> something like "Virtual CAN 0". For real hardware I'd like to get the
>> manufacturer and product strings.
>>
>> This information is available in dmesg when a device is connected:
>>
>> [48395.500029] usb 1-4: new full-speed USB device number 7 using xhci_hcd
>> [48395.641496] usb 1-4: New USB device found, idVendor=0878, idProduct=1105
>> [48395.641501] usb 1-4: New USB device strings: Mfr=1, Product=2,
>> SerialNumber=0
>> [48395.641504] usb 1-4: Product: USB-CANmodul2
>> [48395.641507] usb 1-4: Manufacturer: SYS TEC electronic GmbH
>>
>> But not even ifconfig shows this:
>>
>> can0      Link encap:UNSPEC  Hardware Adresse 00-01-B0-BD-...-00
>>             NOARP  MTU:16  Metrik:1
>>             RX-Pakete:0 Fehler:0 Verloren:0 Überläufe:0 Fenster:0
>>             TX-Pakete:0 Fehler:0 Verloren:0 Überläufe:0 Träger:0
>>             Kollisionen:0 Sendewarteschlangenlänge:10
>>             RX-Bytes:0 (0.0 B)  TX-Bytes:0 (0.0 B)
>>
>> can1      Link encap:UNSPEC  Hardware Adresse 00-01-B0-BD--...-00
>>             NOARP  MTU:16  Metrik:1
>>             RX-Pakete:0 Fehler:0 Verloren:0 Überläufe:0 Fenster:0
>>             TX-Pakete:0 Fehler:0 Verloren:0 Überläufe:0 Träger:0
>>             Kollisionen:0 Sendewarteschlangenlänge:10
>>             RX-Bytes:0 (0.0 B)  TX-Bytes:0 (0.0 B)
>>
>> Now the question: Is there a way to query manufacturer/device
>> information for a given interface name canX from C/C++?
> 
> You can get device information via netlink interface:
> 
>    $ ip -d link show can0
>    4: can0: <NOARP,ECHO> mtu 16 qdisc noop state DOWN mode DEFAULT group default qlen 10
>        link/can  promiscuity 0
>        can state STOPPED restart-ms 0
>        pcan_usb: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
>        clock 8000000
> 
> It lists the short name of the CAN controller. Here "pcan_us", or
> "sja1000", "mscan", "flexcan" and others.
> 
> Wolfgang.
> 

thanks for your hints! I've investigated a bit (with PEAK and SYSTEC
adapters) and I'm partly satisfied.

Wolfgangs tip with ip -d gives me indeed the driver associated to a
CAN interface. And in /sys/class/net/can0/subsystem/can0/device/
interface I found the device string, thanks Marcel. (Full logs are
appended).

However, the most important infos are still only visible in dmesg.
It's the drivers output which CAN channel is associated with each
hardware interface, e.g.:

peak_usb 2-1.4:1.0: PEAK-System PCAN-USB Pro [...] (2 channels)
peak_usb 2-1.4:1.0 can0: attached to PCAN-USB Pro channel 0 (device 1)
peak_usb 2-1.4:1.0 can1: attached to PCAN-USB Pro channel 1 (device 0)

So if there is no way to get these infos from userspace now, I think it
would be a good addition to have this possibility. Especially if there
is more than one CAN adapter connected.

What do you think?

Best regards,
André

=== Peak PCAN-USB-Pro connected =====================================

$ dmesg | grep -i peak
[    2.330286] usb 2-1.4: Manufacturer: PEAK-System Technik GmbH
[   18.949803] peak_usb 2-1.4:1.0: PEAK-System PCAN-USB Pro hwrev 0 
serial FFFFFFFF.00000001 (2 channels)
[   18.950300] peak_usb 2-1.4:1.0 can0: attached to PCAN-USB Pro channel 
0 (device 1)
[   18.951053] peak_usb 2-1.4:1.0 can1: attached to PCAN-USB Pro channel 
1 (device 0)

$ ip -d link show can0
3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN 
mode DEFAULT group default qlen 10
     link/can  promiscuity 0
     can state ERROR-ACTIVE restart-ms 100
     bitrate 250000 sample-point 0.875
     tq 250 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
     pcan_usb_pro: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..1024 brp-inc 1
     clock 56000000

$ cat /sys/class/net/can0/subsystem/can0/device/interface
PCAN-USB-PRO-CAN Device

=== SYSTEC USB-canmodul connected ===================================

$ dmesg | grep -i systec
[10674.953674] usb 2-1.4: New USB device found, idVendor=0878, 
idProduct=1181
[10674.953686] usb 2-1.4: New USB device strings: Mfr=1, Product=2, 
SerialNumber=0
[10674.953692] usb 2-1.4: Product: USB-CANmodul2
[10674.953697] usb 2-1.4: Manufacturer: SYS TEC electronic GmbH
[10675.072589] systec_can 2-1.4:1.0: registered device: can0 (channel 
0), 00:01:b0:bd:00:00
[10675.112744] systec_can 2-1.4:1.0: registered device: can1 (channel 
1), 00:01:b0:bd:00:01

$ ip -d link show can0
6: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN 
mode DEFAULT group default qlen 10
     link/can 00:01:b0:bd:00:00 brd 00:00:00:00:00:00 promiscuity 0
     can state ERROR-ACTIVE restart-ms 100
     bitrate 250000 sample-point 0.875
     tq 250 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
     systec_can: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..255 brp-inc 1
     clock 48000000

$ cat /sys/class/net/can0/subsystem/can0/device/interface
USB-CANmodul2
