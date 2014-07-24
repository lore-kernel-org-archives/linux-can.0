From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: C_CAN: can frame drops
Date: Thu, 24 Jul 2014 20:09:43 +0200
Message-ID: <53D14BE7.6030007@hartkopp.net>
References: <BAY176-W240BDB3FFF425370BF5B47D3FE0@phx.gbl>,<53CFDD24.3070004@hartkopp.net>,<BAY176-W16B4D19E7BD30B2503C3AFD3FE0@phx.gbl> <BAY176-W506BABD46D0A520B9C1C52D3FF0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:23901 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932742AbaGXSJu (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 24 Jul 2014 14:09:50 -0400
In-Reply-To: <BAY176-W506BABD46D0A520B9C1C52D3FF0@phx.gbl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ssagarr Patil <hugarsagar@outlook.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Sagar,

unfortunately I'm not really a C_CAN expert.

I know from a Beaglebone Black which run's at 99% busload without any issues
on the two integrated D_CAN controllers.

Do you have these problems with a stock 2.6.37.x on your hardware too?

Can you send the dmesg output of the c_can related content?

Regards,
Oliver

On 24.07.2014 09:40, Ssagarr Patil wrote:
>> Hi Oliver,
>>
>> Thanks for your response :-)
>>
>>>
>>> generally dropping CAN frames on driver level is a complete different problem
>>> in opposite to dropping CAN frames on socket receive level.
>>>
>> Agreed.
>>
>>> A drop on the socket layer usually occurs, when the application does not get
>>> enough CPU time to read and process the CAN frames. But drops on CAN driver
>>> layer lead to a possible resource problem on your system.
>>>
>> For the application layer I have used chrt so that it gets higher priority.
>>
>>> Can you tell a bit more about your platform (hardware, CPU, cpu clock, RAM)
>>> and Linux Kernel version?
>>>
>> The Linux version is 2.6.37 where as I have patched this kernel to use the v3.15
>> C_CAN driver(which uses D_CAN) to use.
>>
>> Hardware is DM8148 EVM, ARM clock is @1000Mhz, DDR @533Mhz,
> 
> BTW I also tried it on AM335x with the v3.16-rc5 which supports D_CAN
> the problem is the same.
> 
> Thanks,
> --Sagar
> 
>>
>> Regards,
>> --Sagar
>>
>>> Regards,
>>> Oliver
>>>
>>>
>>> On 23.07.2014 16:48, Ssagarr Patil wrote:
>>>> Hi,
>>>>
>>>> I am using the c_can driver for latest kernel and using the latest canutils to dump to a file.
>>>> My can bus is set at a rate of 1Mb (receiving 7000fps bus load of 80%).
>>>>
>>>> When I use the candump tool to dump can frames I get following message,
>>>>
>>>> 'DROPCOUNT: dropped 2223 CAN frames on 'any' socket (total drops 1629092)'
>>>>
>>>> SO to solve this problem if I use the -r option of candump and tried
>>>> candump any -d -e -r 999999999 -l
>>>>
>>>> If I do this the can frames are dropped in the driver ie I see
>>>> this c_can_handle_lost_msg_obj() function being called frequently in which can frame
>>>> is overwritten.
>>>>
>>>> How to solve this issue any pointers would be helpful.
>>>>
>>>> Thanks,
>>>> --Sagar
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-can" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-can" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>
>  		 	   		  
> 
