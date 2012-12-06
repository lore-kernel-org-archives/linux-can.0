From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [RFC v2 0/7] pch_can/c_can: fix races and add PCH support to
 c_can
Date: Thu, 06 Dec 2012 09:17:54 +0100
Message-ID: <50C054B2.8060006@grandegger.com>
References: <1354199987-10350-1-git-send-email-wg@grandegger.com> <2955657.EIGT0HjrVV@ws-stein> <50BF4326.4040507@grandegger.com> <4250988.UdN8LQq6de@ws-stein> <50BF85DD.6090809@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:52871 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752242Ab2LFIR4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Dec 2012 03:17:56 -0500
In-Reply-To: <50BF85DD.6090809@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-can@vger.kernel.org, bhupesh.sharma@st.com, tomoya.rohm@gmail.com

On 12/05/2012 06:35 PM, Wolfgang Grandegger wrote:
> On 12/05/2012 03:46 PM, Alexander Stein wrote:
>> Hello Wolfgang,
>>
>> On Wednesday 05 December 2012 13:50:46, Wolfgang Grandegger wrote:
>>> Hi Alexander,
>>>
>>> thanks for testing!. Maybe we deal with more than one problem.
>>>
> ...
>>> A few general questions to understand your hardware and setup:
>>>
>>> - Is this a multi-processor system (SMP)? If not, you may not run into
>>>   tx-not-working-any-more problem. Have you ever realized it?
>>
>> This is a Intel E660 single core CPU with HT, so it is a SMP system. I'm 
>> currently not aware that tx is not working anymore.
> 
> OK, your send rate is very low and therefore it's unlikely that you hit
> that problem.
> 
>>> - Did you see the problems below with the old PCH_CAN driver as well.
>>>
>>> - Do the problems show up with the still existing PCH_CAN driver
>>>   (including the "pch_can: add spinlocks to protect tx objects" patch)?
>>
>> With the current version of pch_can from Linuxs' tree and the named patch I 
>> get at least some messaged twice.
> 
> OK, sounds better but also not good.
> 
>>>> but if I run my heavy CAN load testcase I get errors sometimes.
>>>> This test works as follows: I send a CAN message to 2 other CAN nodes 
>>>> configuring some timings (like burst length or time between each can 
>> frame) 
>>>> and they send 250000 messages each containing a counter. This way I can 
>> detect 
>>>> any missing or switched message with a high bus load.
>>>> If I use the described software state alone it works, but if I run 'watch 
>>>> sensors' in a different ssh session, CAN start to misbehave like missing 
>> CAN 
>>>> frames or switched order. It seems that I2C usage on the PCH influences 
>> the 
>>>> CAN part also:
>>>
>>> - When your app sends/writes messages, does it check for errno==ENOBUFS?
>>
>> My test application sends only 1 message each test run to start the other 
>> nodes. It checks ENOBUFS and returns an error in that case. Though I've never 
>> seen that.
> 
> OK, your TX rate it low.
> 
>>
>>> - The messages look still ok (not currupted, I mean)?
>>
>> The received frames all look good (despite wrong counter sometimes due to 
>> wrong order or lost frames).

Could you show use the sequence of the lost, duplicated and out-of-order
messages in the format:

received-sequence number: sent-sequence-number-in-the-can-data

Maybe we can see a pattern.

Thanks,

Wolfgang.
