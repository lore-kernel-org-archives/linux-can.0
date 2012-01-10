From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH] Add PEAK System USB adapters core driver
Date: Tue, 10 Jan 2012 16:35:29 +0100
Message-ID: <4F0C5AC1.2070806@grandegger.com>
References: <871799.098418222-sendEmail@ubuntu-i386> <4F0C102D.5060304@grandegger.com> <4F0C57B9.2020204@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:54016 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756400Ab2AJPfb (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 Jan 2012 10:35:31 -0500
In-Reply-To: <4F0C57B9.2020204@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Stephane Grosjean <s.grosjean@peak-system.com>, Linux CAN mailing list <linux-can@vger.kernel.org>

On 01/10/2012 04:22 PM, Oliver Hartkopp wrote:
> On 10.01.2012 11:17, Wolfgang Grandegger wrote:
> 
>>>  drivers/net/can/usb/Kconfig                  |    1 +
>>>  drivers/net/can/usb/Makefile                 |    1 +
>>>  drivers/net/can/usb/peak_usb/Kconfig         |   19 +
>>>  drivers/net/can/usb/peak_usb/Makefile        |   10 +
>>>  drivers/net/can/usb/peak_usb/pcan_usb_core.c |  893 ++++++++++++++++++++++++++
>>>  drivers/net/can/usb/peak_usb/peak_usb.h      |  149 +++++
>>>  6 files changed, 1073 insertions(+), 0 deletions(-)
>>>  create mode 100644 drivers/net/can/usb/peak_usb/Kconfig
>>>  create mode 100644 drivers/net/can/usb/peak_usb/Makefile
>>>  create mode 100644 drivers/net/can/usb/peak_usb/pcan_usb_core.c
>>
>> Why not naming the file peak_usb.c? You already use "peak_usb" for the
>> header file as function prefix inside!
> 
> 
> AFAIR the driver built results in peak_usb.ko
> 
> And the driver contains the pcan_usb.c and pcan_usb_pro.c
> 
> If it's possible from the build process pcan_usb_core.c should be renamed to
> peak_usb.c - that's right.

We should remove the device specific Kconfigs including the related
#ifdefs. It's then *one* driver which always supports the two USB
devices. Anything else does not really make sense. Maybe just for very
low end devices where any byte counts. Have a look to other USB drivers.
They supports tons of devices without any #ifdef.

Wolfgang.

