From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: ip -details link fails
Date: Thu, 28 May 2015 17:42:18 +0200
Message-ID: <5567375A.404@hartkopp.net>
References: <BAY176-W131B8CC6A9756B64828C77D3CB0@phx.gbl>,<5565F98E.5010101@hartkopp.net>,<BAY176-W119C53753111D23AE6FA39D3CB0@phx.gbl> <5565FDE5.1040908@hartkopp.net>,<55661810.3050407@pengutronix.de> <BAY176-W52B59690F5605C23AA3A3D3CA0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:19717 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754138AbbE1Pm2 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 28 May 2015 11:42:28 -0400
In-Reply-To: <BAY176-W52B59690F5605C23AA3A3D3CA0@phx.gbl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ssagarr Patil <hugarsagar@outlook.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>



On 28.05.2015 11:48, Ssagarr Patil wrote:
> Hi Oliver,
>
>>
>> On 05/27/2015 07:24 PM, Oliver Hartkopp wrote:
>>>> # ip -details link show wlan0
>>>> RTNETLINK answers: Invalid argument
>>>> Cannot send link get request: Invalid argument
>>>
>>> The fact that your 'ip' tool doesn't work with wlan0 too your problem is
>>> probably not CAN related.
>>
>> BTW: the busybox version of ip doesn't talk can.
>>
> I am not using the ip from the busybox,
> I am using the release version from [1] (# ip -V
> ip utility, iproute2-ss150413)
>

Looks good.

>
> # ip -details link show can0
> RTNETLINK answers: Invalid argument
> Cannot send link get request: Invalid argument
> #
>


>
> [1] https://www.kernel.org/pub/linux/utils/net/iproute2/
>
> Or is that I am missing something in the kernel defconfig do I need to enable some via
> doing menuconfig to get it working

Hm.

Can you post the output of

	strace ip -details link show can0

Maybe there"s really something missing in the kernel config to run the netlink 
configuration.

Regards,
Oliver

