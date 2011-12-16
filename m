From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: "[PATCH] Add support for PEAK-System GmbH CAN USB adapters (v2)
 "
Date: Fri, 16 Dec 2011 12:34:14 +0100
Message-ID: <4EEB2CB6.9000005@grandegger.com>
References: <301939.630738588-sendEmail@ubuntu-i386>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:58576 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113Ab1LPLeR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 16 Dec 2011 06:34:17 -0500
In-Reply-To: <301939.630738588-sendEmail@ubuntu-i386>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "s.grosjean@peak-system.com" <s.grosjean@peak-system.com>
Cc: "socketcan@hartkopp.net" <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 12/16/2011 11:19 AM, s.grosjean@peak-system.com wrote:
>>From 1cee3be3875f27a2ee3942b00d611450f4369325 Mon Sep 17 00:00:00 2001
> From: Stephane Grosjean <s.grosjean@peak-system.com>
> Date: Fri, 16 Dec 2011 11:11:37 +0100
> Subject: [PATCH] Add support for PEAK-System GmbH CAN USB adapters (v2)

Please be more verbose in the commit message, e.g. what adapters does it
support.

> v2 includes:
>  change dev_xxx() into netdev_xxx() macros
>  add missing include linux/module.h
>  pre-allocate urbs and buffers for tx path at _open() and free them at _close()
>   rather than into _start_xmit()
>  remove some unused code and (boring) #ifdef/#endif
>  use "menuconfig" in Kconfig rather than "config" entry

Please put the "v2 includes" below "---" as it should not be part of the
commit message.

> ---
>  drivers/net/can/usb/Kconfig         |   20 +
>  drivers/net/can/usb/Makefile        |   12 +
>  drivers/net/can/usb/pcan_usb.c      |  654 +++++++++++++++++++
>  drivers/net/can/usb/pcan_usb_core.c |  895 ++++++++++++++++++++++++++
>  drivers/net/can/usb/pcan_usb_pro.c  | 1207 +++++++++++++++++++++++++++++++++++
>  drivers/net/can/usb/pcan_usb_pro.h  |  468 ++++++++++++++
>  drivers/net/can/usb/peak_usb.h      |  148 +++++

More than three files for this driver(s) ==> use a separate sub-directory?

Would it make sense to split this patch in

  core.patch
  adaper1.patch,
  adaper2.patch?

Unfortunately, checkpatch.pl does report many issues, e.g., lines too
long, white space issues, ... It's also unusual to use very long
variable and macro names. Please shorten, also to avoid long lines.
Furthermore I realized switch statements with many cases. Wouldn't a
jump table be more efficient?

Thanks,

Wolfgang.
