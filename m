From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Is there any way of getting the CAN interfaces list, from any
 C program?
Date: Thu, 25 Apr 2013 09:43:20 +0200
Message-ID: <5178DE98.7040408@grandegger.com>
References: <5169B395.2070703@hartkopp.net> <516D2ABB.4000300@pengutronix.de> <5177A090.6010904@peak-system.com> <20130424144929.GA2077@vandijck-laurijssen.be> <5178D00C.70507@grandegger.com> <20130425072429.GA448@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:54055 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754872Ab3DYHnY (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 25 Apr 2013 03:43:24 -0400
In-Reply-To: <20130425072429.GA448@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 04/25/2013 09:24 AM, Kurt Van Dijck wrote:
> On Thu, Apr 25, 2013 at 08:41:16AM +0200, Wolfgang Grandegger wrote:
>> Hi Kurt,
>>
>> On 04/24/2013 04:49 PM, Kurt Van Dijck wrote:
>>> Hi Stephane,
>>>
>>> I have written this some time ago, not using it actually.
>>> I tried a modular approach, don't know if its usefull.
>>>
>>> PS: I used attachments.
>>
>> ~/enumif$ ./enumif
>> 1: lo	{loopback} <LOOPBACK,UP,LOWER_UP> UNKNOWN
>> 2: eth0	{ether} <BROADCAST,MULTICAST> DOWN
>> 3: eth1	{ether} <BROADCAST,MULTICAST,UP,LOWER_UP> UNKNOWN
>> 4: eth3	{ether} <NO-CARRIER,BROADCAST,MULTICAST,UP> DOWN
>> 5: can0	{can} <NOARP,UP,LOWER_UP,ECHO> UNKNOWN
>> 6: can1	{can} <NOARP,ECHO> DOWN
>> 7: can2	{can} <NOARP,ECHO> DOWN
>> 8: can3	{can} <NOARP,ECHO> DOWN
>> 9: pan0	{ether} <BROADCAST,MULTICAST> DOWN
>>
>> Cool! We know that "ip link" does list all network interfaces but the
>> code doing the job is not really strength-forward. I think this would be
>> a nice enhancement of the can-utils.
> 
> would it make sense to maintain the split into enumif-test.c and enumif.c,
> so for example Stephane could just link to libenumif.a?

Well, a better place might be libsocketcan then. In general it would be
nice to host libsocketcan (maybe as liblinuxcan) at
https://gitorious.org/linux-can as well.

Wolfgang.
