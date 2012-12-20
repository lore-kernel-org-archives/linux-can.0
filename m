From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 2/3] can: c_can: Provide generic interface to configure
 c-can message objects
Date: Thu, 20 Dec 2012 12:12:30 +0100
Message-ID: <50D2F29E.6010703@grandegger.com>
References: <cover.1355996839.git.amit.virdi@st.com> <cf2aa76940e89dc91564cf4962d23e58bec432b0.1355996839.git.amit.virdi@st.com> <50D2E7DE.5030808@grandegger.com> <50D2EE10.6090208@st.com> <D5ECB3C7A6F99444980976A8C6D896384FB4C296A6@EAPEX1MAIL1.st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:35779 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752202Ab2LTLMf (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 20 Dec 2012 06:12:35 -0500
In-Reply-To: <D5ECB3C7A6F99444980976A8C6D896384FB4C296A6@EAPEX1MAIL1.st.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Bhupesh SHARMA <bhupesh.sharma@st.com>
Cc: Amit VIRDI <Amit.VIRDI@st.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "anilkumar@ti.com" <anilkumar@ti.com>, spear-devel <spear-devel@list.st.com>

On 12/20/2012 12:06 PM, Bhupesh SHARMA wrote:
>> On 12/20/2012 3:56 PM, Wolfgang Grandegger wrote:
>>> On 12/20/2012 11:05 AM, Amit Virdi wrote:
>>>> Depending on the underlying platform, the configuration of the c-can
>>>> message objects can change. For e.g. in some systems, it makes more
>>>> sense to receive many message objects and transmit very few. In any
>>>> case, providing flexibility in configuring the message objects is
>>>> highly desirable.
>>>>
>>>> The total number of message objects for C_CAN controller is fixed at 32.
>>>> The receive message objects are assigned higher priority so they
>>>> begin with message object#1. So, in order to configure the message
>>>> object the driver just needs two parameters - rx_split (for
>>>> differentiating between lower bucket and higher bucket) and tx_num.
>>>
>>> What is your motivation to make this configurable?
>>> Why is the current default not good enough?
>>
>> By default the number of receive message objects is kept equal to the
>> number of transmit message objects (16). However, we had some practical
>> use cases in which it was expected that the controller would receive more
>> number of message objects than it would transmit. The current configuration
>> didn't result in an efficient behavior. Maybe, Bhupesh can elaborate this
>> point in more detail.
>>
> 
> Yes. We actually had this requirement from one of our customer whose use-case involved
> the SPEAr MPU to be a master controlling a processing line having a number of CAN devices. In such a case
> there was a specific requirement to have more Rx objects than Tx ones.

OK.

> I believe this is a good feature to keep, otherwise we always have the default option of 
> having equal msg objects for Tx and Rx purposes (16 each).

We need to improve the RX handling anyway similar to Marc's at91_can
driver. There 24 objects are used for RX and 8 for TX.

Wolfgang.

