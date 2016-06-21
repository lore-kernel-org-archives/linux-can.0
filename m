From: ajneu <ajneu1@gmail.com>
Subject: Re: Kernel Oops with: ip link set can0 type can
Date: Tue, 21 Jun 2016 08:55:34 +0000 (UTC)
Message-ID: <loom.20160621T105023-651@post.gmane.org>
References: <loom.20160621T095606-63@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:37840 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751979AbcFUI4G (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 21 Jun 2016 04:56:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1bFHTW-0002GA-NK
	for linux-can@vger.kernel.org; Tue, 21 Jun 2016 10:56:02 +0200
Received: from 195.50.142.51 ([195.50.142.51])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 21 Jun 2016 10:56:02 +0200
Received: from ajneu1 by 195.50.142.51 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 21 Jun 2016 10:56:02 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

ajneu <ajneu1 <at> gmail.com> writes:

> 
> Hi,
> 
> issuing the command
>    sudo ip link set can0 type can
> I get Kernel Oops (NULL pointer dereference)
> Command line prints: "Killed".
> 
> [...]
>
> dmesg shows
> [...]


Question: 
How should one add and set a can device???


If I reboot, then
udev detects my Peak USB Adapter.

Command:
   ip link show can0
=>
  4: can0: <NOARP,ECHO> mtu 16 qdisc noop state DOWN mode DEFAULT group
default qlen 10
      link/can

This device was (somehow?) loaded via udev.
Command:
   udevadm info -p /sys/class/net/can0
   udevadm info -p /sys/class/net/can0 --attribute-walk


Now let's delete can0:
   sudo ip link delete can0
   ip link show can0
=>
   Device "can0" does not exist.

Now let's add can0 as type can:
   sudo ip link add can0 type can
=>
Killed

Damn!!!! Kernel Oops!!!!!!
(dmesg shows a similar output as before.)


So repeating question:
How should one add and set a can device???

How does udev do it? (How can one figure out how udev does it?)

Thanks.

