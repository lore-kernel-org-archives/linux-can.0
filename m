From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 3/5] can: Kconfig: switch on CAN_RAW by default
Date: Fri, 30 Nov 2012 18:02:34 +0100
Message-ID: <50B8E6AA.4090209@hartkopp.net>
References: <1354197491-31205-1-git-send-email-mkl@pengutronix.de> <1354197491-31205-4-git-send-email-mkl@pengutronix.de> <50B85681.8030502@hartkopp.net> <50B86BF9.6020202@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:12783 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758785Ab2K3RCh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 30 Nov 2012 12:02:37 -0500
In-Reply-To: <50B86BF9.6020202@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

On 30.11.2012 09:19, Marc Kleine-Budde wrote:

> On 11/30/2012 07:47 AM, Oliver Hartkopp wrote:
>> On 29.11.2012 14:58, Marc Kleine-Budde wrote:
>>
>>> As CAN_RAW is the basic CAN protocol, switch it on by default.
>>>
>>
>>
>> Hello Marc,
>>
>> you are probably right, that most users will at least need CAN_RAW sockets.
>> But i asked myself, what the Linux distributions will do once we point out
>> that a specific protocol is *preferred* to be enabled?
> 
> I hope they enable it by default. However CAN_RAW will be only switched
> on, if CAN support is enabled.
> 

Yes, if CAN support is enabled.

The problem is that when it's enabled - what to select then?

IMO all entries (RAW/BCM/GW) should be enabled by default when CAN is
selected. When people really know what they do, the might deselect entries at
their own risc ...

Regards,
Oliver
