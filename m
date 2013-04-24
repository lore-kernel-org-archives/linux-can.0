From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Usb to can driver
Date: Wed, 24 Apr 2013 19:40:23 +0200
Message-ID: <51781907.3030306@hartkopp.net>
References: <1366737302.3325.36.camel@blackbox>  <51770161.2030005@pengutronix.de> <1366818490.5965.35.camel@blackbox> <51780336.5060800@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:44338 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756224Ab3DXRk0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 24 Apr 2013 13:40:26 -0400
In-Reply-To: <51780336.5060800@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "Max S." <max@schneidersoft.net>, linux-can <linux-can@vger.kernel.org>

On 24.04.2013 18:07, Marc Kleine-Budde wrote:

> On 04/24/2013 05:48 PM, Max S. wrote:


>> The device can then tell how the host prefers its can frames formatted.
>> The idea is that the struct device_config holds enough data to allow the
>> device to construct a struct ss_host_frame in host format, including
>> padding & byte order.
> 
> Nice.
> 
>> since a struct ss_host_frame is simply a wrapper that includes a struct
>> can_frame, when a message arrives from the device, the host can copy the
>> struct can frame member without modification from the struct
>> ss_host_frame into the skb.
>>
>> assumptions that are made:
>> * The sizes of the struct can_frame members are id:u32 dlc:u8 data:u64 .
>> * It is also assumed that existing defines like CAN_EFF_FLAG in can.h
>> and can/error.h don't change, as they are used by the device to
>> construct the can_id field.
> 
> You cannot rely in your firmware, that the struct can_frame and
> CAN_*_FLAG doesn't change. Please define your own struct.
> 


Hm - i really appreciate the memcopy-only approach which can cope with the
host byte order directly. This is a real improvement on the host side.

The struct can_frame and the error message content is official Kernel API and
therefore can be assumed to be fix.

Btw. extensions like the introduction of the struct canfd_frame can always
take place. But this comes along with really new functionality then.

I would like to continue with the memcopy approach - but we probably need some
frame type identifier to be able to handle different host CAN frames, like
struct can_frame and struct canfd_frame, ...

Regards,
Oliver

