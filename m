From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [RFC/PATCH] c_can: add driver for the PCH CAN controller
Date: Mon, 12 Mar 2012 18:53:40 +0100
Message-ID: <4F5E3824.3050401@grandegger.com>
References: <4F44E640.8010708@grandegger.com> <2646233.lgKcZ8lAQj@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:36670 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499Ab2CLRxn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 12 Mar 2012 13:53:43 -0400
In-Reply-To: <2646233.lgKcZ8lAQj@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Linux-CAN <linux-can@vger.kernel.org>, "bhupesh.sharma" <bhupesh.sharma@st.com>, Tomoya MORINAGA <tomoya.rohm@gmail.com>

Hi Alexander,

On 03/07/2012 08:31 AM, Alexander Stein wrote:
> Hello Wolfgang,
> 
> Am Mittwoch, 22. Februar 2012, 13:57:36 schrieb Wolfgang Grandegger:
>> For maintenance reasons, this diver should replace the "pch_can" driver
>> sooner than later as it uses the same CAN controller core. I named it
>> "pch_pci". Maybe "pch_can" would be more appropriate (common). This
>> patch is for 2.6.39, but likely it applies fine also to more recent
>> versions of the Linux kernel.
>>
>> Alexander, Tomoya, or anybody else, it would be nice if you could test
>> this patch and give some feedback. Thanks.
> 
> Unfortunately this doesn't work, yet. I do get a can0 interface but I don't 
> receive/send messages actually to the bus. I disabled pch_can in the kernel 
> config and enabled CONFIG_CAN_C_CAN and CONFIG_CAN_C_CAN_PCH_PCI
> All messages containging "can" (related to CAN) I get in dmesg are:
> [    0.338083] CAN device driver interface                                                                                                                                                                           
> [    0.339059] pch_pci 0000:02:0c.3: can0: Features changed: 0x00004804 -> 
> 0x00004004                                                                                                                                
> [    0.827528] can: controller area network core (rev 20090105 abi 8)                                                                                                                                                
> [    0.827646] can: raw protocol (rev 20090105)                                                                                                                                                                      
> [    9.773280] pch_pci 0000:02:0c.3: can0: setting BTR=2504 BRPE=0000


Hm, the accessor functions are untested and might be wrong and the
driver does not verify register acessibility. The following looks better: 

static u16 pch_pci_read_reg(struct c_can_priv *priv, void *reg)
{
	u32 __iomem *addr = reg + (long)reg - (long)priv->regs;

	return (u16)ioread32(addr);
}

static void pch_pci_write_reg(struct c_can_priv *priv, void *reg, u16 val)
{
	u32 __iomem *addr = reg + (long)reg - (long)priv->regs;

	iowrite32((u32)val, addr);
}


> I also noted that my system does noot reboot when using "reboot". This works 
> fine when using pch_can.

Hm, strange.

> Unfortunately I can't spend more time on testing this at the moment.

OK. Thanks for your effort.

Wolfgang.
