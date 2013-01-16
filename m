From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 2/3] can: c_can: Provide generic interface to configure
 c-can message objects
Date: Wed, 16 Jan 2013 10:01:56 +0100
Message-ID: <50F66C84.9040007@grandegger.com>
References: <cover.1355996839.git.amit.virdi@st.com> <cf2aa76940e89dc91564cf4962d23e58bec432b0.1355996839.git.amit.virdi@st.com> <50D31ADE.1050308@pengutronix.de> <50D37154.9020107@grandegger.com> <50F65A86.3060307@st.com> <D5ECB3C7A6F99444980976A8C6D896384FB6170303@EAPEX1MAIL1.st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:37704 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758088Ab3APJCI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 16 Jan 2013 04:02:08 -0500
In-Reply-To: <D5ECB3C7A6F99444980976A8C6D896384FB6170303@EAPEX1MAIL1.st.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Bhupesh SHARMA <bhupesh.sharma@st.com>
Cc: Amit VIRDI <Amit.VIRDI@st.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "anilkumar@ti.com" <anilkumar@ti.com>, spear-devel <spear-devel@list.st.com>

On 01/16/2013 09:25 AM, Bhupesh SHARMA wrote:
> 
> 
>> -----Original Message-----
>> From: Amit VIRDI
>> Sent: Wednesday, January 16, 2013 1:15 PM
>> To: Wolfgang Grandegger
>> Cc: Marc Kleine-Budde; linux-can@vger.kernel.org; Bhupesh SHARMA;
>> anilkumar@ti.com; spear-devel
>> Subject: Re: [PATCH 2/3] can: c_can: Provide generic interface to configure c-
>> can message objects
>>
>> On 12/21/2012 1:43 AM, Wolfgang Grandegger wrote:
>>> On 12/20/2012 03:04 PM, Marc Kleine-Budde wrote:
>>>> On 12/20/2012 11:05 AM, Amit Virdi wrote:
>>>>> Depending on the underlying platform, the configuration of the c-can
>>>>> message objects can change. For e.g. in some systems, it makes more
>>>>> sense to receive many message objects and transmit very few. In any
>>>>> case, providing flexibility in configuring the message objects is
>>>>> highly desirable.
>>>>>
>>>>> The total number of message objects for C_CAN controller is fixed at 32.
>>>>> The receive message objects are assigned higher priority so they
>>>>> begin with message object#1. So, in order to configure the message
>>>>> object the driver just needs two parameters - rx_split (for
>>>>> differentiating between lower bucket and higher bucket) and tx_num.
>>>>>
>>>>> However, if the user doesn't specify these parameters, then the
>>>>> message objects are configured with default parameters with equal
>>>>> distribution of receive and transmit message objects (16 each).
>>>>
>>>> As Wolfgang pointed out, the DT should only describe the hardware. In
>>>> the ethernet world I think there is ethtool to configure the hardware.
>>>> Maybe we need something similar for CAN (or add CAN support to
>> ethtool).
>>>
>>> Yeah, a simple tool using simple ioctl request would be nice, indeed.
>>> Well, as a per device setting seems overkill a simple module parameter
>>> would just do it.
>>>
>>
>> So, you're saying to drop the device configuration from the DT and use some
>> tool to do that. This would be nice if there are enough devices, apart from
>> the Bosch C-CAN controller, which require this sort of configuration.
>>
> 
> Indeed. It would make sense to put this type of configuration in the IPROUTE2 tool so that such
> changes can be performed by the user himself using the IP tool. But with the other CAN controllers having
> different management techniques (some using Message Objects, while the others using FIFO based designs),
> it would be difficult to maintain a generic interface in IP tool for the same.

Yep. Using iproute2 for this purpose is definitely overkill. It should
be used for generic *per-device* CAN configuration.

> 
> Or am I missing something here? Please let us know your views on the same.

Why not using a simple module parameter as I already suggested. A good
default would make 99% of the user happy. The remaining 1% is free to
fiddle with these module parameters.

Wolfgang.

