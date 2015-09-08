From: Daniel Squires <dan@engineeredarts.co.uk>
Subject: Re: socket can receive order
Date: Tue, 08 Sep 2015 11:41:18 +0100
Message-ID: <55EEBB4E.6080104@engineeredarts.co.uk>
References: <55EEAD8D.3070603@engineeredarts.co.uk> <55EEB217.3080706@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from engineeredarts.co.uk ([162.13.42.246]:58551 "EHLO
	mail.engineeredarts.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754665AbbIHKlV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Sep 2015 06:41:21 -0400
In-Reply-To: <55EEB217.3080706@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

Hi Marc,

I should have mentioned that this "issue" seems to only show up on our 
application PC, (which is an Intel NUC).

On my laptop and Desktop PC I have not seen it happen.

Both the application PC (NUC) and the Laptop are running Ubuntu kernel 
3.19.0-26-generic

The NUC has the kernel rebuilt without xhci due to problems it causes 
with another USB peripheral.

I am not entirely sure what you mean by which can core I am using but if 
it helps i am opening the socket as follows :

     sock = socket(PF_CAN,SOCK_RAW,CAN_RAW);

in a small standalone test application which I wrote after having 
difficulty with our main application.

I am using custom hardware/firmware and am using the kernel module found 
here : https://github.com/fabiobaltieri/open-usb-can
though it has a small change to stop the net queue at the top of 
open_usb_can_start_xmit as otherwise its prone to loosing TX packets 
when loaded.

I can see the packets coming in the correct order in wireshark and it is 
not immediately obvious to me how the kernel module could mix up the 
order, so it seems that it must be something that happens at the socket 
level?

On the top level I am using CANFestival for CANOpen implementation, so 
it has occurred to me I could implement a CANFestival "driver" using 
libusb and completely bypass the kernel module and socket can layers, 
but I hope not to have to do this.

On 08/09/15 11:01, Marc Kleine-Budde wrote:
> On 09/08/2015 11:42 AM, Daniel Squires wrote:
>> Hi all,
>>
>> new to this list.
>>
>> Just a quick question at present, when using recv on a socket that is
>> bound to a can interface, should the packets be received in the order
>> they came off the wire? or is this not guaranteed?
> Should be guaranteed. Which CAN core are you using? What's your kernel
> version?
>
> Marc
>

-- 
Dan Squires

Engineered Arts Ltd.

