From: Daniel Squires <dan@engineeredarts.co.uk>
Subject: Re: socket can receive order
Date: Tue, 08 Sep 2015 12:17:20 +0100
Message-ID: <55EEC3C0.1010002@engineeredarts.co.uk>
References: <55EEAD8D.3070603@engineeredarts.co.uk> <55EEB217.3080706@pengutronix.de> <55EEBB4E.6080104@engineeredarts.co.uk> <55EEC2BD.6010302@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from engineeredarts.co.uk ([162.13.42.246]:58881 "EHLO
	mail.engineeredarts.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753254AbbIHLRZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Sep 2015 07:17:25 -0400
In-Reply-To: <55EEC2BD.6010302@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>



On 08/09/15 12:13, Marc Kleine-Budde wrote:
> On 09/08/2015 12:41 PM, Daniel Squires wrote:
>> On my laptop and Desktop PC I have not seen it happen.
>> Both the application PC (NUC) and the Laptop are running Ubuntu kernel
>> 3.19.0-26-generic
>>
>> The NUC has the kernel rebuilt without xhci due to problems it causes
>> with another USB peripheral.
>>
>> I am not entirely sure what you mean by which can core I am using but if
>> it helps i am opening the socket as follows :
> I mean what kind of CAN adapter...
>
>>       sock = socket(PF_CAN,SOCK_RAW,CAN_RAW);
>>
>> in a small standalone test application which I wrote after having
>> difficulty with our main application.
>>
>> I am using custom hardware/firmware and am using the kernel module found
>> here : https://github.com/fabiobaltieri/open-usb-can
>> though it has a small change to stop the net queue at the top of
>> open_usb_can_start_xmit as otherwise its prone to loosing TX packets
>> when loaded.
> Yes, this looks racy - You should ask then to mainline working the driver.
>
>> I can see the packets coming in the correct order in wireshark and it is
>> not immediately obvious to me how the kernel module could mix up the
>> order, so it seems that it must be something that happens at the socket
>> level?
> The kernel module "produces" the CAN frames, so if you see them in the
> correct order in wireshark, they have left the module in the right order.

Sorry , I should have been clearer here, in wireshark was looking at the 
USB frames not the CAN frames. however I think what you say still stands 
due to the time stamps being in the correct order.
>
>> candump can3 -tz
>> <snip>
>>    (003.088648)  can3  043   [8]  F7 2D 00 00 00 00 00 00
>>    (003.089149)  can3  045   [8]  F9 2D 00 00 00 00 00 00
>>    (003.088897)  can3  044   [8]  F8 2D 00 00 00 00 00 00
> The timestamps are in the correct order. Maybe Oliver can help here,
> he's an expert when it comes to strange reordering :)
>
>> On the top level I am using CANFestival for CANOpen implementation, so
>> it has occurred to me I could implement a CANFestival "driver" using
>> libusb and completely bypass the kernel module and socket can layers,
>> but I hope not to have to do this.
> Na, you don't want to do this.
>
> Marc

-- 
Dan Squires

Engineered Arts Ltd.

