From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [Socketcan-users] AM335x CAN/D_CAN
Date: Wed, 23 May 2012 10:40:09 +0200
Message-ID: <4FBCA269.70306@grandegger.com>
References: <CAHvj1qbb9YJSBLZc1bG6MpEJcjPUtr+37wn3iJUNm_OmpH2SgA@mail.gmail.com> <4FBBE272.5020807@grandegger.com> <331ABD5ECB02734CA317220B2BBEABC13E9C2E10@DBDE01.ent.ti.com> <4FBC8B5D.7000302@grandegger.com> <4FBC8C25.3050107@pengutronix.de> <4FBC9A75.7020208@grandegger.com> <331ABD5ECB02734CA317220B2BBEABC13E9C44C9@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:41935 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134Ab2EWIkV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 23 May 2012 04:40:21 -0400
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13E9C44C9@DBDE01.ent.ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, bruce bushby <bruce.bushby@gmail.com>, Linux-CAN <linux-can@vger.kernel.org>

On 05/23/2012 10:27 AM, AnilKumar, Chimata wrote:
> Hi Wolfgang,
> 
> On Wed, May 23, 2012 at 13:36:13, Wolfgang Grandegger wrote:
>> On 05/23/2012 09:05 AM, Marc Kleine-Budde wrote:
>>> On 05/23/2012 09:01 AM, Wolfgang Grandegger wrote:
>>>> On 05/23/2012 08:56 AM, AnilKumar, Chimata wrote:
>>>>> Hi Wolfgang,
>>>>>
>>>>> On Wed, May 23, 2012 at 00:31:06, Wolfgang Grandegger wrote:
>>>>>> Hello,
>>>>>>
>>>>>> I switched the discussion to the new Linux-CAN mailing list.
>>>>>>
>>>>>> On 05/22/2012 05:50 PM, bruce bushby wrote:
>>>>>>> Greetings
>>>>>>>
>>>>>>> I'm hoping a list member would be so kind as to offer some basic
>>>>>>> explanations of how one would use the CAN bus provided by AM335x. I
>>>>>>> understand Linux, but struggle with electronics.
>>>>>>>
>>>>>>> I have read this discussion: http://comments.gmane.org/gmane.linux.can/1142
>>>>>>> What is the difference between C_CAN and D_CAN?
>>>>>>
>>>>>> As I see it, the D_CAN is a more advanced variant of the C_CAN
>>>>>> controller. See also:
>>>>>>
>>>>>> http://www.semiconductors.bosch.de/en/ipmodules/can/canipmodules/c_can/c_can.asp
>>>>>> http://www.semiconductors.bosch.de/en/ipmodules/can/canipmodules/d_can/d_can.asp
>>>>>>
>>>>>> Patches to add D_CAN support to the Linux-CAN C_CAN driver have been
>>>>>> posted recently for mainline inclusion and are currently reviewed.
>>>>>
>>>>> Is there a possibility of pushing my driver into 3.5 kernel?
>>>>
>>>> Yes, I think we should push it forward, even if the C_CAN part remains
>>>> untested for the moment. IIRC, the patch series is already in a good
>>>> shape. I personally do also not have a board with a C_CAN controller at
>>>> hand. Marc, what is your opinion?
>>>
>>> I don't have any of the *_CAN hardware. But the driver looks quite good.
>>> I'm quite busy at the moment, but currently we've the merge window. I'll
>>> do a review now, anyway. Wolfgang can I have your Acked-by?
>>
>> I just tried to compile check the patches but they do not apply properly
>> :(. AnilKumar, for what kernel tree are the patches you posted? They
>> should be against David Miller's net-next tree?
> 
> I have generated the patch series with "v3.4-rc6". I can quickly spin patches with
> the latest tip

That would be nice. We need the patches against:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

Thanks,

Wolfgang.
