From: "Max S." <max@schneidersoft.net>
Subject: Re: Usb to can driver
Date: Thu, 25 Apr 2013 23:35:04 +0000
Message-ID: <1366932904.3307.23.camel@blackbox>
References: <1366737302.3325.36.camel@blackbox>
	  <51770161.2030005@pengutronix.de> <1366818490.5965.35.camel@blackbox>
	 <51780336.5060800@pengutronix.de> <51781907.3030306@hartkopp.net>
	 <51784D96.8000309@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.schneidersoft.net ([173.45.248.65]:59067 "EHLO
	mail.schneidersoft.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757640Ab3DYXaN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 25 Apr 2013 19:30:13 -0400
Received: from [192.168.1.13] (unknown [177.119.176.253])
	by mail.schneidersoft.net (Postfix) with ESMTPSA id D83341A17D
	for <linux-can@vger.kernel.org>; Thu, 25 Apr 2013 18:29:50 -0500 (CDT)
In-Reply-To: <51784D96.8000309@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>

On Wed, 2013-04-24 at 23:24 +0200, Marc Kleine-Budde wrote:
> On 04/24/2013 07:40 PM, Oliver Hartkopp wrote:
> >>> assumptions that are made:
> >>> * The sizes of the struct can_frame members are id:u32 dlc:u8 data:u64 .
> >>> * It is also assumed that existing defines like CAN_EFF_FLAG in can.h
> >>> and can/error.h don't change, as they are used by the device to
> >>> construct the can_id field.
> >>
> >> You cannot rely in your firmware, that the struct can_frame and
> >> CAN_*_FLAG doesn't change. Please define your own struct.
> >>
> > 
> > 
> > Hm - i really appreciate the memcopy-only approach which can cope with the
> > host byte order directly. This is a real improvement on the host side.
> > 
> > The struct can_frame and the error message content is official Kernel API and
> > therefore can be assumed to be fix.
> 
> Yes but no. The struct can_frame to the _userspace_ is official Kernel
> API/ABI, but within the kernel the is no stable API (see
> stable_api_nonsense.txt). But if we go this way we should make compile
> time checks, so that the compilation breaks if the struct can_frame changes.

ok. tell me if i understood correctly.
A user-space program can safely assume:
sizeof((struct can_frame *)NULL)->can_id) == 4
and:
CAN_EFF_FLAG == 0x80000000U 

but a kernel-space driver can not?

If I cannot make sufficient assumptions about the struct can_frame and
CAN_*_FLAGs It will make the code harder to maintain in the long run.
the speed gains derived from a direct memcpy/assignment will later be
eaten up by the code designed to convert the old struct can_frame
received from the device to the new struct can_frame found in the
kernel.

The question is in the end, where should i draw the line.

One option would be to define a new struct ss_frame to standardize
communication between device & host, but still use the device_config to
allow the changing of byte order.
The driver would then need to do three assignments to rearrange padding,
and adjust any difference in the id flags:

* arrange for correct byte order beforehand...

can_frame->can_id  = CONVERT_ME_FLAGS(ss_frame->can_id);
can_frame->can_dlc = ss_frame->can_dlc;
can_frame->data    = ss_frame->data;

In this case the 'line' would be explicitly between the struct ss_frame
and the struct can_frame not floating somewhere vague between the kernel
and firmware...
Naturally you will no longer be able to simply:
*can_frame = frame_wrapper->can_frame;
As i am doing now.

What do you think?
Max Schneider.


