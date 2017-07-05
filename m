From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Getting manufacturer/product name for CAN interface
Date: Wed, 5 Jul 2017 20:01:38 +0200
Message-ID: <955344be-5991-5de9-a705-5f2e480c765d@grandegger.com>
References: <c3904508-14b9-1ffb-8507-9196fa193f56@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy03.manitu.net ([217.11.48.67]:58624 "EHLO
        mailproxy03.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751772AbdGESHM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 5 Jul 2017 14:07:12 -0400
In-Reply-To: <c3904508-14b9-1ffb-8507-9196fa193f56@gmx.de>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?Q?Andr=c3=a9_Hartmann?= <aha_1980@gmx.de>, linux-can@vger.kernel.org

Hello,

Am 01.07.2017 um 17:57 schrieb André Hartmann:
> Hi SocketCAN experts and developers,
> 
> I'm one of the QtSerialBus [1] developers and added a function to scan
> for available devices [2] some month ago.
> 
> For now this function reads the sysfs to create a list like this:
> 
> can0
> can1
> vcan0
> vcan1
> 
> What I wanted to have now, is the corresponding hardware description for
> each of these interfaces. For the virtual devices this would be just 
> something like "Virtual CAN 0". For real hardware I'd like to get the 
> manufacturer and product strings.
> 
> This information is available in dmesg when a device is connected:
> 
> [48395.500029] usb 1-4: new full-speed USB device number 7 using xhci_hcd
> [48395.641496] usb 1-4: New USB device found, idVendor=0878, idProduct=1105
> [48395.641501] usb 1-4: New USB device strings: Mfr=1, Product=2, 
> SerialNumber=0
> [48395.641504] usb 1-4: Product: USB-CANmodul2
> [48395.641507] usb 1-4: Manufacturer: SYS TEC electronic GmbH
> 
> But not even ifconfig shows this:
> 
> can0      Link encap:UNSPEC  Hardware Adresse 00-01-B0-BD-...-00
>            NOARP  MTU:16  Metrik:1
>            RX-Pakete:0 Fehler:0 Verloren:0 Überläufe:0 Fenster:0
>            TX-Pakete:0 Fehler:0 Verloren:0 Überläufe:0 Träger:0
>            Kollisionen:0 Sendewarteschlangenlänge:10
>            RX-Bytes:0 (0.0 B)  TX-Bytes:0 (0.0 B)
> 
> can1      Link encap:UNSPEC  Hardware Adresse 00-01-B0-BD--...-00
>            NOARP  MTU:16  Metrik:1
>            RX-Pakete:0 Fehler:0 Verloren:0 Überläufe:0 Fenster:0
>            TX-Pakete:0 Fehler:0 Verloren:0 Überläufe:0 Träger:0
>            Kollisionen:0 Sendewarteschlangenlänge:10
>            RX-Bytes:0 (0.0 B)  TX-Bytes:0 (0.0 B)
> 
> Now the question: Is there a way to query manufacturer/device
> information for a given interface name canX from C/C++?

You can get device information via netlink interface:

  $ ip -d link show can0
  4: can0: <NOARP,ECHO> mtu 16 qdisc noop state DOWN mode DEFAULT group default qlen 10
      link/can  promiscuity 0 
      can state STOPPED restart-ms 0 
      pcan_usb: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
      clock 8000000

It lists the short name of the CAN controller. Here "pcan_us", or 
"sja1000", "mscan", "flexcan" and others.

Wolfgang.
