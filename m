From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: ip -details link fails
Date: Wed, 27 May 2015 19:06:22 +0200
Message-ID: <5565F98E.5010101@hartkopp.net>
References: <BAY176-W131B8CC6A9756B64828C77D3CB0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:11505 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753294AbbE0RG3 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 27 May 2015 13:06:29 -0400
In-Reply-To: <BAY176-W131B8CC6A9756B64828C77D3CB0@phx.gbl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ssagarr Patil <hugarsagar@outlook.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 05/27/2015 06:38 PM, Ssagarr Patil wrote:
> I am currently using the following version of can driver 
> # cat /proc/net/can/version
> rev 20120528 abi 9
> 

This is network layer stuff.
It does not tell you anything about CAN network interfaces.

> But when I do the following it fails,
> 
> # ip -details link show can0
> RTNETLINK answers: Invalid argument
> Cannot send link get request: Invalid argument
> 
> Transmitting and reciving of can frames works.

Oh.

I assume you use a CAN driver with is not in Linux mainline, e.g. the PEAK
driver. The PEAK driver is configured differently (see its documentation).

Can you send the output of

	cat /proc/net/dev

	uname -a

	dmesg | grep -C 5 can0

Regards,
Oliver


> 
> I want to get the current bitrate of the CAN interface using the above command,
> can anyone point me to what exactly is missing ? Or is there any alternative to get
> the current bitrate of the CAN interface (ioctl/ sysfs entry..)
> 
> Thanks,
> Sagar
>  		 	   		  --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
