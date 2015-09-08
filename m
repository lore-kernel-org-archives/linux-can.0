From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: socket can receive order
Date: Tue, 8 Sep 2015 13:46:54 +0200
Message-ID: <55EECAAE.1020901@grandegger.com>
References: <55EEAD8D.3070603@engineeredarts.co.uk>
 <55EEB217.3080706@pengutronix.de> <55EEBB4E.6080104@engineeredarts.co.uk>
 <55EEC2BD.6010302@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy.manitu.net ([217.11.48.140]:42116 "EHLO
	mailproxy01.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753470AbbIHLx3 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Sep 2015 07:53:29 -0400
In-Reply-To: <55EEC2BD.6010302@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Daniel Squires <dan@engineeredarts.co.uk>, linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>



Am 08.09.2015 um 13:13 schrieb Marc Kleine-Budde:
> On 09/08/2015 12:41 PM, Daniel Squires wrote:
>> On my laptop and Desktop PC I have not seen it happen.
>
>> Both the application PC (NUC) and the Laptop are running Ubuntu kernel
>> 3.19.0-26-generic
>>
>> The NUC has the kernel rebuilt without xhci due to problems it causes
>> with another USB peripheral.
>>
>> I am not entirely sure what you mean by which can core I am using but if
>> it helps i am opening the socket as follows :
>
> I mean what kind of CAN adapter...

"https://github.com/fabiobaltieri/open-usb-can" seems to use a MCP2515 
controller.

Wolfgang.
