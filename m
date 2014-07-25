From: Ssagarr Patil <hugarsagar@outlook.com>
Subject: RE: C_CAN: can frame drops
Date: Fri, 25 Jul 2014 14:05:48 +0530
Message-ID: <BAY176-W40C40CD192EBD241673159D3FC0@phx.gbl>
References: <BAY176-W240BDB3FFF425370BF5B47D3FE0@phx.gbl>,<53D204A4.1060502@pengutronix.de>
 <BAY176-W4D41B1290DE5D3B2BD6D0D3FC0@phx.gbl>,<53D2126C.40600@pengutronix.de>
 <BAY176-W426E5C1C47CA0379DFCD84D3FC0@phx.gbl>,<53D214E2.7020205@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from [65.54.190.203] ([65.54.190.203]:60835 "EHLO
	BAY004-OMC4S1.hotmail.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1759774AbaGYIgI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 25 Jul 2014 04:36:08 -0400
In-Reply-To: <53D214E2.7020205@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Marc,

Thanks for the response!
>
> On 07/25/2014 10:22 AM, Ssagarr Patil wrote:
>> Hi Marc,
>>
>>>
>>> On 07/25/2014 10:13 AM, Ssagarr Patil wrote:
>>>>>> I am using the c_can driver for latest kernel and using the latest canutils to dump to a file.
>>>>>> My can bus is set at a rate of 1Mb (receiving 7000fps bus load of 80%).
>>>>>>
>>>>>> When I use the candump tool to dump can frames I get following message,
>>>>>>
>>>>>> 'DROPCOUNT: dropped 2223 CAN frames on 'any' socket (total drops 1629092)'
>>>>>
>>>>> These are the CAN frames dropped by the socket, this means as Oliver
>>>>> pointed out, that the candump fails to read the CAN frames fast enough
>>>>> from the socket. How do you connect to the linux box with the c_can?
>>>>> Where are the CAN frames printed to?
>>>>>
>>>> Agreed this is dropped by the socket, so for this to solve I increased the socket size
>>>> (with -r option of candump to 111173056) after doing this I see that there is frame drop in
>>>> the driver ie I see this function c_can_handle_lost_msg_obj() being called frequently in which
>>>> can frame is overwritten.
>>>>
>>>> I have a can frame generator which I have connected to the EVM, the EVM is recieving the
>>>> frames and just dumping it on stdout going ahead I need to log the canframes to SD card.
>>>
>>> ...and where is your stdout going? serial line, telnet, ssh?
>>>
>> Its the serial line.
>
> That's not good. As printing to the serial console is quite costly.
>
Yes agreed, although I also see some frame drops pointed by ifconfig can0
when dumping it to file (with -l option of candump)
I have also used chrt to increase the priority of candump.

Any suggestion on how to still improve the performance so as there is zero frame loss ?
either on driver or application side.

Thanks,
--Sagar
 		 	   		  