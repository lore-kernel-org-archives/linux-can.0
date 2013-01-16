From: Amit Virdi <amit.virdi@st.com>
Subject: Re: [PATCH 2/3] can: c_can: Provide generic interface to configure
 c-can message objects
Date: Wed, 16 Jan 2013 13:15:10 +0530
Message-ID: <50F65A86.3060307@st.com>
References: <cover.1355996839.git.amit.virdi@st.com> <cf2aa76940e89dc91564cf4962d23e58bec432b0.1355996839.git.amit.virdi@st.com> <50D31ADE.1050308@pengutronix.de> <50D37154.9020107@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from eu1sys200aog118.obsmtp.com ([207.126.144.145]:42002 "EHLO
	eu1sys200aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758185Ab3APHpW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 16 Jan 2013 02:45:22 -0500
In-Reply-To: <50D37154.9020107@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Bhupesh SHARMA <bhupesh.sharma@st.com>, "anilkumar@ti.com" <anilkumar@ti.com>, spear-devel <spear-devel@list.st.com>

On 12/21/2012 1:43 AM, Wolfgang Grandegger wrote:
> On 12/20/2012 03:04 PM, Marc Kleine-Budde wrote:
>> On 12/20/2012 11:05 AM, Amit Virdi wrote:
>>> Depending on the underlying platform, the configuration of the c-can
>>> message objects can change. For e.g. in some systems, it makes more
>>> sense to receive many message objects and transmit very few. In any
>>> case, providing flexibility in configuring the message objects is highly
>>> desirable.
>>>
>>> The total number of message objects for C_CAN controller is fixed at 32.
>>> The receive message objects are assigned higher priority so they begin
>>> with message object#1. So, in order to configure the message object the
>>> driver just needs two parameters - rx_split (for differentiating between
>>> lower bucket and higher bucket) and tx_num.
>>>
>>> However, if the user doesn't specify these parameters, then the message
>>> objects are configured with default parameters with equal distribution
>>> of receive and transmit message objects (16 each).
>>
>> As Wolfgang pointed out, the DT should only describe the hardware. In
>> the ethernet world I think there is ethtool to configure the hardware.
>> Maybe we need something similar for CAN (or add CAN support to ethtool).
>
> Yeah, a simple tool using simple ioctl request would be nice, indeed.
> Well, as a per device setting seems overkill a simple module parameter
> would just do it.
>

So, you're saying to drop the device configuration from the DT and use 
some tool to do that. This would be nice if there are enough devices, 
apart from the Bosch C-CAN controller, which require this sort of 
configuration.

Regards
Amit Virdi
