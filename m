From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH] Add PEAK System USB adapters core driver
Date: Wed, 11 Jan 2012 13:28:29 +0100
Message-ID: <4F0D806D.4090003@grandegger.com>
References: <871799.098418222-sendEmail@ubuntu-i386> <4F0C102D.5060304@grandegger.com> <4F0C57B9.2020204@hartkopp.net> <4F0C5AC1.2070806@grandegger.com> <4F0D5529.7020208@peak-system.com> <4F0D5B5C.2040205@pengutronix.de> <4F0D6076.3070101@grandegger.com> <4F0D648D.5030706@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:49640 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753588Ab2AKM2i (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Jan 2012 07:28:38 -0500
In-Reply-To: <4F0D648D.5030706@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, s.grosjean@peak-system.com, Linux CAN mailing list <linux-can@vger.kernel.org>

On 01/11/2012 11:29 AM, Oliver Hartkopp wrote:
> On 11.01.2012 11:12, Wolfgang Grandegger wrote:
> 
>> On 01/11/2012 10:50 AM, Marc Kleine-Budde wrote:
>>> On 01/11/2012 10:23 AM, Grosjean Stephane wrote:
> 
>>> Documentation/kbuild/makefiles.txt has this example:
>>>
>>> 	obj-$(CONFIG_EXT2_FS) += ext2.o
>>> 	ext2-y := balloc.o dir.o file.o ialloc.o inode.o ioctl.o \
>>> 		namei.o super.o symlink.o
>>> 	ext2-$(CONFIG_EXT2_FS_XATTR) += xattr.o xattr_user.o \
>>> 		xattr_trusted.o
>>>
>>> Which translates into (untested, though):
>>>
>>> 	obj-$(CONFIG_CAN_PEAK_USB) += peak_usb.o
>>> 	peak_usb-y := peak_usb_core.o pcan_usb.o pcan_usb_pro.o
>>>
>>> With a peak_usb_core.c file.
>>
>> I suggested to use peak_usb.c (instead of pcan_core.c) to have a
>> consistent naming (header file and prefix). This seems not to be
>> possible. I was not aware of that. Naming the files peak_usb_core.c and
>> peak_usb_core.h seems a good alternative.
> 
> 
> 
> pcan is the adapter model name and peak is the manufacturer name.
> 
> Then i would suggest to name all building source files with pcan_*
> 
> like:
> 
> pcan_usb_core.c
> pcan_usb_core.h
> pcan_usb.c
> pcan_usb_pro.c
> 
> resulting in a peak_usb.ko

I don't care about the name but it should be used consistently, for the
sake of readability.

Wolfgang.
