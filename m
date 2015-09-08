From: Daniel Squires <dan@engineeredarts.co.uk>
Subject: Re: socket can receive order
Date: Tue, 08 Sep 2015 12:49:52 +0100
Message-ID: <55EECB60.2090602@engineeredarts.co.uk>
References: <55EEAD8D.3070603@engineeredarts.co.uk> <55EEB217.3080706@pengutronix.de> <55EEBB4E.6080104@engineeredarts.co.uk> <55EEC2BD.6010302@pengutronix.de> <55EECAAE.1020901@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from engineeredarts.co.uk ([162.13.42.246]:59095 "EHLO
	mail.engineeredarts.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754306AbbIHLtz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Sep 2015 07:49:55 -0400
In-Reply-To: <55EECAAE.1020901@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>

Whilst I am using the kernel module of that project at present, the 
firmware and hardware are not from that project, but instead based 
around an STM32 MCU.


On 08/09/15 12:46, Wolfgang Grandegger wrote:
>
>
> Am 08.09.2015 um 13:13 schrieb Marc Kleine-Budde:
>> On 09/08/2015 12:41 PM, Daniel Squires wrote:
>>> On my laptop and Desktop PC I have not seen it happen.
>>
>>> Both the application PC (NUC) and the Laptop are running Ubuntu kernel
>>> 3.19.0-26-generic
>>>
>>> The NUC has the kernel rebuilt without xhci due to problems it causes
>>> with another USB peripheral.
>>>
>>> I am not entirely sure what you mean by which can core I am using 
>>> but if
>>> it helps i am opening the socket as follows :
>>
>> I mean what kind of CAN adapter...
>
> "https://github.com/fabiobaltieri/open-usb-can" seems to use a MCP2515 
> controller.
>
> Wolfgang.
>

-- 
Dan Squires

Engineered Arts Ltd.

