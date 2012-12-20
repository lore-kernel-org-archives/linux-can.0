From: Amit Virdi <amit.virdi@st.com>
Subject: Re: [PATCH 2/3] can: c_can: Provide generic interface to configure
 c-can message objects
Date: Thu, 20 Dec 2012 16:23:04 +0530
Message-ID: <50D2EE10.6090208@st.com>
References: <cover.1355996839.git.amit.virdi@st.com> <cf2aa76940e89dc91564cf4962d23e58bec432b0.1355996839.git.amit.virdi@st.com> <50D2E7DE.5030808@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from eu1sys200aog118.obsmtp.com ([207.126.144.145]:47704 "EHLO
	eu1sys200aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750809Ab2LTKxT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 20 Dec 2012 05:53:19 -0500
In-Reply-To: <50D2E7DE.5030808@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "mkl@pengutronix.de" <mkl@pengutronix.de>, Bhupesh SHARMA <bhupesh.sharma@st.com>, "anilkumar@ti.com" <anilkumar@ti.com>, spear-devel <spear-devel@list.st.com>

On 12/20/2012 3:56 PM, Wolfgang Grandegger wrote:
> On 12/20/2012 11:05 AM, Amit Virdi wrote:
>> Depending on the underlying platform, the configuration of the c-can
>> message objects can change. For e.g. in some systems, it makes more
>> sense to receive many message objects and transmit very few. In any
>> case, providing flexibility in configuring the message objects is highly
>> desirable.
>>
>> The total number of message objects for C_CAN controller is fixed at 32.
>> The receive message objects are assigned higher priority so they begin
>> with message object#1. So, in order to configure the message object the
>> driver just needs two parameters - rx_split (for differentiating between
>> lower bucket and higher bucket) and tx_num.
>
> What is your motivation to make this configurable?
> Why is the current default not good enough?

By default the number of receive message objects is kept equal to the 
number of transmit message objects (16). However, we had some practical 
use cases in which it was expected that the controller would receive 
more number of message objects than it would transmit. The current 
configuration didn't result in an efficient behavior. Maybe, Bhupesh can 
elaborate this point in more detail.

>
>> However, if the user doesn't specify these parameters, then the message
>> objects are configured with default parameters with equal distribution
>> of receive and transmit message objects (16 each).
>>
>> Signed-off-by: Amit Virdi<amit.virdi@st.com>
>> Cc: Bhupesh Sharma<bhupesh.sharma@st.com>
>> Reviewed-by: Shiraz Hashim<shiraz.hashim@st.com>
>> ---
>>   .../devicetree/bindings/net/can/c_can.txt          |  55 ++++++++++--
>>   drivers/net/can/c_can/c_can.c                      | 100 ++++++++++++---------
>>   drivers/net/can/c_can/c_can.h                      |  16 +++-
>>   drivers/net/can/c_can/c_can_platform.c             |  47 +++++++++-
>>   4 files changed, 168 insertions(+), 50 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/net/can/c_can.txt b/Documentation/devicetree/bindings/net/can/c_can.txt
>> index 7d645cb..4ddd127 100644
>> --- a/Documentation/devicetree/bindings/net/can/c_can.txt
>> +++ b/Documentation/devicetree/bindings/net/can/c_can.txt
>> @@ -8,20 +8,25 @@ Required properties:
>>                          registers map
>>   - interrupts         : property with a value describing the interrupt
>>                          number
>> -
>>   Optional properties:
>> +
>>   - ti,hwmods          : Must be "d_can<n>" or "c_can<n>", n being the
>>                          instance number
>> +- rx_split      : Receive message objects lying in the lower bucket
>> +- tx_num        : Total number of transmit message objects
>>   - reg_alignment : Signifies register alignment. Must be either of
>>                           1. 0x8 or 0x10 - If registers are 16-bit aligned
>>                           2. 0x18 - If registers are 32-bit aligned
>>                   Default is 32-bit alignment.
>
> I would prefer "reg_alignment" in bytes. 0x4 is much more readable than
> 0x18.
>

Ok, that's true. I'll modify it in V2.

[..]

Regards
Amit Virdi
