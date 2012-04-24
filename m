From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 3/3] can: c_can: Add support for Bosch D_CAN controller
Date: Tue, 24 Apr 2012 14:25:39 +0200
Message-ID: <4F969BC3.1000501@grandegger.com>
References: <1334915902-30253-1-git-send-email-anilkumar@ti.com> <4F965FF6.2020201@pengutronix.de> <4F9664E9.6000403@grandegger.com> <4F96660A.1030408@pengutronix.de> <4F966EDF.7010909@grandegger.com> <331ABD5ECB02734CA317220B2BBEABC13E997D6B@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:41792 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854Ab2DXM0J (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 24 Apr 2012 08:26:09 -0400
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13E997D6B@DBDE01.ent.ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "Gole, Anant" <anantgole@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>

On 04/24/2012 01:42 PM, AnilKumar, Chimata wrote:
> On Tue, Apr 24, 2012 at 14:44:07, Wolfgang Grandegger wrote:
>> On 04/24/2012 10:36 AM, Marc Kleine-Budde wrote:
>>> On 04/24/2012 10:31 AM, Wolfgang Grandegger wrote:
>>>> On 04/24/2012 10:10 AM, Marc Kleine-Budde wrote:
>>>>> On 04/20/2012 11:58 AM, AnilKumar Ch wrote:
>>>>>> This patch adds the support for D_CAN controller driver to the existing
>>>>>> C_CAN driver.
>>>>>>
>>>>>> Bosch D_CAN controller is a full-CAN implementation which is compliant
>>>>>> to CAN protocol version 2.0 part A and B. Bosch D_CAN user manual can be
>>>>>> obtained from: http://www.semiconductors.bosch.de/media/en/pdf/
>>>>>> ipmodules_1/can/d_can_users_manual_111.pdf
>>>>>>
>>>>>> The following are the design choices made while adding D_CAN to C_CAN
>>>>>> driver:
>>>>>> A new overlay structure is added for d_can controller and care is taken
>>>>>> to make sure its member names match with equavalent c_can structure
>>>>>> members (even if the d_can specification calls them slightly differently).
>>>>>> Note that d_can controller has more registers, so structure members of
>>>>>> d_can are more than those in c_can.
>>>>>>
>>>>>> A new set if read/write macros are used to access the registers common
>>>>>> between c_can and d_can. To get the basic d_can functionality working
>>>>>> it is sufficient to access just these registers.
>>>>>
>>>>> I don't like macros. I've two further possible solutions:
>>>>
>>>> Yes, I don't like that part either, also because of the
>>>>
>>>>   "if (priv->dev_type == DEV_TYPE_D_CAN)"
>>>>
>>>> for each read/write access.
>>>>
>>>>> a) Access the registers via an array. The array index is a "virtual"
>>>>>    register, the array's value the physical offset within the c_can or
>>>>>    d_can controller.
>>>>
>>>> I was thinking about that as well but using absolute addresses. This
>>>> would avoid further calculations for 16/32 bit aligned accesses.
>>>
>>> Yes, this way we might get rid of this calculation, too.
>>>
> 
> Okay. I can spin a patch with this approach. The reason I took the current
> approach is because I did not want to shift the existing code from an overlay
> structure to an array based approach.
> 
>>>>> b) AFAICS you need more than three registers to get the CAN core
>>>>>    working. Another possibility is to implement an accessor function
>>>>>   for each register.
>>>>
>>>> ... offsetof() might be useful for this approach.
>>>
>>> Please elaborate.
>>
>> #define c_can_write_reg_func(member) \
>> 	static inline void write_##reg(struct c_can_priv *priv, u32 val) \
> 
> You mean "write_##member" here?

Yep, s/member/reg/.

>> 	{ \
>> 		priv->write_reg(priv, offsetof(struct c_can_regs, member), val); \
>> 	}
>>
>> And similar for read and d_can. Then in the init part:
>>
>> 	if (priv->dev_type == DEV_TYPE_C_CAN) {
>> 		c_can_write_reg_func(control);
>> 		c_can_write_reg_func(status);
>> 		...
>> 	} else {
>> 		d_can_write_reg_func(control);
>> 		d_can_write_reg_func(status);
>> 		...
>> 	}
>>
>> Maybe we could even get rid of priv->write_reg (for memory mapped i/o only!).
> 
> As per my understanding the scope of these inline function definitions is within the
> if-else construct. Once defined within the if-else, I cannot see how these functions
> will be used elsewhere in the code (must be missing something?).

Well, declaring the functions at run-time is nonsense. We would need a
table/array or something similar to your macros anyway ==> forget it.

Wolfgang.
