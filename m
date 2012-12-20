From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 2/3] can: c_can: Provide generic interface to configure
 c-can message objects
Date: Thu, 20 Dec 2012 21:13:08 +0100
Message-ID: <50D37154.9020107@grandegger.com>
References: <cover.1355996839.git.amit.virdi@st.com> <cf2aa76940e89dc91564cf4962d23e58bec432b0.1355996839.git.amit.virdi@st.com> <50D31ADE.1050308@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:40902 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630Ab2LTUNS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 20 Dec 2012 15:13:18 -0500
In-Reply-To: <50D31ADE.1050308@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Amit Virdi <amit.virdi@st.com>, linux-can@vger.kernel.org, bhupesh.sharma@st.com, anilkumar@ti.com, spear-devel@list.st.com

On 12/20/2012 03:04 PM, Marc Kleine-Budde wrote:
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
>>
>> However, if the user doesn't specify these parameters, then the message
>> objects are configured with default parameters with equal distribution
>> of receive and transmit message objects (16 each).
> 
> As Wolfgang pointed out, the DT should only describe the hardware. In
> the ethernet world I think there is ethtool to configure the hardware.
> Maybe we need something similar for CAN (or add CAN support to ethtool).

Yeah, a simple tool using simple ioctl request would be nice, indeed.
Well, as a per device setting seems overkill a simple module parameter
would just do it.

Wolfgang.

