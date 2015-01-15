From: Tom Evans <tom_usenet@optusnet.com.au>
Subject: Re: c_can: (newbie) high system load when frame not acked?
Date: Thu, 15 Jan 2015 11:29:34 +1100
Message-ID: <54B709EE.2040602@optusnet.com.au>
References: <9c72f211-becc-4c0f-94f6-0700dfb1195e@GRBSR0089.marel.net> <alpine.DEB.2.02.1501121751530.28201@login> <1735533.0yOonAfCy1@heinz> <alpine.DEB.2.02.1501121948370.28201@login> <54B472B2.4010300@optusnet.com.au> <alpine.DEB.2.02.1501131523290.12789@login> <20150113153243.26859.47218@shannon> <54B5C7F2.3060702@optusnet.com.au> <20150114095504.16836.68273@shannon>
Reply-To: tom_usenet@optusnet.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:35200 "EHLO
	mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751952AbbAOA3i (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 14 Jan 2015 19:29:38 -0500
In-Reply-To: <20150114095504.16836.68273@shannon>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>, Viktor Babrian <babrian.viktor@renyi.mta.hu>
Cc: linux-can@vger.kernel.org

On 14/01/15 20:55, Andri Yngvason wrote:
> Quoting Tom Evans (2015-01-14 01:35:46)
>> On 14/01/15 02:32, Andri Yngvason wrote:
>>> Quoting Viktor Babrian (2015-01-13 15:10:29)
>>>
>>> Note: The FlexCAN driver does actually respect berr-reporting for i.MX6.
>>> However, it does not respect it for some older chips.
>>
>> The flexcan.c driver behaves differently depending on whether it has
>> "FLEXCAN_HAS_BROKEN_ERR_STATE" set (on for MX25, MX35, MX53 and off for MX28
>> and MX6). I don't think this distinction actually helps, or improves matters
>> enough to be worth the CPU loading this causes in these disconnected/solo CAN
>> states.
>>
> I agree.
>
>> ...
>> Does "FLEXCAN_HAS_BROKEN_ERR_STATE" do anything useful that I've missed? If
>> not then that code should be removed. I've done that in the old (Linux 3.4)
>> version of the driver I'm using.
>>
> The first step towards making that change is posting patches. ;)

Of course. But I'm working on a Linux 3.4 code base that was "frozen" about 15 
linux versions ago. I can only generate AND TEST patches for that version. 
There have been at least 19 mainstream releases/changes to that code since 
that time.

I could generate an untested patch for a later version, but I'd rather not. 
I'd rather someone who can test the code do this on the current codebase.

I would propose one of:

1 - Remove ".features = FLEXCAN_HAS_BROKEN_ERR_STATE," from all structures 
referencing all chips, like "fsl_p1010_devtype_data". That would be misleading 
though and would make the code more confusing than it is (and it is bad enough 
at the moment).

2 - Leave "FLEXCAN_HAS_BROKEN_ERR_STATE" for the chips where the WARNING 
interrupt doesn't work, but don't DO anything as a consequence. That means 
changing the following to ONLY set the error mask on 
"CAN_CTRLMODE_BERR_REPORTING" - removing the condition at line 942:

937         /*
938          * enable the "error interrupt" (FLEXCAN_CTRL_ERR_MSK),
939          * on most Flexcan cores, too. Otherwise we don't get
940          * any error warning or passive interrupts.
941          */
942         if (priv->devtype_data->features & FLEXCAN_HAS_BROKEN_ERR_STATE ||
943             priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
944                 reg_ctrl |= FLEXCAN_CTRL_ERR_MSK;
945         else
946                 reg_ctrl &= ~FLEXCAN_CTRL_ERR_MSK;

The comment in the above is very misleading. "Error Interrupts" have nothing 
to do with "FLEXCAN_HAS_BROKEN_ERR_STATE". Neither does "passive" as no 
FlexCAN cores can generate "passive interrupts". Some cores can generate 
"warning", but that's a useless interrupt as it doesn't do anything useful.

It should only say the error interrupts are enabled for 
CAN_CTRLMODE_BERR_REPORTING. For "historical interest" it could say that 
"FLEXCAN_HAS_BROKEN_ERR_STATE" used to set the error interrupts, but it causes 
interrupt flooding and can't fix the "state tracking" anyway.

Tom Evans

