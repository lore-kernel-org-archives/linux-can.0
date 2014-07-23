From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: C_CAN: can frame drops
Date: Wed, 23 Jul 2014 18:04:52 +0200
Message-ID: <53CFDD24.3070004@hartkopp.net>
References: <BAY176-W240BDB3FFF425370BF5B47D3FE0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:21610 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756875AbaGWQE7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 23 Jul 2014 12:04:59 -0400
In-Reply-To: <BAY176-W240BDB3FFF425370BF5B47D3FE0@phx.gbl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ssagarr Patil <hugarsagar@outlook.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello Sagar,

generally dropping CAN frames on driver level is a complete different problem
in opposite to dropping CAN frames on socket receive level.

A drop on the socket layer usually occurs, when the application does not get
enough CPU time to read and process the CAN frames. But drops on CAN driver
layer lead to a possible resource problem on your system.

Can you tell a bit more about your platform (hardware, CPU, cpu clock, RAM)
and Linux Kernel version?

Regards,
Oliver


On 23.07.2014 16:48, Ssagarr Patil wrote:
> Hi,
> 
> I am using the c_can driver for latest kernel and using the latest canutils to dump to a file.
> My can bus is set at a rate of 1Mb (receiving 7000fps bus load of 80%).
> 
> When I use the candump tool to dump can frames I get following message,
> 
> 'DROPCOUNT: dropped 2223 CAN frames on 'any' socket (total drops 1629092)'
> 
> SO to solve this problem if I use the -r option of candump and tried 
> candump any -d -e -r 999999999 -l
> 
> If I do this the can frames are dropped in the driver ie I see 
> this c_can_handle_lost_msg_obj() function being called frequently in which can frame
> is overwritten.
> 
> How to solve this issue any pointers would be helpful.
> 
> Thanks,
> --Sagar
>  		 	   		  --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
