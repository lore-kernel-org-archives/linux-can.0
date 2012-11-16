From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: pch_can: Data transmission stops after dropped packet
Date: Fri, 16 Nov 2012 20:39:19 +0100
Message-ID: <50A69667.4060307@grandegger.com>
References: <loom.20121114T160521-534@post.gmane.org> <50A4972A.9070707@hartkopp.net> <50A4EA87.9020206@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:45747 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753193Ab2KPTjY (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 16 Nov 2012 14:39:24 -0500
In-Reply-To: <50A4EA87.9020206@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Michael Pellegrini <mikep86@gmail.com>, linux-can@vger.kernel.org, tomoya.rohm@gmail.com, Bhupesh SHARMA <bhupesh.sharma@st.com>, Alexander Stein <alexander.stein@systec-electronic.com>, federico.vaga@gmail.com, Giancarlo Asnaghi <giancarlo.asnaghi@st.com>

Hi Oliver,

On 11/15/2012 02:13 PM, Wolfgang Grandegger wrote:
> On 11/15/2012 08:18 AM, Oliver Hartkopp wrote:
>> On 14.11.2012 16:39, Michael Pellegrini wrote:
>>
>>
>>> I am trying to use the pch_can driver to interface with a CANopen system.
>>> I am encountering a serious issue where, at random intervals, the CAN interface
>>> will lock up and stop transmitting data.  Data reception continues normally.
>>> The only way I've found to resolve the issue so far is to issue an
>>> "ifconfig canx down" command followed by an "ifconfig canx up" command.
>>> After the interface is reset through these commands, the TX packet dropped count
>>> and the TX packet carrier count increment by 1.
>>>
>>> I am running Ubuntu 12.04 with kernel version 3.2.0-23.
>>>
>>> Has anyone else seen this problem or have a fix for it?
>>
>>
>> Hello Mike,
>>
>> i put the relevant people into CC that probably know better than me.
>>
>> Btw. using the pch_can driver:
>>
>> 1. Can you please provide the output of 
>>
>> 	ip -details link show can0
>>
>> (if can0 is your device with the problem)
>> at start time and when the problem happened?
>>
>> 2. Can you send the output of
>>
>> 	candump can0,0~0,#FFFFFFFF -e
>>
>> from start time until the problem happens?
>>
>> 3. It turned out that the pch_can controller is created upon the C_CAN
>> CAN controller IP-core. Therefore Wolfgang posted an idea to replace the
>> pch_can driver with a PCI-attached C_CAN driver:
>>
>> http://thread.gmane.org/gmane.linux.can/815
>>
>> I don't know the current state of the tests/replacement.
> 
> As you can see from this thread, the replacement patch did not yet
> succesfully run on such a platform. But I definitively would like to get
> rid of the obsolete pch_can driver. Testers are welcome! Michael, would
> you be able/willing to test a patch, even with a recent kernel version?
> 
>> But a general C_CAN PCI driver has been contributed by Frederico Vaga which
>> became a mainline driver in June
>>
>> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commitdiff;h=5b92da0443c2585e31b64e86c2e1b8e22845d4bb
>>
>> Don't know if this driver can be used out of the box, when the PCI IDs of the
>> PCH_CAN board are added ...
>>
>> But maybe the guys in CC know ;-)
> 
> You need a PCI driver first.

Well, as you pointed out, there is already a PCI driver for the
[CD]_CAN... I totally forgot. That's already a good starting point and
as it already does support 32-bit alignment there should not be too much
missing. I'm going to prepare a patch for the PCH_CAN for Michael.

Wolfgang.


