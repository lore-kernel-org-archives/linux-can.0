From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: how to check if can0 is up
Date: Wed, 06 May 2015 17:28:07 +0200
Message-ID: <554A3307.8070409@hartkopp.net>
References: <5547C40E.9050107@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:21108 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752931AbbEFP2K (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 6 May 2015 11:28:10 -0400
In-Reply-To: <5547C40E.9050107@arcor.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: vklein <vk4514@arcor.de>, linux-can@vger.kernel.org

Hi Victor,

On 05/04/2015 09:10 PM, vklein wrote:

> I want to test the status of can0 on a BeagleBoneBlack with serial-can cape
> from Logic Supply.
> 
> The interface is initialized with
> ip link set can0 type can bitrate 250000
> ifconfig can0 up

Good.

> I have tried
> cat /sys/class/net/can0/operstate
> but this does not work correctly
> 
> if can0 is down,  I get "down"
> 
> if can0 is up , I get "unknown"

The question is whether operstate is always set correctly ...

> ifconfig says:
> can0      Link encap:UNSPEC  HWaddr
> 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
>           UP RUNNING NOARP  MTU:16  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:10
>           RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
>           Interrupt:55
> 

What does

	ip -det link show can0

tell you?

Using the 'ip' tool is recommended to get the device state.

Maybe the setting of the operstate in sysfs has to be fixed ?!?

Regards,
Oliver

