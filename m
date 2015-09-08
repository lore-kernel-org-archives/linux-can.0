From: Daniel Squires <dan@engineeredarts.co.uk>
Subject: Re: socket can receive order
Date: Tue, 08 Sep 2015 12:37:33 +0100
Message-ID: <55EEC87D.3030000@engineeredarts.co.uk>
References: <55EEAD8D.3070603@engineeredarts.co.uk> <55EEB217.3080706@pengutronix.de> <55EEBB4E.6080104@engineeredarts.co.uk> <55EEC2BD.6010302@pengutronix.de> <55EEC3C0.1010002@engineeredarts.co.uk> <55EEC48A.6000705@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from engineeredarts.co.uk ([162.13.42.246]:59018 "EHLO
	mail.engineeredarts.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754142AbbIHLhg (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Sep 2015 07:37:36 -0400
In-Reply-To: <55EEC48A.6000705@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>



On 08/09/15 12:20, Marc Kleine-Budde wrote:
> On 09/08/2015 01:17 PM, Daniel Squires wrote:
>>> The kernel module "produces" the CAN frames, so if you see them in the
>>> correct order in wireshark, they have left the module in the right order.
>> Sorry , I should have been clearer here, in wireshark was looking at the
>> USB frames not the CAN frames. however I think what you say still stands
>> due to the time stamps being in the correct order.
> Thanks for the clarification. Can you have a look at the CAN interface
> with wireshark, too?
Wireshark shows the packets in the same order as candump, however it 
seems the timestamps are in the order wireshark got the packets, rather 
than when they were generated.

A couple of other observations, it seems to take longer for an out of 
order packet ot happen whilst wireshark is capturing, and on one 
occasion my application saw an out of order packet which candump showed 
as being in the correct order! This is a first and I wonder if is also 
related to wireshark also capturing.
> Marc
>

-- 
Dan Squires

Engineered Arts Ltd.

