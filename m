From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Hardware Loopback on RT-Socket-CAN Needed
Date: Thu, 17 Dec 2015 19:31:13 +0100
Message-ID: <5672FF71.3050509@grandegger.com>
References: <54DCF20AC6227B4FABAC7D71A5A1208F78E9068B@BLRKECMBX13.ad.infosys.com>
 <5672CA09.2050503@pengutronix.de> <5672D602.8070609@grandegger.com>
 <54DCF20AC6227B4FABAC7D71A5A1208F78E90747@BLRKECMBX13.ad.infosys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy02.manitu.net ([217.11.48.150]:60978 "EHLO
	mailproxy02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752529AbbLQSbQ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 17 Dec 2015 13:31:16 -0500
In-Reply-To: <54DCF20AC6227B4FABAC7D71A5A1208F78E90747@BLRKECMBX13.ad.infosys.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephen Marshall <Stephen_Marshall@infosys.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

Hi Stephen,

Am 17.12.2015 um 18:25 schrieb Stephen Marshall:
> Thanks for the quick response Marc and Wolfgang.
>
> What we basically need is a loopback message on the same socket after successful TX Done. We are not going with CAN_RAW_LOOPBACK because we have only one socket.

Well, in Linux it's always active. CAN_RAW_RECV_OWN_MSGS is an extension 
of that.

>
> Wolfgang,
> Could you confirm if I need to remove the "if" at https://git.xenomai.org/xenomai-2.6.git/tree/ksrc/drivers/can/rtcan_raw.c#n196 for what I am looking for?
>
> Is this how the code should look like?
>
> while (recv_listener != NULL) {
> 	dev->rx_count++;
> 	if (rtcan_accept_msg(frame->can_id, &recv_listener->can_filter)) // removed (dev->tx_socket != recv_listener->sock check)
>               {
> 	    recv_listener->match_count++;
> 	    rtcan_rcv_deliver(recv_listener, &dev->tx_skb);
> 	}
> 	recv_listener = recv_listener->next;
>      }

This is a *HACK* just to prove that it's doing the job. A proper 
implementation would include the support and handling of 
CAN_RAW_RECV_OWN_MSGS.

> Also, if I do the modification, should we continue to use CAN_CTRLMODE_LOOPBACK?

This does something different. Message loopback in hardware (on the 
controller). And it's also hardware dependent.

> Could you give us some reference on how to make the above modification at rtcan_raw.c file and build it? Sorry, a newbie here :)

Well, you already use Xenomai with RTCAN support, I assume. Then make 
the modifications and build as usual.

Wolfgang.

> Thanks,
> Stephen Marshall
>
>
> -----Original Message-----
> From: Wolfgang Grandegger [mailto:wg@grandegger.com]
> Sent: Thursday, December 17, 2015 9:04 PM
> To: Stephen Marshall; linux-can@vger.kernel.org
> Cc: Marc Kleine-Budde
> Subject: Re: Hardware Loopback on RT-Socket-CAN Needed
>
> Hello,
>
> for RT-CAN related questions the Xenomai ML is maybe more appropriate.
>
> Am 17.12.2015 um 15:43 schrieb Marc Kleine-Budde:
>> On 12/17/2015 03:13 PM, Stephen Marshall wrote:
>>> I am looking for some information on Loopback functionality for the
>>> RT-Socket-CAN.
>>
>> You mean RT-Socket-CAN as in Xenomai? This is, as far as i know dead.
>
> It's not dead! Just little contributions.
>
>>> In Socket-CAN, we used to test the loopback functionality on own
>>> socket using the flag *CAN_RAW_RECV_OWN_MSGS *using *MSG.CONFIRM*
>>> flag. However in RT-Socket CAN we see that this option has been disabled purposefully.
>
> Can't remember why it was not implemented. I think there was just no use-case,
>
> [snip]
>
>>> We use the SJA1000 CAN Controller and Xenomai 2.6. We tried setting
>>> the SRR (Self Reception Request) bit at driver using
>>> *CAN_CTRLMODE_LOOPBACK*
>>> <http://www.xenomai.org/documentation/xenomai-2.4/html/api/group__rtc
>>> an.html#ga19ec0cc4379e80c32cbd333cf7c145e9>*,
>
> Are you still using Xenommai 2.4?
>
>>> *however it was doing a software loopback where the looped back
>>> message would not have actually gone in the bus. We needed the
>>> CAN_RAW_RECV_OWN_MSGS fix at RT-Socket-CAN, could someone help?
>
> IIRC, on the SJA1000 the hw loopback is redirecting tx messages to the rx unit (in hardware) without sending something out to the bus,
>
> Have a look to:
>
>
> https://git.xenomai.org/xenomai-2.6.git/tree/ksrc/drivers/can/rtcan_raw.c#n196
>
> If you remove the "if" statement I think it already does what you want.
> But maybe I have missed something... it's a long time that I looked to that code.
>
> Wolfgang.
>
> **************** CAUTION - Disclaimer *****************
> This e-mail contains PRIVILEGED AND CONFIDENTIAL INFORMATION intended solely
> for the use of the addressee(s). If you are not the intended recipient, please
> notify the sender by e-mail and delete the original message. Further, you are not
> to copy, disclose, or distribute this e-mail or its contents to any other person and
> any such actions are unlawful. This e-mail may contain viruses. Infosys has taken
> every reasonable precaution to minimize this risk, but is not liable for any damage
> you may sustain as a result of any virus in this e-mail. You should carry out your
> own virus checks before opening the e-mail or attachment. Infosys reserves the
> right to monitor and review the content of all messages sent to or from this e-mail
> address. Messages sent to or from this e-mail address may be stored on the
> Infosys e-mail system.
> ***INFOSYS******** End of Disclaimer ********INFOSYS***
>
