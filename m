From: Bernhard Thiele <bernhard-thiele@web.de>
Subject: Re: [softing] CAN-AC PCI card
Date: Fri, 10 Aug 2012 18:35:40 +0200
Message-ID: <5025385C.3080603@web.de>
References: <trinity-fd24c49d-69e3-4dee-9d03-b9b8ac39f610-1344523228553@3capp-webde-bs20> <20120809212817.GA3194@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:52861 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752073Ab2HJQfm (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 10 Aug 2012 12:35:42 -0400
Received: from [192.168.178.30] ([85.181.77.165]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0Lo0ZA-1TfmZY2zua-00gH6f for
 <linux-can@vger.kernel.org>; Fri, 10 Aug 2012 18:35:40 +0200
In-Reply-To: <20120809212817.GA3194@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello Kurt and Marc,

Thanks for the quick reply.

On 08/09/2012 11:28 PM, Kurt Van Dijck wrote:
> [...]
> The dual port RAM interface is equal for PCI & PCMCIA devices.
> The PCMCIA driver (softing_cs.ko) only provides a platform device with the dual port RAM
> interface. And the real driver (softing.ko) uses this.
> I designed the PCMCIA driver this way to allow for share code
> with PCI cards. But I never got to writing the PCI driver
> itself since I don't need it.
>
> Adding the PCI driver should not be too hard.
> This should be possible without touching existing code.
> I may able to assist you with this.
I'm not a kernel hacker. But it would be fun to try. I will try to learn 
a bit about kernel module programming. If I see any chance to succeed, I 
will gladly come back on your offer for some assistance!
>> Best regards,
>>
>> Bernhard
> Kind regards,
> Kurt
>
/Bernhard
