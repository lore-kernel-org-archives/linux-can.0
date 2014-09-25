From: Brian Gregory <bdg@theptrgroup.com>
Subject: ESD CAN-USB/2 Linux Mint 16 kernel 3.11
Date: Thu, 25 Sep 2014 13:01:43 -0400
Message-ID: <D049C2B7.2117A%bdg@theptrgroup.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.theptrgroup.com ([71.178.251.9]:36835 "EHLO
	mail.theptrgroup.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989AbaIYRBr (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 25 Sep 2014 13:01:47 -0400
Received: from [10.11.21.30] (unknown [10.11.21.30])
	by mail.theptrgroup.com (Postfix) with ESMTP id 69A7DE0962
	for <linux-can@vger.kernel.org>; Thu, 25 Sep 2014 13:01:45 -0400 (EDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

I am having trouble trying to get this to work and I have been unable to
find a relevant email on the list.

I am running Linux Mint 16 64bit (kernel 3.11) and I have confirmed that
can-dev and esd_usb2 support is configured as kernel modules.
I have loaded these modules and confirmed with lsmod:

slcan 13049 0
vcan 12726 0
can_dev 20692 4 esd_usb2,ems_usb,peak_usb,usb_8dev
can_raw 17120 0
can 36503 1 can_raw

The device (ESD CAN-USB/2) is recognized when plugged in (dmesg output):

[ 1672.932148] usb 4-2: new full-speed USB device number 2 using uhci_hcd
[ 1673.100268] usb 4-2: New USB device found, idVendor=0ab4, idProduct=0001
[ 1673.100281] usb 4-2: New USB device strings: Mfr=4, Product=22,
SerialNumber=46
[ 1673.100289] usb 4-2: Product: CAN-USB 543
[ 1673.100296] usb 4-2: Manufacturer: esd-gmbh
[ 1673.100303] usb 4-2: SerialNumber: GL002971

Although there is no output indicating that the /sys/class/net/can0 node
is created, and there are no can# nodes under /sys/class/net.
I have confirmed that the virtual can bus works via the tutorial.

What am I missing?

Thanks,
Brian Gregory


