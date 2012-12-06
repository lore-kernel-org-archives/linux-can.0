From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [RFC v2 0/7] pch_can/c_can: fix races and add PCH support to
 c_can
Date: Thu, 06 Dec 2012 16:15:52 +0100
Message-ID: <50C0B6A8.8080509@grandegger.com>
References: <1354199987-10350-1-git-send-email-wg@grandegger.com> <4036287.fuKZ6k5idx@ws-stein> <50C0AC38.8080405@grandegger.com> <1961952.ALL0kSyh1q@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:58672 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423776Ab2LFPPz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Dec 2012 10:15:55 -0500
In-Reply-To: <1961952.ALL0kSyh1q@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-can@vger.kernel.org, bhupesh.sharma@st.com, tomoya.rohm@gmail.com

On 12/06/2012 03:56 PM, Alexander Stein wrote:
> Hello Wolfgang,
> 
> On Thursday 06 December 2012 15:31:20, Wolfgang Grandegger wrote:
>>> diff --git a/drivers/net/can/c_can/c_can_pci.c b/drivers/net/can/c_can/c_can_pci.c
>>> index 2516ea9..0ac4d43 100644
>>> --- a/drivers/net/can/c_can/c_can_pci.c
>>> +++ b/drivers/net/can/c_can/c_can_pci.c
>>> @@ -74,13 +74,37 @@ static void c_can_pci_write_reg_aligned_to_32bit(struct c_can_priv *priv,
>>>  static u16 c_can_pci_read_reg_32bit(struct c_can_priv *priv,
>>>                                     enum reg index)
>>>  {
>>> -       return (u16)ioread32(priv->base + 2 * priv->regs[index]);
>>> +       unsigned long flags;
>>> +       u16 reg;
>>> +
>>> +       spin_lock_irqsave(&priv->testlock, flags);
>>> +       reg = (u16)ioread32(priv->base + 2 * priv->regs[index]);
>>> +       spin_unlock_irqrestore(&priv->testlock, flags);
>>> +
>>> +       return reg;
>>>  }
>>>  
>>>  static void c_can_pci_write_reg_32bit(struct c_can_priv *priv,
>>>                                       enum reg index, u16 val)
>>>  {
>>> -       iowrite32((u32)val, priv->base + 2 * priv->regs[index]);
>>> +       u16 reg;
>>> +       unsigned long flags;
>>> +       int retries;
>>> +
>>> +       retries = 0;
>>> +
>>> +       spin_lock_irqsave(&priv->testlock, flags);
>>> +
>>> +       do
>>> +       {
>>> +               iowrite32((u32)val, priv->base + 2 * priv->regs[index]);
>>
>> I think it's enough to write the message once.
> 
> I can reply to this one immediatly. Not it is not sufficent to write once. This was my 1st implementation (iowrite32 just above the do) and noticed in case the write doesn't succeed I won't succeed until all ioread32 have passed. IMO I must write again if it failed before.

Puh, even worse. Then I'm really surprised that the driver continues to
work more or less properly. Anyway, sometime it takes up to 500+ us for
the good value to show up. If we have a real write-read sequence to the
same register, everything can happen. Looks like broken hardware.

Wolfgang.




