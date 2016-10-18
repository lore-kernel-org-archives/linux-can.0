From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: About adding a new CAN-FD driver...
Date: Tue, 18 Oct 2016 09:15:20 +0200
Message-ID: <6d435ca7-dda2-5213-4fb1-bff663255746@hartkopp.net>
References: <d88756ae-0eb8-705d-e6a5-0e4532a8e28c@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p04-ob.smtp.rzone.de ([81.169.146.176]:21578 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933754AbcJRHPj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 18 Oct 2016 03:15:39 -0400
In-Reply-To: <d88756ae-0eb8-705d-e6a5-0e4532a8e28c@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello Stephane,

thanks for starting the uCAN support for the non-USB hardware types!

As a third alternative we cloud think about a common place to host 
include files that are needed by all drivers.

Looking into

	linux/include/linux/can/

there's dev.h which is needed by all drivers today.

In

	linux/include/linux/can/platform

there are the platform specific infos for some CAN controllers.

So we could place e.g. a peak_ucan.h in either

	linux/include/linux/can/
or
	linux/include/linux/can/dev/

At least this looks more clearly instead of creating unusual 
dependencies inside linux/drivers/net/can/

Any other opinions out there?

Regards,
Oliver


On 10/17/2016 11:42 AM, Stephane Grosjean wrote:
> Hello,
>
> We're planning to add a new driver under drivers/net/can that adds
> support to our PCAN-PCIe FD boards family.
>
> Before pushing any patches, I would first discuss about how and where to
> do that: all of our CAN-FD products actually embed some FPGA running the
> same µCode, internally called "uCAN core". So I first think to create a
> new sub-dir "drivers/net/can/ucan".
>
> But several months ago (Kernel v4.0), we already have pushed a driver
> for our USB CAN-FD adapters, so the new files have been obviously added
> under "driver/net/can/usb/peak_usb". Among these new files,
> "pcan_ucan.h" describes messages exchanged between host and uCAN core,
> whatever the PC interface is (USB, PCie...). So, I can imagine that the
> new driver for PCIe should include this file too, as well as some pieces
> of code present in "peak_usb_fd.c"...
>
> ASFAI, #include "../usb/peak_usb/pcan_ucan.h" is not the proper way to
> do this, isn't it?
>
> So, first of all, I would propose to push some patch(es) in order to
> make things cleaner:
>
> 1/ move file "pcan_ucan.h" from "drivers/net/can/usb/peak_usb" to the
> (newly created) "drivers/net/can/ucan"
>
> 2/ add the corresponding CFLAGS def into
> "drivers/net/can/usb/peak_usb/makefile":
>
> +CFLAGS_pcan_usb_fd.o        += -Idrivers/net/can/ucan
>
> is this the best approach, please?
>
> Thanks for your help.
>
> Stéphane
>
>
> --
> PEAK-System Technik GmbH
> Sitz der Gesellschaft Darmstadt - HRB 9183 Geschaeftsfuehrung: A.Gach,
> U.Wilhelm
> --
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
