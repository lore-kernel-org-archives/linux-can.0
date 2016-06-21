From: ajneu <ajneu1@gmail.com>
Subject: Re: Kernel Oops with: ip link set can0 type can
Date: Tue, 21 Jun 2016 12:25:56 +0000 (UTC)
Message-ID: <loom.20160621T142101-867@post.gmane.org>
References: <loom.20160621T095606-63@post.gmane.org> <loom.20160621T105023-651@post.gmane.org> <53a1d68d-6267-e3fc-af7d-ba4d49f8124a@hartkopp.net> <d9d3c57a-1c47-2220-7b09-40b46966c80a@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:33151 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750906AbcFUMn6 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 21 Jun 2016 08:43:58 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1bFKkq-0008LW-So
	for linux-can@vger.kernel.org; Tue, 21 Jun 2016 14:26:09 +0200
Received: from 195.50.142.51 ([195.50.142.51])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 21 Jun 2016 14:26:08 +0200
Received: from ajneu1 by 195.50.142.51 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 21 Jun 2016 14:26:08 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Oliver Hartkopp <socketcan <at> hartkopp.net> writes:

> 
> 
> On 06/21/2016 11:17 AM, Oliver Hartkopp wrote:
> > On 06/21/2016 10:55 AM, ajneu wrote:
> >> ajneu <ajneu1 <at> gmail.com> writes:
> >>
> >>>
> >>> Hi,
> >>>
> >>> issuing the command
> >>>    sudo ip link set can0 type can
> >>> I get Kernel Oops (NULL pointer dereference)
> 
> > But the OOPS should no occur due to your ip usage anyway 
> > This has to be fixed ...
> 
> Can you please check whether my posted patch fixes your problem?
> 
> http://marc.info/?l=linux-can&m=146650412017263&w=2
> 
> I tested it myself with success.
> 
> Thanks for catching this issue!
> 
> Regards,
> Oliver
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


Hi Oliver,

thanks for the patch.

I unloaded the old driver, and loaded yours with the patch as follows:
   lsmod | grep can
   sudo rmmod peak_usb # I had to remove this first, since issuing 
                       #   sudo rmmod vcan 
                       # showed
                       # ERROR: Module can_dev is in use by: peak_usb
   sudo rmmod can_dev
   lsmod | grep can
   sudo insmod drivers/net/can/can-dev.ko
   sudo insmod drivers/net/can/usb/peak_usb/peak_usb.ko



Then I tested the command:
  sudo ip link set can0 type can       ## working!

  sudo ip link add can0 type can       ## working!
   => RTNETLINK answers: File exists

~~>So far so good. Good till here.



Then I tested SOME MORE:
  sudo ip link delete can0   ## also removes /sys/class/net/can0

  sudo ip link add can0 type can       ## hmmmm?
   => RTNETLINK answers: Operation not supported

~~>Is this still ok?



Directly after this I managed to provoke a bug:
 I pulled out the Peak USB Adapter, and the computer computer HANGS!!!!
~~>NOTHINGS WORKS. Absolutely nothing. No mouse. No keyboard.

This bug is therefore:
Calling
   sudo ip link delete can0
while the Peak USB Adapter is still plugged in,
and THEN disconnecting the Peak USB Adapter.


Regards,
ajneu



PS:
Note to self -- how to apply Oliver's patch and unload load can kernel modules

## this is under Debian (stretch)
## (I'm currently using Kernel 4.6)
sudo aptitude install build-essential
sudo aptitude install linux-source
mkdir ~/kernel
cd    ~/kernel
tar xf /usr/src/linux-source-4.6.tar.xz
cd ~/kernel/linux-source*
cp /boot/config-4.6.0-1-amd64                          .config
cp /usr/src/linux-headers-4.6.0-1-amd64/Module.symvers .
make prepare
make modules_prepare
make SUBDIRS=scripts/mod
make SUBDIRS=drivers/net/can modules

## perform patch and then recompile with:

make SUBDIRS=drivers/net/can modules

## Then unload old and insert new driver
## (as already shown at beginning of this message)
lsmod | grep can
sudo rmmod peak_usb # I had to remove this first, since issuing 
                    #   sudo rmmod vcan 
                    # showed
                    # ERROR: Module can_dev is in use by: peak_usb
sudo rmmod can_dev
lsmod | grep can
sudo insmod drivers/net/can/can-dev.ko
sudo insmod drivers/net/can/usb/peak_usb/peak_usb.ko

